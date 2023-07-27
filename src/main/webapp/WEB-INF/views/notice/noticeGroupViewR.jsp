<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>공지 에디터</title>
    <%@ include file="../include/topnav.jsp" %>
</head>
<body>

<!----------------------------------------- top Navigation ----------------------------------------->
<%@ include file="../include/nav.jsp" %>->

<div class="wrap">
      <div class="diary-area">
        <div class="diary-topbar">
          <img
            class="diary-topbar-img" src="${pageContext.request.contextPath }/assets/images/testimg/dog1.jpg" alt="프로필사진" />
          <h1>어푸어푸</h1>
        </div>
        <!--/diary-topbar-img-->
        <div class="diary-subbar">
          <h4>공지 게시판</h4>
        </div>
        <!--/diary-subbar-->
        <div class="content-area">
          <div class="content-left">

            <!-- 여기부터 작성 -->
           
            <div class="noticeform">
              <div>
                  <p class="noticetitle">${vo.title }</p>
                  <div class="noticebtn">
                    <button type="button" class="btn btn-warning" id="nlist">목록</button>
                    <button type="button" class="btn btn-success">다음글</button>
                  </div>
              </div>
              <div class="noticeprofil">
                  <img class="profileimg" src="${pageContext.request.contextPath }/assets/images/testimg/dog1.jpg" alt="">
                  <span class="username">${vo.memberId }</span>
                  <span class="userlevel">매니저</span><br>
                  <div class="userp">
                      <span class="userdate">작성일 : </span>
                      <span class="usertext">${vo.aboardDate}</span>
                      <span class="usercount">조회수 : </span>
                      <span class="usertext"></span>
                  </div>
              </div>
              <hr>
              <div>
                  <p class="noticecontent"> ${vo.boardContent}</p>
              </div>
                <table id="dataTable" data-bs-toggle="modal" data-bs-target="#vote">
					<thead>
					<tr>
	                     <th class="noticegrouplist">
	                         <p class="noticegroupname"><span>투표 제목 : </span>${vo.voteTitle}</p>
	                     </th>
	                   </tr>
	               </thead>
	               <tbody>
	                   <tr>
	                     <td class="noticegrouplist1">
	                         <p class="noticegroupname"><span>투표1 : </span>${vo.vote1}<span id="Count">${vo.vote1Cnt }</span></p>
	                         <p class="noticegroupname"><span>투표2 : </span>${vo.vote2}<span id="Count">${vo.vote2Cnt }</span></p>
	                         <p class="noticegroupname"><span>투표3 : </span>${vo.vote3}<span id="Count">${vo.vote3Cnt }</span></p>
	                         <p class="noticegroupname"><span>투표4 : </span>${vo.vote4}<span id="Count">${vo.vote4Cnt }</span></p>
	                         <p class="noticegroupname"><span>투표5 : </span>${vo.vote5}<span id="Count">${vo.vote5Cnt }</span></p>
	                         <p class="noticegroupname"><span>최소인원 : </span>${vo.totalNum}</p>
	                         <p class="noticegroupname"><span>투표종료일 : </span>${vo.finDate}</p>
	                         <p class="noticegroupname" hidden="hidden"><span>memberId : </span>${member.memberId}</p>
	                         <p class="noticegroupname" hidden="hidden"><span>aboardNo : </span>${vo.aboardNo}</p>
	                         
	                     </td>
	                 </tr>
	               </tbody>
               </table>
      		<div>
				<a class="text-dark heart" style="text-decoration-line: none;">
				<img id="heart" src="${pageContext.request.contextPath }/assets/images/icon/heart.svg">좋아요</a>
				<span class="likecount">0</span>
			</div>
      </div>  
          <!-- 여기까지 -->
      <!-- -------------------------------------------------일반투표-------------------------------------------------------->
  </div>
          <!--/content-left-->
</div>
        <!--/content-area-->
    <div class="noticereply">
       <h4 class="noticereplytitle">댓글</h4>
       <div>
           <img class="profileimg" src="${pageContext.request.contextPath }/assets/images/testimg/dog1.jpg" alt=""> 
           <span class="username">홍순이</span>
           <p class="noticereplytext"></p>
           <span class="userdate">작성일 : </span>
           <p class="usertext"></p>
       </div>
   </div>
        
</div>
      <!--/diary-area-->
      <div class="menu-bar" >
        <div class="group-profile">
          <div class="group-profile-img-area">
            <img
              class="group-profile-img"
              src="${pageContext.request.contextPath }/assets/images/testimg/dog1.jpg"
              alt="프로필사진"
            />
          </div>
          <!--/group-profile-img-area-->
        </div>
        <!--/group-profile-->
        <ul class="side-nav">
          <li>공지사항</li>
          <li>갤러리</li>
          <li>달력</li>
          <li>자유 게시판</li>
          <li>멤버</li>
          <li>가계부</li>
        </ul>
        <!--/side-nav-->
      </div>
      <!--/menu-bar-->
    </div>
    <!--/wrap-->
  </body>
  <script src="${pageContext.request.contextPath }/assets/js/imgSlider.js"></script>
  <script>
		$(document).ready(function() {
			
			// 좋아요가 있는지 확인한 값을 heartval에 저장
	        var heartval = ${vo.likeNo}
	        // heartval이 1이면 좋아요가 이미 되있는것이므로 heart-fill.svg를 출력하는 코드
	        if(heartval>0) {
	            console.log(heartval);
	            $("#heart").prop("src", "${pageContext.request.contextPath }/assets/images/icon/heart-fill.svg");
	            $(".heart").prop('name',heartval)
	        }
	        else {
	            console.log(heartval);
	            $("#heart").prop("src", "${pageContext.request.contextPath }/assets/images/icon/heart.svg");
	            $(".heart").prop('name',heartval)
	        }

		// 좋아요 버튼을 클릭 시 실행되는 코드
		console.log(${sessionScope.aboardNo});
		
	        $(".heart").on("click", function () {
	            var that = $(".heart");
	            
	            var memberId = $('#memberId').text();
	  			var aboardNo = $('#aboardNo').text();
					console.log('ㅎㅎ',memberId);
					console.log(aboardNo);
				var NoticeBoardVO ={
						memberId : memberId,
						aboardNo :  aboardNo
					}
	            
		    $.ajax({
		    	url :'${pageContext.request.contextPath }/${clubId}/notice/heart',
		        type :'POST',
		        data : NoticeBoardVO,
		    	success : function(data){
		    		that.prop('name',data);
		        	if(data==1) {
		            	     $('#heart').prop("src","${pageContext.request.contextPath }/assets/images/icon/heart-fill.svg");
		        	} else {
	                    	 $('#heart').prop("src","${pageContext.request.contextPath }/assets/images/icon/heart.svg");
		        	}
	             	}
		    	});
	        });
			
			$('#nlist').click(function() {
				  window.location.href = '${pageContext.request.contextPath }/${clubId }/notice/noticelist'	
			});
		});
  </script>
</html>