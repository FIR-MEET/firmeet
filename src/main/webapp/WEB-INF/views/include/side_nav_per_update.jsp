<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

       <div class= "menu-bar2" >
			<ul class= "side-bar2">
	          <li id = "per-calendar" class= "sd-color"><a href ="${pageContext.request.contextPath }/calendar/member/${member.memberId}">달력</a></li>
              <li id = "per-gallery" class= "sd-color"><a href ="${pageContext.request.contextPath }/gallery/member/list/${member.memberId}">갤러리</a></li>
	          <li id = "per-board" class= "sd-color"><a href ="${pageContext.request.contextPath }/board/member/${member.memberId}/-99">자유 게시판</a></li>
          	  <li id = "per-account" class= "sd-color"><a href ="${pageContext.request.contextPath }/accountBook/member/main/${member.memberId}">가계부</a></li>
	          <li id = "per-club" class= "sd-color"><a href ="${pageContext.request.contextPath }/management/member/clubManager/${member.memberId}">동호회 관리</a></li>
			</ul>
      </div>
        <!-- menu-bar -->
    <!--/wrap-->

