package kr.or.ddit.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.IChatBotService;
import kr.or.ddit.vo.ChatBotVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class DDiTiController {
	// 음성인식
	
	@Inject
	private IChatBotService chatbotService;
	
	// key값으로 field 얻는 비동기 메소드
	@ResponseBody
	@PostMapping("/chatBot/selectField")
	public ResponseEntity<List<ChatBotVO>> selectField(@RequestBody String key) {
		log.info("챗봇, selectField");
		System.out.println("key : " + key);
	
		List<ChatBotVO> result = chatbotService.selectField(key);
		
		return new ResponseEntity<List<ChatBotVO>>(result, HttpStatus.OK);
	}
}
