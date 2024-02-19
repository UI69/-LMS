package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.or.ddit.vo.AttendVO;
import kr.or.ddit.vo.ClassBoardVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.ExamAnswerVO;
import kr.or.ddit.vo.ExampleQuestionVO;
import kr.or.ddit.vo.ExampleVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.HomeworkSubmitVO;
import kr.or.ddit.vo.HomeworkVO;
import kr.or.ddit.vo.LectureRatingVO;
import kr.or.ddit.vo.ListenerAttendVO;
import kr.or.ddit.vo.ListenerRatingVO;
import kr.or.ddit.vo.ListenerVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.QuestionChoiceVO;
import kr.or.ddit.vo.ScoreValueVO;


@Service
public interface IClassManagementMapper {

	//List<ClassVO> progressClassList(int memNo);

	int addClassBrd(ClassBoardVO classBoardVO);

	int addClassHomework(HomeworkVO hwVO);

	List<HomeworkSubmitVO> getHwSubmitList(int classNo);

	List<HomeworkSubmitVO> getHwSubList(int hwNo);

	int updateHwScore(HomeworkSubmitVO homeworkSubmitVO);

	List<ExamAnswerVO> getExSubList(int examNo);

	List<ListenerVO> myClassCheck(int classNo);

	int addQstChoiceList(QuestionChoiceVO qstCh);

	int addQuestion(ExampleQuestionVO exQst);

	int addExample(ExampleVO exampleVO);

	List<ExampleVO> getExampleList(int classNo);

	int attendCheck(AttendVO atVO);

	AttendVO getAttendCheck(AttendVO atVO);

	int updateAttendCheck(AttendVO atVO);
	
	List<ListenerVO> listenerList(int classNo);

	ListenerVO getListener(ListenerVO listenerVO);

	int addLectureRating(LectureRatingVO lectureRatingVO);

	int updateListener(ListenerRatingVO listenerRatingVO);
	
	List<ListenerVO> examScoreList(int classNo);

	List<ListenerVO> hwScoreList(int classNo);

	List<Map<String, Object>> atScoreList(int classNo);

	Integer examStandartScore(int classNo);

	Integer hwStandartScore(int classNo);
	
	int updateScore(ListenerVO listenVO);

	List<ClassVO> scoreSetting(int memNo);

	int classStatusUpdate(ClassVO classVO);


	List<ClassVO> progressClassList(@Param("pagingVO") PaginationVO<ClassVO> pagingVO,@Param("memNo") int memNo);

	int managementCnt(@Param("pagingVO") PaginationVO<ClassVO> pagingVO,@Param("memNo") int memNo);

	ScoreValueVO getScoreVal(int classNo);

}
