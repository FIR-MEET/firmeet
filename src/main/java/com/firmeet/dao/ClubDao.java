package com.firmeet.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.firmeet.vo.BoardVO;
import com.firmeet.vo.CategoryVo;
import com.firmeet.vo.ClubMemVo;
import com.firmeet.vo.ClubVo;
import com.firmeet.vo.MemberVo;
import com.firmeet.vo.TagVo;

@Repository
public class ClubDao {
	
	@Autowired
	private SqlSession session;
	
	public List<ClubVo> getMemClub(String memberId){
		
		List<ClubVo> memClubList = session.selectList("club.getMemClub", memberId);
		 System.out.println(memClubList);
		
		return memClubList;
	}
	
	  public void insertClub(ClubVo clubVo){
	      System.out.println("ClubDao.insertClub()");
	      System.out.println(clubVo);
	      session.insert("club.insertClub",clubVo);
	     
	   }
	  
		
		  public void insertAdmin(ClubMemVo clubMemVo) {
		  
		  System.out.println("ClubDao.insertAdmin()");
		  session.insert("club.insertAdmin" , clubMemVo); }
		 
	 public void insertCate(CategoryVo cateVO) {
		 
		 System.out.println("넘어온 값 확인 " + cateVO);
		 session.insert("club.insertClubCate",cateVO);
		 
	 }
	 
	 public void insertTag(TagVo tagVo) {
		 System.out.println(tagVo);
		 System.out.println("넘어온 값 확인" + tagVo);
	 }
	 
	 public List<ClubVo> clubList() {
		 List<ClubVo> clubVo = session.selectList("club.clubAllList");
		 return clubVo;
	 }
	 
	 public void clubJoinMem(ClubVo clubVo ,MemberVo memberVo) {
		 session.insert("cllub.insertMem", clubVo);
		 session.insert("cllub.insertMem", memberVo);
	 }

	 public String getClubName(BoardVO boardVO) {
		 
		 return session.selectOne("club.getClubName", boardVO);
	 }

	public ClubVo getClubVo(int clubId) {
		
		ClubVo clubVo= session.selectOne("club.getClubVo", clubId);
		
		System.out.println(clubVo);
		
		return clubVo;
	}
	
	 public TagVo selectTag(int tagNo) {
		 TagVo selectedTag = session.selectOne("club.selectTag",tagNo);
		 System.out.println(selectedTag);

		 return selectedTag;
	 }
	 
	 
}
