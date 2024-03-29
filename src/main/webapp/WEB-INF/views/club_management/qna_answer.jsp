<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>개인 게시판</title>
    <!-- 제이쿼리 -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
   	<%--  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lightbox.min.css"> --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
        crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/assets/css/layout.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/manager_page.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/color_code/color${club.colorType}.css" rel="stylesheet" type="text/css" />

    <!--모달-->
</head>

<body>
	<!-- 상단 내비게이션 바 -->
	<div class="ly-head-container">
		<header>
			<c:import url="/WEB-INF/views/include/nav.jsp"></c:import>
		</header>
	</div>
    <!-- // 상단 내비게이션 바 -->
    
    <!-- 중간 콘텐츠 -->
    <div class="ly-body-container ">
		<div class="main">
			<div class="main-content">
				<div class="diary-area" data-memid = "${member.memberId}" data-clubid ="${club.clubId}">
				
				
					<div class="diary-topbar">
						<img class="diary-topbar-img" src="${pageContext.request.contextPath}/upload/clubimg/${club.img2}" alt="프로필사진" />
						<h2>${club.clubName}</h2>
  										
						
					</div>		
					<!-- //diary-topbar -->
					
	
					<div class="manager-body">					
						<!-- 개인별코딩 ---------------------------------------------------------------->
						<div class= "topbar">
							<div class= "menu-btn-area">
								<a class="ct-color" href = "${pageContext.request.contextPath}/management/club/${club.clubId}">가입승인</a>
								<a class="ct-color"  href = "${pageContext.request.contextPath}/management/club/editgrade/${club.clubId}">권한설정</a>
								<a class="ct-color"  href = "${pageContext.request.contextPath}/management/club/qna/${club.clubId}">문의답변</a>
								<a class="ct-color"  href = "${pageContext.request.contextPath}/management/club/edit/${club.clubId}">정보수정</a>
							</div>
						</div>
						
						<div class= "list-area"><!-- AJAX로 게시글 그릴 공간 -->
						
						</div>
						
						<div id = "board-get"></div><!-- 무한 스크롤 감시용 div -->
						<!-- 개인별코딩 ---------------------------------------------------------------->
					</div>
				
				</div>
				<!--/diary-area-->	
			</div>
			<!-- //main-content -->
			
			<div class="side-menu">
				<c:import url="/WEB-INF/views/include/side_nav_update.jsp"></c:import>
			</div>
		</div>
		<!-- container -->
	</div>
    <!-- //중간 콘텐츠 -->
    
    
    <!--/wrap-->

        <!-- 모달창 -->
    	  <div class="modal fade" id="qna-modal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document" style="max-width: 900px;">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h5 class="modal-title" id="imageModalLabel">답변하기</h5>
	        </div>
	        <div class="modal-body">
	          <!-- 이미지가 표시될 곳 -->
			  <div class= "qna-answer-area">
				<textarea class= "qna-answer" id = "qna-answer"></textarea>
			  </div>
	          <!-- 수정 , 취소 버튼-->
	          <div class= "edit-modal-btn-area">
	          <button id="answer-insert-btn" class="btn">답변</button>
	          <button id="cancel-btn" class="btn">취소</button>
	          </div>
	          <span id="likeCount"></span>
	        </div>
	      </div>
	    </div>
	  </div>
    <!-- 모달창 -->
    
    
</body>



<script>


	



/* 무한 스크롤용 JS */
 
 
/*document load*/
 
 	//board 불러오기 위한 rownum 
	let startNum = 1;
	let endNum = 10;
	

	/*무한 스크롤 감지*/
	const lastBoard = $('#board-get');    
    const lastBoardObserver = new IntersectionObserver((entries) => {
        const lastEntry = entries[entries.length - 1];
        if (!lastEntry.isIntersecting) return;

        console.log("데이터 가져오기");
        getData();
        
    });
	//감시하는 객체
    lastBoardObserver.observe(lastBoard[0]);

	
	//모달창 닫는 이벤트
	$('#cancel-btn').on("click", function(){
		$('#qna-modal').modal('hide');
		$('.qna-answer').val("");
	})
	//문의 등록하기 버튼 클릭
	$('.list-area').on("click",".answer-insert-btn",function(){
		var qnaNo = $(this).data('qnano');
		$('#answer-insert-btn').data('qnano',qnaNo);
		$('#qna-modal').modal('show');
		$('#qna-modal textarea').focus();
	});
	//답변 등록
	$('#answer-insert-btn').on("click", function(){
		var qnaNo = $(this).data('qnano');
		var data = $('#qna-answer').val();
		var content =	data.replace(/\n/g, "<BR>");
		
		var QnaVO ={
				qnaNo :	qnaNo,
				answerContent : content
		}
		addAnswer(QnaVO);
		checkList();
	});
	
	//답변 일정 길이 넘어가면~~
	$('#qna-answer').on("keyup",function(){
		var textLength = $(this).val();
		if(textLength.length >300){
			alert('댓글은 300자 이내로 작성해주세요.');
			textLength = textLength.slice(0,300);
	        $(this).val(textLength);
		}
	})
	
	
		function checkList(){
		console.log("checkList()");
		 var hasClass = $(".list-area .mem-info").length > 0;
		 if(!hasClass){
			 noData();
		 }
		 
	}
	
	
	//QNA 에 답변 등록
	function addAnswer(QnaVO){
			
		
		$.ajax({
		       
		       //요청 세팅
		       url : "${pageContext.request.contextPath}/management/club/qnaanswer",
		       type : "post",
		       data : QnaVO,
		       
		       //응답 세팅
		       dataType : "json",
		       success : function(jsonResult){
		    	   var data = jsonResult.data;
		    	   if(data==true){
		    		   alert('답변등록이 완료되었습니다.');
		    		   $('#qna-modal').modal('hide');
		    		   $('.qna-answer').val("");
		    		   $('#c' + QnaVO.qnaNo).remove();
		    		   checkList();
		    	   }
					
		       }, //success end
		       error : function(XHR, status, error) {
		       console.error(status + " : " + error);
		       }
						            
		    });//ajax end
		}
	
	
	//가입요청한 유저 목록 볼 수 있는 
	function getData(){
		console.log("getData()");
		var clubId = $('.diary-area').data('clubid');
	
		var MemberVo = {
				clubId : clubId,
				startNum : startNum,
				endNum : endNum
		}
		
		
		console.log(MemberVo + '에이젝스로 넘어갈 값 확인' + clubId);
		 $.ajax({
		       
		       //요청 세팅
		       url : "${pageContext.request.contextPath}/management/club/qnalist",
		       type : "post",
		       data : MemberVo,
		       
		       //응답 세팅
		       dataType : "json",
		       success : function(jsonResult){
		    	   
		    	   var qnaList = jsonResult.data;
					if(qnaList.length > 0){
						render(qnaList);
						startNum +=10;
						endNum += 10;
					}
					
					//전체갯수를 파악
					checkList();
					
		       }, //success end
		       error : function(XHR, status, error) {
		       console.error(status + " : " + error);
		       }
						            
		    });//ajax end
	}
	
	
	function noData(){
		console.log("noData()");
		var add = '';
		add += '<div class= "error-page">'
		add += '	<div>'
		add += '		<img class="error-icon" src ="${pageContext.request.contextPath}/assets/images/icon/error.png">'
		add += '	</div>'
		add += '	<div class= "clear-div">'
		add += '	</div>'
		add += '	<div>'
		add += '		<span>'
		add += '		 	<b>등록된 문의사항이 없습니다!</b>'
		add += '		</span>'
		add += '	</div>'
		add += '</div>'
		
		$('.list-area').append(add);
	}
	
	
	function render(qnaList){
		
		qnaList.forEach(function(qna) {

			var add = '';
			add +=  '<div class= "mem-info qna-info" id = "c' + qna.qnaNo  + '">'
			add += 	'	<div class= "mem-pic">'
			add +=			'<img class="diary-topbar-img11" src="${pageContext.request.contextPath}/assets/images/icon/profile.png" alt="프로필사진" />'
			add +=     '</div>';
			add += '    		<div class= "mem-deinfo">';
			add += '				<span><b>'+  qna.memberName  +'</b> <strong>@'+ qna.memberId +'</strong></span><br>';
			add += '				<textarea class= "qna-content" readOnly>'+ qna.qnaContent+'</textarea><br>';		
			add	+= '    		</div>'
			add += '    <div class= "qna-btns-area">';
			add += '			<button type ="button" class= "answer-insert-btn ct-color" data-qnano = "'+ qna.qnaNo +'">답변등록</button>';
			add += '	</div>'
			add += '</div>'
			
			
			
			$('.list-area').append(add);
		});
	}
 
 	
</script>

</html>
