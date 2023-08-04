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
    <%-- <link href="${pageContext.request.contextPath}/assets/css/board2_test.css" rel="stylesheet"  type="text/css" /> --%>
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
						<img class="diary-topbar-img" src="${pageContext.request.contextPath}/assets/images/clubimg/${club.img2}" alt="프로필사진" />
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
						
						<div class= "content-box"><!-- AJAX로 게시글 그릴 공간 -->
							<div class= "club-edit-form">
								<div class= "club-edit-header">
									<h3><b>동호회 정보 수정</b></h3>
								</div>
								<!-- //club-edit-header -->
								
								
								<!-- edit form -->
								<div class="form_line"></div>
									<div>
										<form id="clubMakingForm" action="${pageContext.request.contextPath }/club/making" method="post" enctype="multipart/form-data">
											<div class="making_forms" id="clubNameForm">
		                                    	<p>모임명</p>
		                                    	<input type="text" maxlength="5" name="clubName" id="clubName" placeholder="   5글자 내로 입력해 주세요" value="" required>
		                                	</div>
		                                	<div class="making_forms" id="clubCategory">
		                                		<p>모임 분류</p>
		                                    	<ul id="categorys">
		                                    		<c:forEach  items="${cateList}" var="cate" >
		                                    			<li class="cate">
		                                            		<input type="radio" name="cateNo"  id="${cate.category}" value="${cate.cateNo}">
		                                            		<label for ="${cate.category}">${cate.category}</label>
		                                        		</li>
		                                        	</c:forEach>
		                                    	</ul>
		                                	</div>	
		                                	
		                                	
									     	<div class="making_forms" id="clubMax">
                                    			<p>정원</p>
                                    			<input type="text" id="max" name="max" value="" required>
                                    			<span>명</span>
                                			</div>

                                	<div class="making_forms" id="clubTag">
                                		<p>모임 태그</p>
                                    	<ul id="clubTags">
                                    		<c:forEach items="${tagList}" var="tag">
	                                    		<li>
	                                            	<input type="checkbox" class="club_tag" name="tagNo" value="${tag.tagNo}" id="${tag.tagNo}" data-tagname="${tag.tagName}">
	                                            	<label for="${tag.tagNo}" class="tag_label">${tag.tagName}</label>
	                                        	</li>
	                                        </c:forEach>
                                    	</ul>
                                	</div>
                      			
                                	<div class="making_forms" id="selTag"> 
										<p>선택된 태그</p>
                                    	<ul id="selectedTag">
                                    	</ul>
                                    </div>
                                    <div class="making_forms" id="clubSum">
                                    	<p>한줄소개</p>
                                    	<input type="text" name="intro1" id="summary" placeholder="  100자 이내로 작성해 주세요" value="" required>
                                    	<span id="counter" >(0/100)</span>
                                	</div>


                                	<div class="making_forms" id="clubAddress">
                                    	<p>주소</p>
                                    	<select id="addressSi" name="address1" aria-label="Default select example"></select>
                                    	<select id="addressSiGunGu" name="address2" aria-label="Default select example"></select>
                                	</div>      
                                	<div class="making_forms" id="clubIntro">
	                                	<p>모임 소개</p>
	                                    <textarea name="intro2" id="intro2" cols="30" rows="10"></textarea>
                                	</div>



                                	<div class="making_forms" id="clubInfo">
                                    	<p>모임 정보</p>
                                    	<div id="infoDetail">
                                    	<p>우리의 모임의 만나는 시간대, 장소, 단체카톡방 여부, 회식 여부, 날씨 영향 등에 대한 정보를 입력해보세요! </p>
                                    	<ul id="details">
	                                    		<li>
	                                                <img src="${pageContext.request.contextPath }/assets/images/icon/clock.png" class="cInfoImg">
	                                                <input type="text" class="c_Info" placeholder=" 시간" name="detailT" value="" required>
	                                            </li>
	                                            <li>
	                                                <img src="${pageContext.request.contextPath }/assets/images/icon/place.png" class="cInfoImg">
	                                                <input type="text" class="c_Info" placeholder=" 위치" name="detailL" value="" required>
	                                            </li>
	                                            <li>
	                                                <img src="${pageContext.request.contextPath }/assets/images/icon/message.png" class="cInfoImg">
	                                                <input type="text" class="c_Info" placeholder=" 연락처" name="detailP" value="" required>
	                                            </li>
	                                            <li>
	                                                <img src="${pageContext.request.contextPath }/assets/images/icon/vodka.png" class="cInfoImg">
	                                                <input type="text" class="c_Info" placeholder=" 회식" name="detailE" value="" required>
	                                            </li>
	                                            <li>
	                                                <img src="${pageContext.request.contextPath }/assets/images/icon/cloud.png" class="cInfoImg">
	                                                <input type="text" class="c_Info" placeholder=" 날씨" name="detailW" value="" required>
	                                            </li>
	                                    	</ul>
                                    	</div>
                                    </div>
									
									
									<div id = "imgBox">
										<div class= "making_forms" id = "clubMainImg">
										<p>메인 이미지</p>
										<div>
                                       		<img id="mainImg" src="" class="imgPre" >
                                            	<label for="img2" class="imgFile ct-color">이미지올리기</label>
                                            <input type ="file" id = "img2" name ="img2" class= "file-btn ct-color">
                                        </div>
										</div>
										<div class="making_forms" id="clubBackImg" >
	                                        <p>배경 이미지</p>
	                                        <div>
	                                            <img id="backImg" src="" class="imgPre" >
	                                            <div>
	                                                <label for="img1" class="imgFile ct-color">이미지올리기</label>
	                                                <input id="img1" type="file" name="img1" value="" class="file-btn ct-color">
	                                            </div>
	                                        </div>
	                                    </div>
	                                    
	                                    <div class= "">
	                                    
	                                    </div>
	                                    
                                    <div class="form_line"></div>
                                	<div id="submitBox">
                                    	<button type="submit">동호회 등록</button>
                                	</div> 
										
										
										
									</div>
									<!-- imgBox -->
		                                	<!------------------- 끝부분 ------------------->
                        				</form>	
		                              </div> 	
		                                	<!---------------// 끝부분 //------------------>

  <%--                               			
                                    <div id="imgBox">
                                     	<div class="making_forms" id="clubMainImg">
                                     		<p>메인 이미지</p>
                                        	<!-- <img id="mainImg" class="imgPre" src=""> -->
                                        	<div>
                                        		<img id="mainImg" src="" class="imgPre" >
                                            	<label for="img2" class="imgFile">이미지올리기</label>
                                            	<input id="img2" type="file" name="img2" value="" class="file-input">
                                        	</div>
                                     	</div>
                                     	<div class="making_forms" id="clubBackImg" >
	                                        <p>배경 이미지</p>
	                                        <div>
	                                            <img id="backImg" src="" class="imgPre" >
	                                            <div>
	                                                <label for="img1" class="imgFile">이미지올리기</label>
	                                                <input id="img1" type="file" name="img1" value="" class="file-input">
	                                            </div>
	                                        </div>
	                                    </div>
                                    </div>
                                    <div class="form_line"></div>
                                	<div id="submitBox">
                                    	<button type="submit">동호회 등록</button>
                                	</div> 
		 --%>
			
									
									
									
								
								<!--// edit form //-->
								
								
							</div>
							<!--// club-edit-form -->
						</div>
						<!--// content-box -->
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


    
</body>



<script>
	$('#clubMakingForm').on("submit", function(){
		let val = $('#intro2').val();
		$('#intro2').val(val.replace(/\n/g, "<BR>"));
		
	});
	
	$('#summary').keyup(function (e){
        var content = $(this).val();
        $('#counter').html("("+content.length+" / 100)");    //글자수 실시간 카운팅

        if (content.length > 200){
            alert("최대 100자까지 입력 가능합니다.");
            $(this).val(content.substring(0, 100));
            $('#counter').html("(100 / 100)");
        }
    });



</script>
<script>
    $(function(){
        areaSelectMarker("select[name=address1]")
    });

    var areaSelectMarker = function(target){
        if(target ==null || $(target).length==0){
            console.warn("UnKwon Area Tag");
            return;
        }
 

    var area = {
        "서울특별시" : ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"],
        "경기도1" : ["수원시장안구", "수원시권선구", "수원시팔달구", "수원시영통구", "성남시수정구", "성남시중원구", "성남시분당구", "의정부시", "안양시만안구", "안양시동안구", "부천시", "광명시", "평택시", "동두천시", "안산시상록구", "안산시단원구", "고양시덕양구", "고양시일산동구", "고양시일산서구"], 
        "경기도2" : ["과천시", "구리시", "남양주시", "오산시", "시흥시", "군포시", "의왕시", "하남시", "용인시처인구", "용인시기흥구", "용인시수지구", "파주시", "이천시", "안성시","김포시", "화성시", "광주시", "양주시", "포천시", "여주시", "연천군", "가평군","양평군"],
        "인천광역시" : ["계양구", "미추홀구", "남동구", "동구", "부평구", "서구", "연수구", "중구", "강화군", "옹진군"],
        "강원도" : ["춘천시", "원주시", "강릉시", "동해시", "태백시", "속초시", "삼척시", "홍천군", "횡성군", "영월군", "평창군", "정선군", "철원군", "화천군", "양구군", "인제군", "고성군", "양양군"],
        "충청북도" : ["청주시상당구", "청주시서원구", "청주시흥덕구", "청주시청원구", "충주시", "제천시", "보은군", "옥천군", "영동군", "증평군", "진천군", "괴산군", "음성군", "단양군" ],
        "충청남도" : ["천안시동남구", "천안시서북구", "공주시", "보령시", "아산시", "서산시", "논산시", "계룡시", "당진시", "금산군", "부여군", "서천군", "청양군", "홍성군", "예산군", "태안군"],
        "대전/세종" :[ "대덕구", "동구", "서구", "유성구", "중구" ,"세종특별자치시"],
        "전라북도" : [ "전주시완산구", "전주시덕진구", "군산시", "익산시", "정읍시", "남원시", "김제시", "완주군", "진안군", "무주군", "장수군", "임실군", "순창군", "고창군", "부안군"],
        "전라남도" : ["목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", "함평군", "영광군", "장성군", "완도군", "진도군", "신안군"],
        "광주광역시" : ["광산구", "남구", "동구", "북구", "서구"],
        "경상북도" : ["포항시남구", "포항시북구", "경주시", "김천시", "안동시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시", "군위군", "의성군", "청송군", "영양군", "영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군", "울진군", "울릉군"],
        "경상남도" : ["창원시의창구", "창원시성산구", "창원시마산합포구", "창원시마산회원구", "창원시진해구", "진주시", "통영시", "사천시", "김해시", "밀양시", "거제시", "양산시", "의령군", "함안군", "창녕군", "고성군", "남해군", "하동군", "산청군", "함양군", "거창군", "합천군"],
        "부산광역시" : ["강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군"],
        "대구광역시" : ["남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군" ],
        "울산/제주" : ["남구", "동구", "북구", "중구", "울주군","서귀포시", "제주시"]
    };



	for(i=0; i<$(target).length; i++){
	    (function(z){
	        var a1 = $(target).eq(z);
	        var a2 =a1.next();
	
	        //초기화 
	        init(a1,true);
	
	        //권역 생성
	        var area1 = Object.keys(area);
	        area1.forEach(function(siDo){
	            a1.append("<option value="+siDo+">"+siDo+"</option>");
	        });
	
	        //변경 이벤트
	        $(a1).on("change",function(){
	            init($(this),false);
	            var siDo =$(this).val();
	            var keys = Object.keys(area[siDo]);
	            keys.forEach(function(siGunGo){
	                a2.append("<option value="+area[siDo][siGunGo]+">"+area[siDo][siGunGo]+"</option>");
	            });
	        });
	    })(i);
	        function init(t,first){
	            first?t.empty().append("<option value=''>선택</option>"):"";
	            t.next().empty().append("<option value=''>선택</option>");
	        }

   	 	}
	}
</script>

<script>

	//태그를 클릭했을때 아래쪽 그린다
	$(".club_tag").on("click", function(){
		var tagList= [];
		
		$("#selectedTag").empty();
		
		$('input[name="tagNo"]:checked').each(function(i){
			 tagList.push($(this).data("tagname")); 
			
			 let tagName = $(this).data("tagname")
			 
			 let str = "<li class='tag'><p>"+tagName+"</p></li>" 			
			 $("#selectedTag").append(str);
			
			 
		});
		 
	});
	
	$('input[name="img1"]').change(function(){
		
		
	    setImageFromFile(this, '#backImg');
	});
	
	$('input[name="img2"]').change(function(){
	    setImageFromFile(this, '#mainImg');
	});
	

	function setImageFromFile(input, expression) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function (e) {
	    $(expression).attr('src', e.target.result);
	  }
	  reader.readAsDataURL(input.files[0]);
	  }
	}
	
	
	
</script>


</html>
