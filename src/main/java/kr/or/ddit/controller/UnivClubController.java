package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class UnivClubController {
	//동아리 관련
	
	//동아리 목록
	// 동아리 상세

	// 동아리 개설
	// 동아리 개설 허가/반려
	// 동아리 해산 신청
	// 동아리 해산 허가/반려
	
	
	
	
	// 이 밑으로 구현 ============================================

	
	@GetMapping("/clubList.do")
	public String clubList() {
		
		return "student/clubList";
	}
}
