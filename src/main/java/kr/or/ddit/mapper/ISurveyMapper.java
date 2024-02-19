package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.SurveyQuestionChoiceVO;
import kr.or.ddit.vo.SurveyQuestionVO;
import kr.or.ddit.vo.SurveyResultVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.SurveyVO;

public interface ISurveyMapper {

	public int surveyListCnt(PaginationVO<SurveyVO> pagingVO);

	public List<SurveyVO> surveyList(PaginationVO<SurveyVO> pagingVO);

	public SurveyVO getSurvey(int srvNo);

	int addSurvey(SurveyVO surveyVO);

	int addSrvQuestion(SurveyQuestionVO srvQst);

	int addSrvQstChoice(SurveyQuestionChoiceVO srvQstCh);

	public int addSurveyAnswer(SurveyResultVO srv);

	public int srvMntListCnt(PaginationVO<SurveyVO> pagingVO);

	public List<SurveyVO> srvMntList(PaginationVO<SurveyVO> pagingVO);

	public SurveyVO getSurveyResult(int srvNo);

	public int getResultTotalCnt(int srvNo);
}
