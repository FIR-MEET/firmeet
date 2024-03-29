package com.firmeet.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.firmeet.ajax.JsonResult;
import com.firmeet.service.ClubService;
import com.firmeet.service.ManagerService;
import com.firmeet.service.MemberService;
import com.firmeet.vo.AccountBookVo;
import com.firmeet.vo.CategoryVo;
import com.firmeet.vo.ClubMemVo;
import com.firmeet.vo.ClubVo;
import com.firmeet.vo.MemberVo;
import com.firmeet.vo.QnaVO;
import com.firmeet.vo.TagVo;

@RequestMapping("/management")
@Controller
public class ManagerController {
	
	@Autowired
	ClubService clubService;
	@Autowired
	MemberService memberService;
	@Autowired
	ManagerService managerService;
	
	
	/*동호회 관리 메인 페이지(가입 요청 승인)*/
	@RequestMapping("/club/{clubId}")
	public String memberManagement(@PathVariable("clubId") int clubId
								   ,HttpSession session
								   ,Model model) {
		System.out.println("clubManagementPage()");
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        
        if (member != null) {
            memberId = member.getMemberId();
            System.out.println(memberId); // memberId 값 출력;

            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            model.addAttribute("club", club);
            
            //회장일 시 해당 페이지 접근함
            if(club.getMemlevel() == 0) {
            	return "club_management/join_request";
            }
            //호스트가 아닐 시 동호회 메인 페이지로 이동
            return "redirect:/club/main/"+club.getClubId();
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
	}
	
	
	/* 회원 등급 수정*/
	@RequestMapping("/club/editgrade/{clubId}")
	public String editClubmember(@PathVariable("clubId") int clubId
								   ,HttpSession session
								   ,Model model) {
		System.out.println("editMemGrade()");
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        
        if (member != null) {
            memberId = member.getMemberId();
            System.out.println(memberId); // memberId 값 출력;

            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            model.addAttribute("club", club);
            
            //회장일 시 해당 페이지 접근함
            if(club.getMemlevel() == 0) {
            	return "club_management/edit_club_member";
            }
            //호스트가 아닐 시 동호회 메인 페이지로 이동
            return "redirect:/club/main/"+club.getClubId();
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
	}
	
	
	
	/*문의사항 페이지 이동*/
	@RequestMapping("/club/qna/{clubId}")
	public String qnaPage(@PathVariable("clubId") int clubId
			   			  ,HttpSession session
			   			  ,Model model) {
		System.out.println("clubQnAList()");
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        
        if (member != null) {
            memberId = member.getMemberId();
            System.out.println(memberId); // memberId 값 출력;

            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            model.addAttribute("club", club);
            
            //회장일 시 해당 페이지 접근함
            if(club.getMemlevel() == 0) {
            	return "club_management/qna_answer";
            }
            //호스트가 아닐 시 동호회 메인 페이지로 이동
            return "redirect:/club/main/"+club.getClubId();
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
	}
	
	
	/*동호회 수정 페이지*/
	@RequestMapping("/club/edit/{clubId}")
	public String editClub(@PathVariable("clubId") int clubId
 			  ,HttpSession session
 			  ,Model model) {
		System.out.println("clubEditForm()");
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        
        if (member != null) {
            memberId = member.getMemberId();
            System.out.println(memberId); // memberId 값 출력;

            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            model.addAttribute("club", club);
            
            //회장일 시 해당 페이지 접근함
            if(club.getMemlevel() == 0) {
            	
            	//필요한 태그 리스트 가져옴
        		List<TagVo> tagList = memberService.tagList();
        		List<CategoryVo> cateList = memberService.cateList();
        		model.addAttribute("tagList", tagList);
        		model.addAttribute("cateList", cateList);
        		//나머지 club의 detail한 정보 가져옴
        		ClubVo clubVO = managerService.clubDeInfo(club); 
        		model.addAttribute("deInfo", clubVO);
        		
            	return "club_management/edit_club";
            }
            //호스트가 아닐 시 동호회 메인 페이지로 이동
            return "redirect:/club/main/"+club.getClubId();
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
	}
	
	/*동호회 정보 수정*/
	@RequestMapping(value = "/club/editClubInfo", method = RequestMethod.POST)
	public String editClubInfo(@ModelAttribute ClubVo clubVO
							,@RequestParam("file") MultipartFile[] files) {
		System.out.println("editClubInfo()");
		System.out.println("수정하기 위해 넘어온 정보" + clubVO);

		if(files != null) {
			System.out.println(files[0].getOriginalFilename());
			System.out.println(files[1].getOriginalFilename());
		}
		
		managerService.updateClubInfo(clubVO, files);
		
		
		return "redirect:/management/club/edit/" + clubVO.getClubId();
	}
	
	
	/*가입 요청 list 불러옴*/
	@ResponseBody
	@RequestMapping(value = "/club/requestlist", method = RequestMethod.POST)
	public JsonResult getMemList(@ModelAttribute MemberVo memberVO) {
		System.out.println("requestList()");
		JsonResult jsonResult = new JsonResult();
		
		List<MemberVo> memberList = memberService.requestMemList(memberVO);
		jsonResult.success(memberList);
		
		return jsonResult;
	}

	/*가입승인 처리*/
	@ResponseBody
	@RequestMapping(value = "/club/joinrequest", method= RequestMethod.POST)
	public JsonResult joinRequest(@ModelAttribute ClubVo vo) {
		JsonResult jsonResult = new JsonResult();
		System.out.println("joinRequest()");
		
		int result = managerService.joinRequest(vo);
		jsonResult.success(result);
		
		return jsonResult;
	}
	
	
	/*클럽 가입된 회원 리스트*/
	@ResponseBody
	@RequestMapping(value ="/club/memberlist", method = RequestMethod.POST)
	public JsonResult clubMemList(@ModelAttribute MemberVo memberVO) {
		System.out.println("clubMemberList()");
	
		JsonResult jsonResult = new JsonResult();
		List<MemberVo> memberList = managerService.getMemList(memberVO);
		jsonResult.success(memberList);
		
		return jsonResult;
	}
	
	/*등급 변경*/
	@ResponseBody
	@RequestMapping(value = "/club/changegrade", method = RequestMethod.POST)
	public JsonResult changeGrade(@ModelAttribute MemberVo memberVO) {
		System.out.println("changeGrade()");

		JsonResult jsonResult = new JsonResult();
		boolean result = managerService.changeGrade(memberVO);
		jsonResult.success(result);
		
		return jsonResult;
	}
	
	/*회원 강퇴*/
	@ResponseBody
	@RequestMapping(value = "/club/kickout" , method = RequestMethod.POST)
	public JsonResult kickoutMem(@ModelAttribute ClubVo clubVO) {
		System.out.println("kickoutMember()");
		JsonResult jsonResult = new JsonResult();
		boolean result = managerService.kickoutMem(clubVO);
		jsonResult.success(result);
		return jsonResult;
	}
	
	/*클럽 QNA 중 답변이 등록되지 않은 QNA 리스트*/
	@ResponseBody
	@RequestMapping(value ="/club/qnalist", method=RequestMethod.POST)
	public JsonResult getQnaList(@ModelAttribute MemberVo memberVO) {
		System.out.println("QNAList()");

		JsonResult jsonResult = new JsonResult();
		List<QnaVO> qnaList = managerService.getClubQna(memberVO);
		jsonResult.success(qnaList);
		return jsonResult;
	}
	
	/*클럽 QNA 답변 등록*/
	@ResponseBody
	@RequestMapping(value = "/club/qnaanswer", method = RequestMethod.POST)
	public JsonResult addQnaAnswer(@ModelAttribute QnaVO qnaVO) {
		System.out.println("answerQnA()");
		
		JsonResult jsonResult = new JsonResult();
		boolean result = managerService.addQnaAnswer(qnaVO);
		
		jsonResult.success(result);
		
		return jsonResult;
	}
	
	/*-------------------------------------마이다이어리---------------------------- */
	
	/*가입한 클럽 탈퇴~*/
	@RequestMapping(value = "/member/clubManager/{memberId}", method = { RequestMethod.GET,RequestMethod.POST})
	public String clubManager(@PathVariable("memberId") String memberId,HttpSession session) {
		System.out.println("myClubList()");
		
		// 현재 로그인한 회원 정보를 세션에서 가져옵니다.
		MemberVo member = (MemberVo) session.getAttribute("member");
		
		if (member != null) {
			System.out.println(memberId); // memberId 값 출력;

			return "/member_diary/member_club_management";

		} else {
			// 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
			return "member/memberForm";
		}
	}
	
	/*동아리 탈퇴*/
	@ResponseBody
	@RequestMapping(value = "/club/myClubDel" , method = RequestMethod.POST)
	public JsonResult myClubDel(@ModelAttribute ClubMemVo clubVO) {
		System.out.println("clubWithdrawal()");

		JsonResult jsonResult = new JsonResult();
		boolean result = managerService.myClubDel(clubVO);
		jsonResult.success(result);
		return jsonResult;
	}
	
	/*가입한 동호회 정보 가져옴*/
	@ResponseBody
	@RequestMapping(value = "/club/getclubDeInfo" , method = RequestMethod.POST)
	public JsonResult getclubDeInfo(@ModelAttribute ClubVo clubVO) {
		System.out.println("getClubDeInfo()");
		JsonResult jsonResult = new JsonResult();
		ClubVo vo = managerService.clubDeInfo(clubVO);
		jsonResult.success(vo);
		
		
		return jsonResult;
	}
	
}
