<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>개인 달력</title>
  <!--제이쿼리-->
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <!--부트스트랩-->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

  <!--CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/main2_test.css" rel="stylesheet" type="text/css" />
      <link href="${pageContext.request.contextPath}/assets/css/board2_test.css" rel="stylesheet"  type="text/css" />
  <!--풀 캘린더 CSS-->
 	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/calendar.css" type="text/css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/popup.css" type="text/css" />
  <!--풀 캘린더 JS-->
  <script src="${pageContext.request.contextPath }/assets/js/index.global.js"></script>
  <!-- 카카오 map  -->
  <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=6f59970276341196f41538265d29af72&libraries=services"></script>

  <style>
    .fc .fc-daygrid-day-top {
      display: block;
    }
	
	

  </style>
</head>

<body>

  <!----------------------------------------- top Navigation ----------------------------------------->
<c:import url="/WEB-INF/views/include/nav.jsp"></c:import>
  <!----------------------------------------- // 상단 내비게이션 바 //----------------------------------------->
  <!-- 페이지 콘텐츠 -->

  <div class="wrap">
    <div class="diary-area">
      <div class="diary-topbar">
        <img class="diary-topbar-img" src="./asset/pro.jpg" alt="프로필사진" />
        <h1>${member.memberId}님의 다이어리</h1>
      </div>
      <!--/diary-topbar-img-->
      <div class="diary-subbar memcal-subbar">
          <input type ="hidden" value ="${member.memberId}" id ="memId">
        <div class="memcalendar-array">
			<select  id ="select-club"   class ="select-sche-option">
				<option value="-99">전체</option>
				<option value ="-88">나의 일정</option>
				<c:forEach items ="${joinClubList}" var ="club">
					<option value ="${club.clubId}">${club.clubName}</option>
				</c:forEach>
       		</select>
          <select id = "select-array" class= "select-sche-option2">
            <option value ="-99">전체</option>
            <option value = "2">결제공지</option>
            <option value ="3">일정</option>
          </select>
        </div>
      </div>
      <!--/diary-subbar-->
      <div class="content-area">
        <div class="content-right calendar-right">
       <div class="calendar-area">
          <div class="forCalendar">
            <div id='mem-calendar'></div>
          </div>
	</div>
          <!--/calendar-area-->
        </div>
        <!--/content-right-->
      </div>
      <!--/content-area-->
    </div>
        <!--/diary-area-->
	<c:import url="/WEB-INF/views/include/side_nav_per_update.jsp"></c:import>
    <!--/wrap-->
  
  <!-- 일정 등록모달창-->
<div class="container1" >
  <div class="popup-wrap" id="popup">
    <div class="popup">
      <div class="popup-head">
        <div class="popup-close-btn">X</div>
      </div>
      <div class="popup-body">
        <div class="body-content">
          <div class="body-titlebox">
            <h4><strong>일정등록</strong></h4>
            
          </div>
       <form action="${pageContext.request.contextPath}/calendar/member/add-persche" method = "GET" class= "add-persche">
            <input type="hidden" id = "address1" name = "address1" value = "-1">
            <input type="hidden" id = "address2" name = "address2" value ="-1">
            <input type="hidden" name = "memberId" value = "${member.memberId}" id = "memId">
            <input type="hidden" id = "marker_place">
          <div class="body-contentbox">
            <table id = "schedule-table">
              <tr>
                <th>일정</th>
                <td><input type="text" placeholder="일정명을 입력하세요." id = "title" name = "title"> </td>
              </tr>
              <tr>
                <th rowspan="2">일정</th>
                <td rowspan="2"><input type="date" id = "startD" name = "startDate">&nbsp; ~&nbsp; 
                <input type="date" id = "endD" name ="endDate" ></td>
              </tr>
              <tr>
              </tr>
              <tr>
                <th>장소등록</th>
                <td>
				<span class= "checkbox-loca"><input type ="checkbox" id = "loca-insert-select" > &nbsp;장소 등록 </span>
				  <div class= "loca-btn-area">
                <input type = "text" class= "search-place" id  = "place"  readonly><button type= "button" class="map-search-btn">위치검색</button></div>
				<span><input type = "text" readonly name = "place" id = "place-result" value =" "></span>
              </td>                
                
              </tr>
              <tr class="content-area">
                <th>내용</th>
                <td><textarea name = "content" id = "content"></textarea></td>
              </tr>
            </table>
            
          </div>
          <div class="sche-submit-btn">
            <button type ="submit">등록</button>
            <button type ="button">취소</button>
          </div>
       </form>
          
        </div>
      </div>
    </div>
</div>
</div>
<!--모달창-->


<!-- 지도 위치 검색 모달창-->
<div class="container2" >

  <div class="popup-wrap2" id="popup">
    <div class="popup" id = "2th-popup">
      <div class="popup-head">
        <div class="popup-close-btn2">X</div>
      </div>
      <div class="popup-body">
        <div class="body-content">
       <form action="http://localhost:8000/link/search/" method = "get">
          <div class="body-titlebox">
            <h4><strong>지도 선택</strong></h4>

          </div>
          <div class="body-contentbox">
            <div id="map" style="width:500px;height:400px; display:block; "></div>
          </div>
       </form>
          
        </div>
      </div>
    </div>
</div>
</div>
<!--지도 팝업창-->

<!--개인 일정 확인 팝업창-->
<div class= "container4">
<div class="per-pop">
  <div class="per-pop-header">
    <div class="per-pop-close-btn">X</div>
  </div>
  <div class="per-pop-body">
    <div class="per-pop-content">
      <div class="body-titlebox"><h4><strong>나의 일정</strong></h4></div>
      <table id = "schedule-table">
        <tr>
          <th>일정</th>
          <td class="de-title"></td>
        </tr>
        <tr>
          <th rowspan="2">일정</th>
          <td rowspan="2"><input type="date" name = "startDate" class="de-start" readonly>&nbsp; ~&nbsp; 
          <input type="date" id = "endD" name ="endDate" class="de-end" readonly ></td>
        </tr>
        <tr>
        </tr>
        <tr>
          <th>장소</th>
          <td><span class="de-place"></span> &nbsp;&nbsp;<button type ="button" class="see-place" id = "see-map">길찾기</button></td>
        </tr>
        <tr class="content-area">
          <th>내용</th>
          <td><textarea name = "content" class="de-content" readOnly></textarea>
          <div id="map2" ></div></td>
        </tr>
      </table>

        <div class="per-sche-edit">
          <button type = "button" class="edite-btn" >수정</button>
          <button type = "button" class= "delete-per" id = "delete-per">삭제</button>
        </div>
    </div><!--per-pop-content-->

  </div><!--popup body-->
</div> <!--popup end-->
</div>


  
<!--//개인 일정 확인 팝업창//-->  
 
<!---             일정 수정 팝업             --->
 
 <div class="container5" >
  <div class="popup-wrap">
    <div class="popup">
      <div class="popup-head">
        <div class="popup-close-btn3">X</div>
      </div>
      <div class="popup-body">
        <div class="body-content">
          <div class="body-titlebox">
            <h4><strong>일정수정</strong></h4>
            
          </div>
       <form action="${pageContext.request.contextPath}/calendar/member/edit-persche" method = "GET" class= "edit-persche">
            <input type="hidden" id = "edit-address1" name = "address1" value = "-1">
            <input type="hidden" id = "edit-address2" name = "address2" value ="-1">
            <input type="hidden" name = "memberId" value = "${member.memberId}" id = "edit-memId">
            <input type="hidden" name = "perScheNo" id = "edit-perScheNo">
          <div class="body-contentbox">
            <table id = "schedule-table">
              <tr>
                <th>일정</th>
                <td><input type="text" placeholder="일정명을 입력하세요." id = "edit-title" name = "title"> </td>
              </tr>
              <tr>
                <th rowspan="2">일정</th>
                <td rowspan="2"><input type="date" id = "edit-startD" name = "startDate">&nbsp; ~&nbsp; 
                <input type="date" id = "edit-endD" name ="endDate" ></td>
              </tr>
              <tr>
              </tr>
              <tr>
                <th>장소등록</th>
                <td>
				<span class= "checkbox-loca"><input type ="checkbox" id = "edit-place-checked" > &nbsp;장소 변경 </span>
				<span><input type = "text" readonly name = "place" id = "edit-place-result" value =" "></span>
                <input type = "text" class= "search-place" id  = "edit-place"  readonly><button type= "button" class="map-search-btn2" disabled>위치검색</button></td>
              </tr>
              <tr class="content-area">
                <th>내용</th>
                <td><textarea name = "content" id = "edit-content"></textarea></td>
              </tr>
            </table>
            
          </div>
          <div class="sche-submit-btn">
            <button type ="submit">수정</button>
            <button type ="button" class = "popup-close-btn3">취소</button>
          </div>
       </form>
          
        </div>
      </div>
    </div>
</div>
</div>
<!--//             일정 수정 팝업              //-->


<!-- 지도 위치 검색 모달창-->
<div class="container6" >

  <div class="popup-wrap" id="popup">
    <div class="popup" id = "2th-popup">
      <div class="popup-head">
        <div class="popup-close-btn4">X</div>
      </div>
      <div class="popup-body">
        <div class="body-content">
       <form action="http://localhost:8000/link/search/" method = "get">
          <div class="body-titlebox">
            <h4><strong>지도 선택</strong></h4>
			
          </div>
          <div class="body-contentbox">
            <div id="map3" style="width:500px;height:400px; display:block; "></div>
          </div>
       </form>
          
        </div>
      </div>
    </div>
</div>
</div>
<!--지도 팝업창-->


</body>

<script>

$('.edit-persche').on("submit", function(){
	
	var title = $('#edit-title').val();
	var memId = $('#edit-memId').val();
	var startD = $('#edit-endD').val();
	var endD = $('#edit-startD').val();
	
	
	if(title.length < 1){
		alert('타이틀을 입력하세요.')
		return false;
	}if(memId.length < 1){
		alert('로그인이 필요한 서비스입니다.')
		return false;
	}if(startD.length < 1){
		alert('시작 날짜를 지정해주세요.')
		return false;
	}if(endD.length < 1){
		alert('끝나는 날짜를 지정해주세요.')
		return false;
	}
	return true;
	
	
});


 /*세번째 지도*/
 
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow3 = new kakao.maps.InfoWindow({zIndex:1});
var mapContainer3 = document.getElementById('map3'), // 지도를 표시할 div 
    mapOption3 = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
// 지도 생성   
var map3 = new kakao.maps.Map(mapContainer3, mapOption3); 
// 장소 검색 객체
var ps3 = new kakao.maps.services.Places(); 



// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB3 (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds3 = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker3(data[i]);    
            bounds3.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map3.setBounds(bounds3);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker3(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker3 = new kakao.maps.Marker({
        map: map3,
        position: new kakao.maps.LatLng(place.y, place.x)
    
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker3, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다

		let lat =  marker3.getPosition().getLat(); 
        let lng =  marker3.getPosition().getLng();
        setCenter3(marker3.getPosition().getLat(), marker3.getPosition().getLng())
        let place_name = place.place_name;
        infowindow.setContent('<div class= "marker-place" style="height: 80px; width: 200px; text-align:center;">' + place_name + '<br> <button type="button" class= "loca-edit-btn">위치등록</button></div>');
    	
      	$('#edit-address1').val(lat);
    	$('#edit-address2').val(lng);
   		$('#edit-place').val(place_name);
        infowindow.open(map3, marker3);
    });
}


$('.container6 .popup').on("click",'.loca-edit-btn', function(){
	$('.container6').css('display' , 'none');
});
$('.popup-close-btn4').on("click", function(){
	$('.container6').css('display' , 'none');
});



function setCenter3(x, y) {            
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(x, y);
    
    // 지도 중심을 이동 시킵니다
    map3.setCenter(moveLatLon);
}

function relayout3() {    
    map3.relayout();
} 
 
	//
	$('.map-search-btn2').on("click", function(){
		var keyword = $('#edit-place').val();
		$('.container6 .popup-wrap').css('display' , 'block');
		$('.container6').css('display' , 'block');
		ps3.keywordSearch(keyword, placesSearchCB3);
		 relayout3();
	});
	
	//일정 수정창 삭제, X 버튼 클릭 이벤트
	$('.popup-close-btn3').on("click",function(){
		con5_reset(); 
	});

	
	//일정 수정창 리셋
	function con5_reset(){
		$('.container6').css('display' , 'none');
	  	$('#edit-address1').val(-1);
		$('#edit-address2').val(-1);
		$('#edit-place-result').val("");
		$('#edit-place-checked').prop('checked', false);
	}
	
	
	$('#edit-place-checked').on('change', function() {
		  if ($(this).is(':checked')) {
			  $('.map-search-btn2').prop('disabled', false);
			  $('.map-search-btn2').css('background-color', 'black');
			  $('.map-search-btn2').css('color', 'white');
		  } else {
			  $('.map-search-btn2').prop('disabled', true);
			  $('.map-search-btn2').css('background-color', 'rgb(238, 238, 238)');
			  $('.map-search-btn2').css('color', 'white');

		  }
		});
	
</script>


<!-- 지도 JS 영역 -->
<style>
<!--지도-->
.marker-place{
padding:5px;font-size:14px; text-align:center; height: 100px;
}
.loca-insert-btn, .loca-edit-btn{
	margin-bottom : 4px; background-color: black; color: white; text-align: center; font-size:12px; display:inline-block;
	width:70px; height: 30px; margin-top:7px;
	position: absolute; bottom: 5px; left: 50%; transform: translateX(-50%);
}
.loca-insert-btn:hover{
	background-color:white;
	color: black; border: 0.5px solid black;
}
.popup-wrap input {
height:30px;
}
.map-search-btn {
 background-color: black; 
 color: white;
font-size: 15px;
    width: 70px;
    height: 30px;
} 
.map-search-btn2{
 background-color: rgb(238, 238, 238); 
 color: white;
font-size: 15px;
    width: 70px;
    height: 30px;
}
.checkbox-loca{
  display: flex;
  align-items: center;
font-size : 13px;}
</style>
<script>

$('.edite-btn').on("click", function(){
	
	$('.container5 .popup-wrap ').css("display", "block");
	
	var data = $(this).data();
	$('#edit-address1').val(data.address1);
	$('#edit-address2').val(data.address2);
	$('#edit-memId').val(data.memid);
	$('#edit-title').val(data.title);
	$('#edit-startD').val(data.start);
	$('#edit-endD').val(data.end);
	$('#edit-place-result').val(data.place);
	$('#edit-content').val(data.content);
	$('#edit-perScheNo').val(data.scheno);
	
	
});



/*---------------------------------지도 사용-----------------------------------------*/

// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
// 지도 생성   
var map = new kakao.maps.Map(mapContainer, mapOption); 
// 장소 검색 객체
var ps = new kakao.maps.services.Places(); 



// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x)
    
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다

		let lat =  marker.getPosition().getLat(); 
        let lng =  marker.getPosition().getLng();
        setCenter(marker.getPosition().getLat(), marker.getPosition().getLng())
        let place_name = place.place_name;
        infowindow.setContent('<div class= "marker-place" style="height: 80px; width: 200px; text-align:center;">' + place_name + '<br> <button type="button" class= "loca-insert-btn">위치등록</button></div>');
    	
        $('#address1').val(lat);
    	$('#address2').val(lng);
    	$('#marker_place').val(place_name);
        infowindow.open(map, marker);
    });
}


function setCenter(x, y) {            
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(x, y);
    
    // 지도 중심을 이동 시킵니다
    map.setCenter(moveLatLon);
}

function relayout() {    
    map.relayout();
} 

//주소 검색 버튼 
$('.map-search-btn').on("click", function(){
	
	var keyword = $('.search-place').val();
	ps.keywordSearch(keyword, placesSearchCB); 
	$('.container2 .popup-wrap2').css('display', 'block');
	$('.container2').css('display', 'block');
	relayout();
});
//주소 등록창 닫기 버튼//
$('.popup-close-btn2').on("click", function(){
	
		console.log('확인');
		$('.popup-wrap2').css("display", 'none');
});



//지도의 위치 등록 버튼 클릭이벤트//
$('#2th-popup').on("click",'.loca-insert-btn', function(){
	let place_name =  $('#marker_place').val()
 	 
	$('#place-result').val(place_name);
	$('.popup-wrap2').css("display", 'none');
	
});

//개인일정 등록 submit 이벤트
$('.add-persche').on("submit", function(){
	var memId = $('#memId').val();
	var title = $('#title').val();
	var startD = $('#startD').val();
	var endD = $('#endD').val();
	
	if(title.length < 1){
		alert('타이틀을 입력하세요.')
		return false;
	}if(memId.length < 1){
		alert('로그인이 필요한 서비스입니다.')
		return false;
	}if(startD.length < 1){
		alert('시작 날짜를 지정해주세요.')
		return false;
	}if(endD.length < 1){
		alert('끝나는 날짜를 지정해주세요.')
		return false;
	}
	return true;
})

//장소 넣기 checkbox 선택 시 장소 검색창 활성화
$('#loca-insert-select').on('change', function() {
	  if ($(this).is(':checked')) {
		  $('#place').removeAttr('readonly');
		  $('.loca-btn-area').css("display", 'block');
		  $('.container1 .body-content').css("height", '535px');
	  } else {
		  $('#place').attr('readonly', 'readonly');
		  $('#place').val("");
		  $('.loca-btn-area').css("display", 'none');
		  $('.container1 .body-content').css("height", '506px');
		  reset_popup1_address();
	  }
	});

//장소 넣기 checkbox 선택 시 장소 검색창 활성화
$('#edit-place-checked').on('change', function() {
	  if ($(this).is(':checked')) {
		  $('#edit-place').removeAttr('readonly');
	  } else {
		  $('#edit-place').attr('readonly', 'readonly');
		  $('#edit-place').val("");
		  reset_popup2_address();
	  }
	});



function load_map2(x,y){
	
	if(x == -1){
		$('#map2').css('display', 'none');
	}else{
		$('#map2').css('display', 'block');
	var container = document.getElementById('map2'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(x,y), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};

	var map2 = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

	 var marker2 = new kakao.maps.Marker({
	        map: map2,
	        position: new kakao.maps.LatLng(x, y)
	    
	    });
	}
}

</script>






<!--// 지도 JS 영역 //-->


<!-- 캘린더 JS 영역 -->
<script>

//개인 스케줄 삭제 버튼 클릭 이벤트
$('#delete-per').on("click", function(){
	let scheNo = $('#delete-per').data('scheno');
	console.log("------");
	console.log(scheNo);
	
	if(confirm('정말 삭제하시겠습니까?')){
		deletePerSche(scheNo);
	}
	
});




/*-----------------------------------------개인 스케줄 팝업 열기---------------------------------------*/
 
 //장소 보기 버튼 클릭 이벤트 
$('#see-map').on("click", function(){
  var screenWidth = screen.width;
  var screenHeight = screen.height;
  var windowWidth = 800;
  var windowHeight = 600;
  var windowLeft = (screenWidth - windowWidth) / 2; // 여기서 ,를 추가
  var windowTop = (screenHeight - windowHeight) / 2;

  var x = $(this).data('x');
  var y = $(this).data('y');
  window.open('https://map.kakao.com/link/map/' + x + ',' + y, '_blank', 'width=800,height=600,left=2000px,top=2000px');
});





//calendar 객체 전역변수 설정
let calendarEl;
let calendar;

//document ready 상태가 되면 달력을 그리고 해당하는 달에 추가할 data를 가져옴
$(document).ready(function() {
	render();
	getData();

});
  
/*-------------------------정렬 기준에 따른 데이터 reload----------------------------------*/
 
//전체/결제/모임 정렬 선택
$('#select-array').on("change", function(){
	getData();
});

//캘린더 이전 버튼 클릭 했을때
$('.forCalendar').on("click",'button.fc-prev-button', function(){
	getData();
});
//캘린더 이후 버튼 선택했을 때
$('.forCalendar').on("click",'button.fc-next-button', function(){
	getData();
	console.log('test2');
});

//정렬선택에서 <<--내 일정-->> 선택 시 결제/모임 정렬 기능 비활성화&전체로 value값 변경
$('#select-club').on("change", function(){
	
	if( $(this).val() == '-88'){
		$('#select-array').val("-99");
		$('#select-array').attr("disabled", true);
	}else{
		$('#select-array').attr("disabled", false);
	}
	getData();
	
});


/*--------------------popup close event ----------------------------------*/

//일정등록 팝업 닫기
$(".popup-close-btn").click(function(){
	 $("#popup").fadeOut();
	      reset_popup1();
});

/*개인일정 닫기 창*/
$('.per-pop-close-btn').on("click", function(){
	$('.container4').css("display", 'none');
});
//일정수정 닫기
$('.popup-close-btn3').on("click", function(){
	$('#edit-address1').val("-1");
	$('#edit-address2').val("-1");
	$('.container5 .popup-wrap').css("display", "none");
});

//일정 등록 팝업 리셋
function reset_popup1(){
	$('#content').val("");
	$('#startD').val("");
	$('#endD').val("");
	$('#title').val("");
	$('#place').val("");
	$('#address1').val("-1");
	$('#address2').val("-1");
	$('#loca-insert-select').prop('selectedIndex', -1);
}

//일정등록 팝업 위도, 경도값 리셋
function reset_popup1_address(){
	$('#address1').val("-1");
	$('#address2').val("-1");
}
function reset_popup2_address(){
	$('#edit-address1').val("-1");
	$('#edit-address2').val("-1");
}


/*----------------------------캘린더 초기화 -----------------------------------*/

function render(){
	    calendarEl = $('#mem-calendar')[0];
	    calendar = new FullCalendar.Calendar(calendarEl, {
	    	 headerToolbar: {
	             left: '',
	             center: 'title',
	             right: 'prev,next'
	           },

		    locale: 'ko',
	    	initialView: 'dayGridMonth',
	    	selectable: true,
	    	eventlimit: true,
			dayMaxEvents: true,
	    	//드래그 이벤트처리
	           views: {
	        	    timeGrid: {
	        	    	  eventLimit: 2
	        	    }
	        	  },
	    	dateClick: function(info) {
		        $("#popup").css('display','flex').hide().fadeIn()
		        $('#startD').val(info.dateStr);
		        $('#endD').val(info.dateStr);
	          },
	        select: function(info) {
	        	$("#popup").css('display','flex').hide().fadeIn()
		        $('#startD').val(info.startStr);
		        $('#endD').val(info.endStr);
	        },
	        eventClick: function(info) {
	            if(info.event.classNames == 'per-event'){
	                openPerSche(info.event.id);
	            }
	         }
	    });

	    calendar.render();
	}
	
	
	/*------------------------------정렬, 바뀐 캘린더 년/월에 맞춰 해당하는 이벤트 reload 하는 메서드 ----------------------------------*/
	function getData(){
		
		var title = $("#fc-dom-1").text();
		var years = title.substring(0,4);
		var month = title.substring(title.length-2,title.length-1);
		var memberId =  $('#memId').val();
	 	var viewOption2 =  $('#select-club').val(); //그룹옵션
	 	var viewOption1 =  $('#select-array').val(); //일정 종류 옵션
		
	 	console.log('정보 확인  : ' + years + '달 : ' + month + '  멤버 아이디 : '  +memberId + ' 정렬 옵션 1 : ' + viewOption1 + '정렬옵션2: ' + viewOption2)
		
	
		CalendarVO = {
	 		memberId: memberId,
	 		viewOption1: viewOption1,
	 		viewOption2 : viewOption2,			  	  
			month: month,
			years:years
		}
	
		
	 	console.log(CalendarVO);
	
	 	
	 	 $.ajax({
	         
	         //요청 세팅/calendar/member/getSchedule
	         url : "${pageContext.request.contextPath}/calendar/member/getSchedule",      
	         type : "POST",
	         data : CalendarVO,
	         
	         //응답 세팅
	         dataType : "json",
	         success : function(jsonResult){
	   			
	        	 var data = jsonResult.data;
	        	 var club = data.clubSche;
	        	 var per = data.perSche;
	        	 console.log(club);
	        	 console.log(per);
	        	 
	 			calendar.removeAllEvents();
	        	 
	        	 if(club != null ){
		 				for(var i = 0; i<club.length; i++){
		 					if(club[i].meetCate =="3"){
		 						calendar.addEvent({
		 							title: '[' + club[i].clubName + ']' + club[i].title + club[i].frontTitle,
		 							start: club[i].startDate,
		 							end: club[i].endDate + ' 24:00',
		 							url: 'http://www.naver.com',
		 							backgroundColor: '#FF6A00',
		 							borderColor:  '#FF6A00'
		 						});//addEvent end
		 					}else{
		 						calendar.addEvent({
		 							title: '[' + club[i].clubName + ']' + club[i].title + club[i].frontTitle,
		 							start: club[i].startDate,
		 							end: club[i].endDate + ' 24:00',
		 							url: 'http://www.naver.com',
		 							backgroundColor: '#66008c',
		 							borderColor:  '#66008c'
		 						});//addEvent end
		 					}//if end
		 				}//for end
	        	 } //club.length check
	        	 
	        	 if(per != null){
	        		 for(var i =0; i<per.length; i++){
	        			 calendar.addEvent({
	 							title: '[개인]' + per[i].title ,
	 							start: per[i].startDate,
	 							end: per[i].endDate + ' 24:00',
	 							id : per[i].perScheNo,
	 					        className : 'per-event',
	 							backgroundColor: '#0C70F2',
	 							borderColor:  '#0C70F2',
	 						}
	        			 );//addEvent end
	        		 }//for end
	        	 }//if end
	         }, //success end
	         error : function(XHR, status, error) {
	         console.error(status + " : " + error);
	         }
	 				            
	      });//ajax end
	
	}//render() end
	


	//개인 일정 팝업창 열고 정보 넣기
	/*---------------------------------개인 일정 팝업창 열기----------------------------------------*/
	
	function openPerSche(perScheNo){
	    
	    ScheduleVO = {
	    	perScheNo : perScheNo
	    }
	    
	    $.ajax({
	        
	        //요청 세팅/calendar/member/getSchedule
	        url : "${pageContext.request.contextPath}/calendar/member/gerScheDetail",      
	        type : "POST",
	        data : ScheduleVO,
	        
	        //응답 세팅
	        dataType : "json",
	        success : function(jsonResult){
				
		       	var sche = jsonResult.data;
		       	console.log(sche);
		       	console.log(sche.startDate);
		       	console.log(sche.endDate);
	        	
	 		   $('.container4').css("display", "block");
	           $('.de-title').text(sche.title);
	           $('.de-start').val(sche.startDate);
	           $('.de-end').val(sche.endDate);
	           $('.de-place').text(sche.place);
	 		   $('.de-content').text(sche.content);
	 		   $('#delete-per').data('scheno', sche.perScheNo);
	 		   $('.edite-btn').data('scheno',sche.perScheNo);
	 		   $('.edite-btn').data('start',sche.startDate);
	 		   $('.edite-btn').data('end',sche.endDate);
	 		   $('.edite-btn').data('title',sche.title);
	 		   $('.edite-btn').data('content',sche.content);
	 		   $('.edite-btn').data('address1',sche.address1);
	 		   $('.edite-btn').data('address2',sche.address2);
	 		   $('.edite-btn').data('place',sche.place);
	 		   $('.edite-btn').data('memid',sche.memberId);
	 		  	load_map2(sche.address1,sche.address2);
	 		   if(sche.address1 != -1){ //address가 있는 일정일 경우 길찾기 버튼 활성화 + 컬러 black으로 변경 
	 			  $('.see-place').prop('disabled', false);
	 			  $('.see-place').css("background-color","#1eafcc");
		 		  $('#see-map').data('x', sche.address1);
		 		  $('#see-map').data('y', sche.address2);
	 		   }else{ //address 정보 없는 일정일 경우 길찾기 버튼 비활성화 + 컬러 gray로 변경
	 			  $('.see-place').prop('disabled', true);
	 			  $('.see-place').css("background-color","#eeeeee");
	 		   }
				 		   
	        }, //success end
	        error : function(XHR, status, error) {
	        console.error(status + " : " + error);
	        }
					            
	     });//ajax end
	}//openPerSche event end

	
	
	/*---------------------------------------------개인 스케줄 삭제 function-----------------------------------------------------*/
	
	function deletePerSche(scheNo){
		
		  ScheduleVO = {
			    	perScheNo : scheNo
			    }
			    
			    $.ajax({
			        
			        //요청 세팅/calendar/member/getSchedule
			        url : "${pageContext.request.contextPath}/calendar/member/deletePerSche",      
			        type : "POST",
			        data : ScheduleVO,
			        
			        //응답 세팅
			        dataType : "json",
			        success : function(jsonResult){
						
						if(jsonResult.data == true){
							alert('스케줄이 삭제되었습니다.')
							$('.container4').css("display", 'none');
							getData();
						}else{
							alert('유효하지 않은 정보입니다. 잠시 후 다시 이용해주세요.')
						}
			        }, //success end
			        error : function(XHR, status, error) {
			        console.error(status + " : " + error);
			        }
							            
			     });//ajax end
		
	}//deletePerSche end


	
</script>


</html>