package com.firmeet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PaymentController {
	
	@RequestMapping("/payment")
	public String payment() {
		return "notice/noticeVoteView";
	}
	
}