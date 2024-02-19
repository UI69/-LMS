package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.ExamAnswerVO;
import kr.or.ddit.vo.ExampleVO;

public interface IExampleService {

	ExampleVO getExam(int examNo);

	ServiceResult addExamAnswer(List<ExamAnswerVO> answerList);

}
