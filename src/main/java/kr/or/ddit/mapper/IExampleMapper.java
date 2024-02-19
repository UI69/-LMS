package kr.or.ddit.mapper;

import kr.or.ddit.vo.ExamAnswerVO;
import kr.or.ddit.vo.ExampleVO;

public interface IExampleMapper {

	ExampleVO getExam(int examNo);

	int addExamAnswer(ExamAnswerVO anVO);
	
}
