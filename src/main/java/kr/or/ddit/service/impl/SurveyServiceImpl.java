package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.ISurveyMapper;
import kr.or.ddit.service.ISurveyService;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.SurveyQuestionChoiceVO;
import kr.or.ddit.vo.SurveyQuestionVO;
import kr.or.ddit.vo.SurveyResultVO;
import kr.or.ddit.vo.SurveyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class SurveyServiceImpl implements ISurveyService {

	@Inject
	private ISurveyMapper surveyMapper;

	@Override
	public int surveyListCnt(PaginationVO<SurveyVO> pagingVO) {
		return surveyMapper.surveyListCnt(pagingVO);
	}

	@Override
	public List<SurveyVO> surveyList(PaginationVO<SurveyVO> pagingVO) {
		return surveyMapper.surveyList(pagingVO);
	}

	@Override
	public SurveyVO getSurvey(int srvNo) {
		return surveyMapper.getSurvey(srvNo);
	}

	@Override
	public ServiceResult addSurvey(SurveyVO surveyVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		
		int svCnt = 0;
		int sqCnt = 0;
		
		try {
			svCnt = surveyMapper.addSurvey(surveyVO);
			
			if(svCnt != 1) {
				throw new Exception();
			}
			
			int srvNo = surveyVO.getSrvNo();
			
			
			for (SurveyQuestionVO srvQst : surveyVO.getSrvQstList()) {
				srvQst.setSrvNo(srvNo);
				sqCnt += surveyMapper.addSrvQuestion(srvQst);
				
				int svChCnt = 0;
				int srvQstNo = srvQst.getSrvQstNo();
				
				for(SurveyQuestionChoiceVO srvQstCh : srvQst.getSrvQstChList()) {
					srvQstCh.setSrvQstNo(srvQstNo);
					srvQstCh.setSrvNo(srvNo);
					svChCnt += surveyMapper.addSrvQstChoice(srvQstCh);
				}
								
				if(svChCnt != srvQst.getSrvQstChList().size()) {
					throw new Exception();
				}
			}
			
			if(sqCnt != surveyVO.getSrvQstList().size()) {
				throw new Exception();
			} else {
				res = ServiceResult.OK;
			}
			
		} catch (Exception e) {
			log.error("{}", e);
		}
		
		
		return res;
	}

	@Override
	public ServiceResult addSurveyAnswer(int memNo, List<SurveyResultVO> surveyResultList) {
		ServiceResult res = ServiceResult.FAILED;
			
		int cnt = 0;
			
		try {
			
			for (SurveyResultVO srv : surveyResultList ) {
				srv.setMemNo(memNo);
				cnt += surveyMapper.addSurveyAnswer(srv);
			}
			
			if(cnt == surveyResultList.size()) {
				res = ServiceResult.OK;
			}else {
				throw new Exception();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int srvMntListCnt(PaginationVO<SurveyVO> pagingVO) {
		return surveyMapper.srvMntListCnt(pagingVO);
	}

	@Override
	public List<SurveyVO> srvMntList(PaginationVO<SurveyVO> pagingVO) {
		return surveyMapper.srvMntList(pagingVO);
	}

	@Override
	public SurveyVO getSurveyResult(int srvNo) {
		return surveyMapper.getSurveyResult(srvNo);
	}

	@Override
	public int getResultTotalCnt(int srvNo) {
		return surveyMapper.getResultTotalCnt(srvNo);
	}

	
	
	
}
