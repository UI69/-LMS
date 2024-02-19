package kr.or.ddit.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.IExampleService;
import kr.or.ddit.vo.ExamAnswerVO;
import kr.or.ddit.vo.ExampleQuestionVO;
import kr.or.ddit.vo.ExampleVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class examController {
	
	@Inject
	private IExampleService exampleService;
	
	@GetMapping("/example.do/{examNo}")
	public String example(Model model,@PathVariable("examNo") int examNo) {
		
		ExampleVO exampleVO = exampleService.getExam(examNo);
		model.addAttribute("exampleVO", exampleVO);
		
		int maxQstChLen = 2;
		for(ExampleQuestionVO examQst : exampleVO.getExamQstList()) {
			if(maxQstChLen < examQst.getQstChList().size()) {
				maxQstChLen = examQst.getQstChList().size();
			}
		}
		model.addAttribute("maxQstChLen", maxQstChLen);
		
		return "example/example";
	}
	
	@ResponseBody
	@PostMapping("/example/examAnswerForm.do")
	public String examAnswerForm(@RequestBody List<ExamAnswerVO> answerList, HttpServletRequest req) {
		log.info("answerList : " + answerList);
		
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		for(ExamAnswerVO anVO : answerList) {
			anVO.setMemNo(memberVO.getMemNo());
		}
		
		ServiceResult res = exampleService.addExamAnswer(answerList);
		
		return res.toString();
	}
}
