package com.firmeet.controller;




import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.firmeet.ajax.JsonResult;
import com.firmeet.service.MemberService;
import com.firmeet.vo.CategoryVo;
import com.firmeet.vo.MemberVo;
import com.firmeet.vo.TagVo;



@Controller
@RequestMapping(value="/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	
	/* 로그인 폼*/
	@RequestMapping(value="/loginForm", method= {RequestMethod.GET})
	public String loginForm(Model model){
		System.out.println("MemberController.loginForm()");
		List<TagVo> tagList = memberService.tagList();
		List<CategoryVo> cateList = memberService.cateList();
		model.addAttribute("tagList", tagList);
		model.addAttribute("cateList", cateList);
		return"member/memberForm";
	}

	/* 로그인 */
	@RequestMapping(value="/login", method= RequestMethod.POST)
	public String login(@ModelAttribute MemberVo memberVo,HttpSession session, Model model){
		System.out.println("MemberController.login()");
		System.out.println(memberVo);
		List<TagVo> tagList = memberService.tagList();
		List<CategoryVo> cateList = memberService.cateList();
		model.addAttribute("tagList", tagList);
		model.addAttribute("cateList", cateList);
		MemberVo member =  memberService.login(memberVo);
		
		
		  if(member !=null){
			  System.out.println("로그인 성공");
			  session.setAttribute("member", member);
			  return "redirect:/main/mainForm";
		  }else {
			  System.out.println("로그인 실패");
			  return "member/memberForm";
		  }	
		
	}
	
	/* 로그아웃 */
	@RequestMapping(value="/logout", method= {RequestMethod.GET})
	public String logout(HttpSession session) {
		session.removeAttribute("member");
		session.invalidate();
		return"redirect:/main/mainForm";
	}
	
	/* 회원가입 */
	@RequestMapping(value="/joinForm", method= {RequestMethod.GET,RequestMethod.POST})
	public String joinForm(Model model) {
		System.out.println("MemberController.joinForm()");
		List<TagVo> tagList = memberService.tagList();
		System.out.println(tagList);
		List<CategoryVo> cateList = memberService.cateList();
		System.out.println(cateList);
		model.addAttribute("tagList", tagList);
		System.out.println(tagList);
		model.addAttribute("cateList", cateList);
		System.out.println(cateList);
		return "member/memberForm";
	}
	
	@RequestMapping(value="/join", method= { RequestMethod.GET , RequestMethod.POST})
	public String join(@ModelAttribute MemberVo memberVo
						) {
		System.out.println("MemberController.join()");
		System.out.println(memberVo);
		memberService.join(memberVo);
			
		System.out.println(memberVo.getMemberId());
		return "member/memberForm";
	}
	
	/* 아이디 체크 */
	@ResponseBody
	@RequestMapping(value="/idcheck", method = RequestMethod.POST)
	public JsonResult idcheck(@ModelAttribute MemberVo memberVo) {
		System.out.println("MemberController.idcheck()");
		
		boolean data = memberService.idcheck(memberVo.getMemberId());
		
		JsonResult jsonResult = new JsonResult();
		jsonResult.success(data);
		
		System.out.println(jsonResult);
		return jsonResult;
	}
	
	@ResponseBody
	@RequestMapping(value="/tagList", method = {RequestMethod.POST, RequestMethod.GET})
	public JsonResult tagList(){
		System.out.println("MemberController.tagList()");
		
		List<TagVo> tag = memberService.tagList();
		System.out.println(tag);
		
		JsonResult jsonResult1 = new JsonResult();
		jsonResult1.success(tag);
		
		return jsonResult1;
		
	}
	
	 @ResponseBody
	 @RequestMapping(value="/cateList", method = {RequestMethod.POST,
	 RequestMethod.GET}) public JsonResult cateList() {
	 System.out.println("MemberController.cateList()"); List<CategoryVo> cateList
	 = memberService.cateList(); System.out.println(cateList);
	 
	 JsonResult jsonResult = new JsonResult(); jsonResult.success(cateList);
	 
	 return jsonResult; }
	 
}

