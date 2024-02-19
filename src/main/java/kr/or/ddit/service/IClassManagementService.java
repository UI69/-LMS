package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.AttendVO;
import kr.or.ddit.vo.ClassBoardVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.ExamAnswerVO;
import kr.or.ddit.vo.ExampleVO;
import kr.or.ddit.vo.HomeworkSubmitVO;
import kr.or.ddit.vo.HomeworkVO;
import kr.or.ddit.vo.ListenerAttendVO;
import kr.or.ddit.vo.ListenerRatingVO;
import kr.or.ddit.vo.ListenerVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ScoreValueVO;

public interface IClassManagementService {

	List<ClassVO> progressClassList(PaginationVO<ClassVO> pagingVO, int memNo);

	ServiceResult addClassBrd(ClassBoardVO classBoardVO);

	ServiceResult addClassHomework(HomeworkVO hwVO);

	List<HomeworkSubmitVO> getHwSubmitList(int classNo);

	List<HomeworkSubmitVO> getHwSubList(int hwNo);

	ServiceResult updateHwScore(List<HomeworkSubmitVO> hwSubList);

	List<ExamAnswerVO> getExSubList(int examNo);

	ServiceResult addExample(ExampleVO exampleVO);

	List<ExampleVO> getExampleList(int classNo);

	List<ListenerVO> myClassCheck(int classNo);

	int attendCheck(List<AttendVO> attendList);
	
	List<ListenerVO> listenerList(int classNo);

	ListenerVO getListener(ListenerVO listenerVO);

	ServiceResult addLectureRating(ListenerRatingVO listenerRatingVO);
	
	List<ListenerVO> examScoreList(int classNo);

	List<ListenerVO> hwScoreList(int classNo);

	List<Map<String, Object>> atScoreList(int classNo);

	Integer examStandartScore(int classNo);

	Integer hwStandartScore(int classNo);

	ServiceResult updateScore(List<ListenerVO> listenerList);

	List<ClassVO> scoreSetting(int memNo);

	int managementCnt(PaginationVO<ClassVO> pagingVO, int memNo);

	ScoreValueVO getScoreVal(int classNo);
	
	
}
