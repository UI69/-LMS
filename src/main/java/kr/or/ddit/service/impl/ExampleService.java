package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.IExampleMapper;
import kr.or.ddit.service.IExampleService;
import kr.or.ddit.vo.ExamAnswerVO;
import kr.or.ddit.vo.ExampleQuestionVO;
import kr.or.ddit.vo.ExampleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ExampleService implements IExampleService {
	
	@Inject
	private IExampleMapper exampleMapper;
	
	@Override
	public ExampleVO getExam(int examNo) {
		return exampleMapper.getExam(examNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public ServiceResult addExamAnswer(List<ExamAnswerVO> answerList) {
		ServiceResult res = ServiceResult.FAILED;
		
		int cnt = 0;
		
		try {
			
			int examNo = answerList.get(0).getExamNo();
			ExampleVO exampleVO = exampleMapper.getExam(examNo);
			
			for(ExamAnswerVO anVO : answerList) {
				for(ExampleQuestionVO exQst : exampleVO.getExamQstList()) {
					int ansNo = anVO.getExamQstNo();
					String ans = anVO.getAnswer();
					
					int crtNo = exQst.getExamQstNo();
					String crt = exQst.getQstCorrect();
					
					if(ansNo == crtNo) {
						if(ans.equals(crt)) {
							anVO.setGetScore(exQst.getQstScore());
						}
						break;
					}
				}
				cnt += exampleMapper.addExamAnswer(anVO);
			}
			
			if(cnt == answerList.size()) {
				res = ServiceResult.OK;
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
