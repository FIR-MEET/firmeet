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
import com.firmeet.service.NoticeBoardService;
import com.firmeet.vo.AreplyVO;
import com.firmeet.vo.ClubVo;
import com.firmeet.vo.MemberVo;
import com.firmeet.vo.NoticeBoardVO;
import com.firmeet.vo.PayresultVO;


@Controller
@RequestMapping("/{clubId}/notice")
public class NoticeBoardController {
	
	@Autowired
	private ClubService clubService;
	
	@Autowired
	private NoticeBoardService noticeBoardService;
	
	@RequestMapping(value = "/noticelist", method = {RequestMethod.GET, RequestMethod.POST})
	public String noticelist(@PathVariable int clubId, Model model, HttpSession session, @RequestParam(defaultValue="") String keyword) {
		System.out.println("noticelist 확인");
		
		session.setAttribute("clubId", clubId);
		
		System.out.println(session.getAttribute("clubId"));
		
		//model.addAttribute("nlist", noticeBoardList);
		System.out.println("bbb");
		
        MemberVo member = (MemberVo) session.getAttribute("member");
       String memberId = null;

        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);
            
            List<NoticeBoardVO> noticeBoardList = noticeBoardService.noticeList(keyword,memberId);
            model.addAttribute("nlist", noticeBoardList);
            System.out.println("ccc"+memberId);
            
            return "notice/noticeList";
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
        
	}
	
	//에디터 일반 페이지
	@RequestMapping("/noticeEditGeneral")
	public String noticeEditGeneral(@ModelAttribute NoticeBoardVO vo, HttpSession session, Model model) {
		System.out.println("noticeEditGeneral확인");
		
		int clubId = (int) session.getAttribute("clubId");
		
		System.out.println("controller clubId"+clubId);
		System.out.println(vo);
		
		String memberId = (String) session.getAttribute("memberId");
		
		model.addAttribute("clubId", clubId);
		model.addAttribute("memberId", memberId);
		
        MemberVo member = (MemberVo) session.getAttribute("member");
        //String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);

            return "notice/noticeEditGeneral";
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
		
		
	}
	
	//에디터 결제 페이지
	@RequestMapping("/noticeEditGroupP")
	public String noticeEditGroupP(@ModelAttribute NoticeBoardVO vo, HttpSession session, Model model) {
		System.out.println("noticeEditGroup확인");
		
		int clubId = (int) session.getAttribute("clubId");
		
		System.out.println("controller clubId"+clubId);
		model.addAttribute("clubId", clubId);
		
		 MemberVo member = (MemberVo) session.getAttribute("member");
	        String memberId = null;
	        if (member != null) {
	            memberId = member.getMemberId();

	            System.out.println(memberId); // memberId 값 출력;
	            
	            // 클럽과 회원의 관계 정보를 가져옵니다.
	            ClubVo club = clubService.checkMemLevel(memberId, clubId);
	            // club이 null이면 쫒아내기!!!
	            model.addAttribute("club", club);

	            return "notice/noticeEditGroupP";
	        } else {
	            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
	            return "member/memberForm";
	        }
		
		
	}
	
	//에디터 결제 페이지
	@RequestMapping("/noticeEditGroupG")
	public String noticeEditGroupG(@ModelAttribute NoticeBoardVO vo, HttpSession session, Model model) {
		System.out.println("noticeEditGroup확인");
		int clubId = (int) session.getAttribute("clubId");
		System.out.println("controller clubId"+clubId);
		model.addAttribute("clubId", clubId);
		
		 MemberVo member = (MemberVo) session.getAttribute("member");
	        String memberId = null;
	        if (member != null) {
	            memberId = member.getMemberId();

	            System.out.println(memberId); // memberId 값 출력;
	            
	            // 클럽과 회원의 관계 정보를 가져옵니다.
	            ClubVo club = clubService.checkMemLevel(memberId, clubId);
	            // club이 null이면 쫒아내기!!!
	            model.addAttribute("club", club);

	            return "notice/noticeEditGroupG";
	            
	        } else {
	            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
	            return "member/memberForm";
	        }
		
	}
	
	//에디터 일반페이지 등록 후 나오는 페이지
	@RequestMapping("/editwrite")
	public String editwrite(@ModelAttribute NoticeBoardVO vo, Model model, HttpSession session) {
		System.out.println("notice editwrite 확인 ");
		System.out.println("controller vo"+vo);
		
		noticeBoardService.editwrite(vo);
		System.out.println("getAboardNo"+vo.getAboardNo());
		
		model.addAttribute("aboardNo", vo.getAboardNo());
		model.addAttribute("memberId", vo.getMemberId());
		
		return "redirect:/"+vo.getClubId()+"/notice/editlist";
	}
	
	//에디터 일반페이지 등록 후 리스트
	@RequestMapping("/editlist")
	public String editlist(Model model, HttpSession session, @ModelAttribute NoticeBoardVO vo, ClubVo clubvo) {
		System.out.println("notice editlist 확인");
		System.out.println("controller aboardNo 확인"+vo.getAboardNo());
		
		int clubId = (int) session.getAttribute("clubId");
		
		model.addAttribute("clubId", clubvo.getClubId());
		session.getAttribute("aboardNo");
		
		session.getAttribute("memberId");

		model.addAttribute("aboradNo", vo.getAboardNo());
		model.addAttribute("memberId", vo.getMemberId());

		model.addAttribute("voteNo", vo.getVoteNo());
		System.out.println("controller voteNo 확인"+ vo.getVoteNo());
		
		model.addAttribute("vo", noticeBoardService.editlist(vo));

		MemberVo member = (MemberVo) session.getAttribute("member");
		
        String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);

    		return "notice/noticeGroupView";
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
	}
	
	@RequestMapping("/vote")
	public String vote(@PathVariable("clubId") int clubId, @ModelAttribute NoticeBoardVO vo, Model model, HttpSession session) {
		System.out.println("controller vo"+vo);
		model.addAttribute("voteNo", vo.getVoteNo());
		model.addAttribute("aboradNo", vo.getAboardNo());
		
		model.addAttribute("memberId", vo.getMemberId());		
		
		System.out.println("voteNo"+ vo.getVoteNo());
		System.out.println("getAboardNo"+ vo.getAboardNo());
		
		noticeBoardService.voteinsert(vo);
		
		return "redirect:/"+vo.getClubId()+"/notice/voteResult/"+vo.getAboardNo();
	}
	
	
	//에디터 일반페이지 등록 후 리스트
	@RequestMapping("/voteResult/{aboardNo}")
	public String voteResult(@PathVariable("clubId") int clubId, @PathVariable("aboardNo") int aboardNo, ClubVo clubvo, @ModelAttribute NoticeBoardVO vo, Model model, HttpSession session) {
		model.addAttribute("voteNo", vo.getVoteNo());
		model.addAttribute("aboradNo", vo.getAboardNo());
		model.addAttribute("vo", noticeBoardService.voteResult(vo));  
		
		System.out.println("controller clubId"+clubId);
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        
		String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);

            return "notice/noticeGroupView";
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
	}
	
	//에디터 모임 등록 후 나오는 페이지
	@RequestMapping("/editgroupwrite")
	public String editgroupwrite(@ModelAttribute NoticeBoardVO vo, HttpSession session, Model model) {
		
		System.out.println("notice editgroupwrite 확인 ");
		System.out.println("controller vo"+vo);
		
		noticeBoardService.editgroupwrite(vo);
		model.addAttribute("aboardNo", vo.getAboardNo());
		System.out.println("번호확인"+vo.getMeetNo());
		
		return "redirect:/"+vo.getClubId()+"/notice/editlistgroup";
	}
	
	//에디터 모임 등록 후 나오는 리스트
	@RequestMapping("/editlistgroup")
	public String editlistgroup(ClubVo clubvo, Model model, HttpSession session, @ModelAttribute NoticeBoardVO vo) {
		System.out.println("notice editgrouplist 확인");
		System.out.println("controller aboardNo 확인"+vo.getAboardNo());
		System.out.println(vo);
		
		model.addAttribute("clubId", clubvo.getClubId());
		
		model.addAttribute("aboardNo", vo.getAboardNo());
		System.out.println("meetNo"+ vo.getMeetNo());
		model.addAttribute("meetNo", vo.getMeetNo());
		session.getAttribute("memberId");
		System.out.println("gsgsdsgsgsgsg"+vo.getMemberId());
		model.addAttribute("vo", noticeBoardService.editlistgroup(vo));
		System.out.println("controller meetno 확인"+vo.getMeetNo());
		
		int clubId = (int) session.getAttribute("clubId");

		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);

    		return "notice/noticeVoteView";
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
	}
	
	//에디터 모임 등록 후 나오는 페이지
	@RequestMapping("/editgroupwriteG")
	public String editgroupwriteG(@ModelAttribute NoticeBoardVO vo, HttpSession session, Model model) {
		System.out.println("notice editgroupwriteGG 확인 ");
		System.out.println("controller vo"+vo);
		
		noticeBoardService.editgroupwriteG(vo);
		model.addAttribute("meetNo", vo.getMeetNo());
		model.addAttribute("aboardNo", vo.getAboardNo());
		model.addAttribute("memberId", vo.getMemberId());
		System.out.println("번호확인"+vo.getMeetNo());
		
		return "redirect:/"+vo.getClubId()+"/notice/editlistgroupG";
	}
	
	//에디터 모임 등록 후 나오는 리스트
	@RequestMapping("/editlistgroupG")
	public String editlistgroupG(ClubVo clubvo, Model model, HttpSession session, @ModelAttribute NoticeBoardVO vo) {
		System.out.println("notice editgrouplistGG 확인");
		System.out.println("controller aboardNo 확인"+vo.getAboardNo());
		System.out.println(vo);
		
		model.addAttribute("clubId", clubvo.getClubId());
		
		model.addAttribute("aboardNo", vo.getAboardNo());
		System.out.println("meetNo"+ vo.getMeetNo());
		model.addAttribute("meetNo", vo.getMeetNo());
		session.getAttribute("memberId");
		System.out.println("gsgsdsgsgsgsg"+vo.getMemberId());
		model.addAttribute("vo", noticeBoardService.editlistgroupG(vo));
		System.out.println("controller meetno 확인"+vo.getMeetNo());
		
		int clubId = (int) session.getAttribute("clubId");

		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);

    		return "notice/noticeVoteViewG";
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }

	}
	
	//에디터 모임 등록 후 나오는 리스트
		@RequestMapping("/noticeVoteViewR")
		public String noticeVoteViewR(ClubVo clubvo, Model model, HttpSession session, @ModelAttribute NoticeBoardVO vo) {
			System.out.println("notice editgrouplistGG 확인");
			System.out.println("controller aboardNo 확인"+vo.getAboardNo());
			System.out.println(vo);
			
			model.addAttribute("clubId", clubvo.getClubId());
			
			model.addAttribute("aboardNo", vo.getAboardNo());
			System.out.println("meetNo"+ vo.getMeetNo());
			model.addAttribute("meetNo", vo.getMeetNo());
			session.getAttribute("memberId");
			System.out.println("gsgsdsgsgsgsg"+vo.getMemberId());
			model.addAttribute("vo", noticeBoardService.editlistgroupR(vo));
			System.out.println("controller meetno 확인"+vo.getMeetNo());
			
			int clubId = (int) session.getAttribute("clubId");

			MemberVo member = (MemberVo) session.getAttribute("member");
	        String memberId = null;
	        if (member != null) {
	            memberId = member.getMemberId();

	            System.out.println(memberId); // memberId 값 출력;
	            
	            // 클럽과 회원의 관계 정보를 가져옵니다.
	            ClubVo club = clubService.checkMemLevel(memberId, clubId);
	            // club이 null이면 쫒아내기!!!
	            model.addAttribute("club", club);

	    		return "notice/noticeVoteViewR";
	            
	        } else {
	            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
	            return "member/memberForm";
	        }

		}
	
	@ResponseBody
	@RequestMapping("/address")
	public JsonResult idCheck(@ModelAttribute NoticeBoardVO vo) {
		
		System.out.println("넘어오는지 확인" + vo);
		JsonResult jsonResult = new JsonResult();
		jsonResult.success(vo);
		
		return jsonResult;
	}

	//파일 업로드 처리  (썸머노트 이미지 첨부 하면 바로 저장됨  이미지 경로를 리턴)
	@ResponseBody
	@RequestMapping(value="/upload")
	public JsonResult upload(@RequestParam("file") MultipartFile file) {
		System.out.println("FileUploadController.upload()");
		System.out.println(file.getOriginalFilename());
		
		JsonResult jsonResult = new JsonResult();
		String psaveName = noticeBoardService.imgup(file);
		System.out.println("확확확"+psaveName);
		jsonResult.success(psaveName);
		
		return jsonResult;
	}

	@ResponseBody
	@RequestMapping("/pay")
	public JsonResult pay(@ModelAttribute PayresultVO vo, @PathVariable("clubId") int clubId, HttpSession session, Model model) {
		
		System.out.println("넘어오는지 확인in" + vo);
		JsonResult jsonResult = new JsonResult();
	
		MemberVo member = (MemberVo) session.getAttribute("member");
		
		jsonResult.success(noticeBoardService.pay(vo, clubId));
	
		
		System.out.println("getMemberId"+vo.getMemberId());
		System.out.println("getMeetNo"+vo.getMeetNo());
		System.out.println("getPayresultNo"+vo.getPayresultNo());
		//String url = "/"+clubId+"/notice/payresult?payresultNo="+vo.getPayresultNo();
		
		//return "redirect:/"+url;
		
		return jsonResult;
	}
	
	//----------------------------------------------------------------------------------------------
	
	@ResponseBody
	@RequestMapping(value = "/addReply", method = RequestMethod.POST)
	public JsonResult addReply(@ModelAttribute AreplyVO vo) {
		JsonResult jsonResult = new JsonResult();
		
		System.out.println("AJAX로 넘어오는 정보" + vo);
		jsonResult.success(noticeBoardService.addReply(vo));
		
		return jsonResult;
	}

	@ResponseBody
	@RequestMapping(value = "/addReply_2", method = RequestMethod.POST)
	public JsonResult addRreply(@ModelAttribute AreplyVO vo) {
		JsonResult jsonResult = new JsonResult();
		
		System.out.println("AJAX로 넘어오는 정보" + vo);
		jsonResult.success(noticeBoardService.addReply2(vo));
		return jsonResult;
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
	public JsonResult deleteReply(@ModelAttribute AreplyVO vo) {
		
		JsonResult jsonResult = new JsonResult();
		System.out.println("AJAX로 넘어온 삭제할 코멘트 정보 " +vo);
		boolean result = noticeBoardService.deleteReply(vo);
		jsonResult.success(result);
		
		return jsonResult;
	}
	
	@ResponseBody
	@RequestMapping(value = "/likeCnt", method = RequestMethod.POST)
	public JsonResult likeCnt(@ModelAttribute NoticeBoardVO vo) {
		
		JsonResult jsonResult = new JsonResult();
		System.out.println("넘어오는 거 체크" + vo);
		NoticeBoardVO result = noticeBoardService.likeCnt(vo);
		System.out.println(result);
		jsonResult.success(result);
		
		return jsonResult;
	}
	
	@RequestMapping(value="/gmodifyform", method = {RequestMethod.GET, RequestMethod.POST})
	public String gmodifyform(@ModelAttribute NoticeBoardVO vo, Model model, @RequestParam("meetNo") int meetNo, HttpSession session) {
		int clubId = (int) session.getAttribute("clubId");
		model.addAttribute("clubId", clubId);
		model.addAttribute("meetNo", vo.getMeetNo());
		model.addAttribute("memberId", vo.getMemberId());
		model.addAttribute("vo", noticeBoardService.gmodifyform(meetNo));
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);

            return "notice/noticeEditGroupGmodify";
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
		
	}
	
	@RequestMapping(value="/gmodify", method = {RequestMethod.GET, RequestMethod.POST})
	public String gmodify(@ModelAttribute NoticeBoardVO vo, Model model, @RequestParam("meetNo") int meetNo, HttpSession session) {
		int clubId = (int) session.getAttribute("clubId");
		model.addAttribute("clubId", clubId);
		model.addAttribute("meetNo", vo.getMeetNo());
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);
            
            noticeBoardService.gmodify(vo);

            return "redirect:/"+vo.getClubId()+"/notice/noticelist";
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
		
	}
	
	
	@RequestMapping(value="/elmodifyform", method = {RequestMethod.GET, RequestMethod.POST})
	public String elmodifyform(@ModelAttribute NoticeBoardVO vo, Model model, @RequestParam("aboardNo") int aboardNo, HttpSession session) {
		int clubId = (int) session.getAttribute("clubId");
		model.addAttribute("clubId", clubId);
		model.addAttribute("aboardNo", vo.getAboardNo());
		model.addAttribute("memberId", vo.getMemberId());
		model.addAttribute("vo", noticeBoardService.elmodifyform(aboardNo));
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);

            return "notice/noticeEditGeneralmodify";
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
		
	}
	
	@RequestMapping(value="/elmodify", method = {RequestMethod.GET, RequestMethod.POST})
	public String elmodify(@ModelAttribute NoticeBoardVO vo, Model model, @RequestParam("aboardNo") int aboardNo, HttpSession session) {
		int clubId = (int) session.getAttribute("clubId");
		model.addAttribute("clubId", clubId);
		model.addAttribute("aboardNo", vo.getAboardNo());
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);
            
            noticeBoardService.elmodify(vo);

            return "redirect:/"+vo.getClubId()+"/notice/noticelist";
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
		
	}
	
	@RequestMapping(value="/pmodifyform", method = {RequestMethod.GET, RequestMethod.POST})
	public String pmodifyform(@ModelAttribute NoticeBoardVO vo, Model model, @RequestParam("meetNo") int meetNo, HttpSession session) {
		int clubId = (int) session.getAttribute("clubId");
		model.addAttribute("clubId", clubId);
		model.addAttribute("meetNo", vo.getMeetNo());
		model.addAttribute("memberId", vo.getMemberId());
		model.addAttribute("vo", noticeBoardService.gmodifyform(meetNo));
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);

            return "notice/noticeEditGroupPmodify";
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
		
	}
	
	@RequestMapping(value="/pmodify", method = {RequestMethod.GET, RequestMethod.POST})
	public String pmodify(@ModelAttribute NoticeBoardVO vo, Model model, @RequestParam("aboardNo") int aboardNo, HttpSession session) {
		int clubId = (int) session.getAttribute("clubId");
		model.addAttribute("clubId", clubId);
		model.addAttribute("meetNo", vo.getMeetNo());
		
		MemberVo member = (MemberVo) session.getAttribute("member");
        String memberId = null;
        if (member != null) {
            memberId = member.getMemberId();

            System.out.println(memberId); // memberId 값 출력;
            
            // 클럽과 회원의 관계 정보를 가져옵니다.
            ClubVo club = clubService.checkMemLevel(memberId, clubId);
            // club이 null이면 쫒아내기!!!
            model.addAttribute("club", club);
            
            noticeBoardService.pmodify(vo);

            return "redirect:/"+vo.getClubId()+"/notice/noticelist";
            
        } else {
            // 회원이 로그인하지 않은 상태라면 로그인 페이지로 이동합니다.
            return "member/memberForm";
        }
		
	}
	
	@RequestMapping(value="/gdelete", method = {RequestMethod.GET, RequestMethod.POST})
	public String gdelete(@ModelAttribute NoticeBoardVO vo, @RequestParam("aboardNo") int aboardNo, Model model) {
		model.addAttribute("aboardNo", vo.getAboardNo());
		model.addAttribute("memberId", vo.getMemberId());
		noticeBoardService.gdelete(aboardNo);
		return "redirect:/"+vo.getClubId()+"/notice/noticelist";
	}
	
	@RequestMapping(value="/eldelete", method = {RequestMethod.GET, RequestMethod.POST})
	public String eldelete(@ModelAttribute NoticeBoardVO vo, Model model) {
		model.addAttribute("aboardNo", vo.getAboardNo());
		model.addAttribute("voteNo", vo.getVoteNo());
		model.addAttribute("memberId", vo.getMemberId());
		noticeBoardService.eldelete(vo);
		return "redirect:/"+vo.getClubId()+"/notice/noticelist";
	}
	
}
