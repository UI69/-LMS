package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.SurveyResultVO;
import kr.or.ddit.vo.SurveyVO;
import kr.or.ddit.entity.ServiceResult;

public interface ISurveyService {

	public int surveyListCnt(PaginationVO<SurveyVO> pagingVO);

	public List<SurveyVO> surveyList(PaginationVO<SurveyVO> pagingVO);

	public SurveyVO getSurvey(int srvNo);

	ServiceResult addSurvey(SurveyVO surveyVO);

	public ServiceResult addSurveyAnswer(int memNo, List<SurveyResultVO> surveyResultList);

	public int srvMntListCnt(PaginationVO<SurveyVO> pagingVO);

	public List<SurveyVO> srvMntList(PaginationVO<SurveyVO> pagingVO);

	public SurveyVO getSurveyResult(int srvNo);

	public int getResultTotalCnt(int srvNo);
}
