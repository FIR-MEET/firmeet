package com.firmeet.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.firmeet.vo.GalleryImgVo;
import com.firmeet.vo.GalleryLikeVo;
import com.firmeet.vo.GalleryVo;
import com.firmeet.vo.MeetVo;
import com.firmeet.vo.MemberVo;

@Repository
public class GalleryDao {

	@Autowired
	private SqlSession session;

	// 갤러리 등록된 미팅 정보 조회
	public List<MeetVo> getMeet(int meetMon) {
		System.out.println("GalleryDao getMeet 확인");
		System.out.println(meetMon);

		List<MeetVo> sList = session.selectList("gallery.meetList", meetMon);

		System.out.println("getMeet " + sList);

		return sList;
	}

	//모임 년도 월 가져오기
	public List<MeetVo> getMeetMon(int clubId) {
		System.out.println("GalleryDao getMeetMon 확인");

		List<MeetVo> sList = session.selectList("gallery.meetMon", clubId);

		System.out.println("getMeetMon " + sList);

		return sList;
	}

	// 갤러리 번호 조회
	public int getGalleryNo(int meet) {
		System.out.println("GalleryDao getGalleryNo 확인");
		System.out.println(meet);

		Integer galleryNo = session.selectOne("gallery.getGalleryNo", meet);
		int galleryNoValue = galleryNo != null ? galleryNo.intValue() : 0;
		System.out.println(galleryNoValue);
		return galleryNoValue;
	}

	// 갤러리 이미지 등록
	public void upload(GalleryImgVo gImgVo) {
		System.out.println("GalleryDao upload 확인");
		session.insert("gallery.insertGalleryImage", gImgVo);
	}

	// 갤러리 이미지 목록 조회
	public List<GalleryImgVo> getGalleryImg(int GalleryNo) {
		System.out.println("GalleryDao getGalleryImg 확인");
		System.out.println("GalleryNo : " + GalleryNo);
		List<GalleryImgVo> gImgVos = session.selectList("gallery.getGalleryImg", GalleryNo);
		System.out.println(gImgVos);

		return gImgVos;
	}

	// 갤러리 목록 조회
	public List<GalleryVo> getGalleryList(int clubId) {
		System.out.println("GalleryDao getGalleryList 확인");
		System.out.println("clubId : " + clubId);

		List<GalleryVo> galleryVos = session.selectList("gallery.getGalleryList", clubId);
		System.out.println(galleryVos);

		return galleryVos;
	}

	//모임이름 가져오기 A
	public MeetVo getMeetA(int meetNo) {
		System.out.println("GalleryDao getMeetA 확인");

		MeetVo sList = session.selectOne("gallery.meetList2", meetNo);
		System.out.println(sList);

		return sList;
	}

	//모임 이름 가져오기
	public List<MeetVo> getMeetName(int year, int month, int clubId) {
		System.out.println("GalleryDao getMeetName 확인");

		Map<String, Integer> variableMap = new HashMap<>();
		variableMap.put("year", year);
		variableMap.put("month", month);
		variableMap.put("clubId", clubId);

		List<MeetVo> galleryVos = session.selectList("gallery.getMeetName", variableMap);
		System.out.println(month + "GalleryDao getMeetName 확인: " + galleryVos);

		return galleryVos;
	}

	public List<GalleryImgVo> getGalleryListAll(int clubId) {
		System.out.println("GalleryDao getGalleryListAll 확인");

		List<GalleryImgVo> galleryVos = session.selectList("gallery.getGalleryListAll", clubId);
		System.out.println(galleryVos);

		return galleryVos;
	}
	//좋아요확인
	public boolean checkLike(int imgNo, String memberId) {
		System.out.println("GalleryDao checkLike 확인");
		boolean result = false;
		
		Map<String, Object> variableMap = new HashMap<>();
		variableMap.put("imgNo", imgNo);
		variableMap.put("memberId", memberId);
		System.out.println(variableMap);
		
		List<GalleryLikeVo> checkLike =session.selectList("gallery.checkLike", variableMap);
		System.out.println(checkLike);
		if (checkLike.size() == 0) {
			result = false;
		}else {
			result = true;
		}
		System.out.println(result);
		
		return result;
	}
	//좋아요
	public void updateImg(int imgNo, String memberId) {
		Map<String, Object> variableMap = new HashMap<>();
		variableMap.put("imgNo", imgNo);
		variableMap.put("memberId", memberId);
		System.out.println(variableMap);
		
		session.insert("gallery.updateImg", variableMap);
	}
	//좋아요 카운드 업데이트
	public void updateCnt(int imgNo, int likeCnt) {
		System.out.println("GalleryDao updateCnt 확인");
		Map<String, Object> variableMap = new HashMap<>();
		variableMap.put("imgNo", imgNo);
		variableMap.put("likeCnt", likeCnt);
		System.out.println(variableMap);
		
		session.update("gallery.updateCnt", variableMap);
	}
	//좋아요 취서
	public void deleteLike(int imgNo, String memberId) {
		System.out.println("GalleryDao deleteLike 확인");
		Map<String, Object> variableMap = new HashMap<>();
		variableMap.put("imgNo", imgNo);
		variableMap.put("memberId", memberId);
		System.out.println(variableMap);
		
		int test =session.delete("gallery.deleteLike", variableMap);
		System.out.println("삭제 결과 : "+test);
		
	}
	
	//이미지삭제
	public void deleteImg(int imgno) {
		System.out.println("GalleryDao deleteImg 확인");
		System.out.println("imgno"+imgno);
		
		int test =session.delete("gallery.deleteImg", imgno);
		System.out.println("삭제 결과 : "+test);
	}
	
	//이미지가 가지고 있는 좋아요 리스트삭제
	public void deleteImgLike(int imgno) {
		System.out.println("GalleryDao deleteImgLike 확인");
		System.out.println("imgno"+imgno);
		
		int test =session.delete("gallery.deleteImgLike", imgno);
		System.out.println("삭제 결과 : "+test);
		
	}

	//이미지 주인찾기
	public MemberVo checkmemberId(String memberId) {
		System.out.println("GalleryDao checkmemberId 확인");
		System.out.println("imgno"+memberId);
		
		MemberVo memberVo = session.selectOne("gallery.checkmemberId", memberId);
		System.out.println("memberVo"+memberVo);
		return memberVo;
	}

	public List<GalleryImgVo> getGalleryList(Map<String, Object> map) {
		
		return session.selectList("gallery.getMyPhoto", map);
	}
}
