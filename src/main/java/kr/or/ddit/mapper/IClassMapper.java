package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.ClassBoardVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.ExampleQuestionVO;
import kr.or.ddit.vo.ExampleVO;
import kr.or.ddit.vo.HomeworkSubmitVO;
import kr.or.ddit.vo.HomeworkVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.MyClassVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.TrainingVO;

public interface IClassMapper {
	
	public MemberVO getMyMember(int memNo);

	public List<MyClassVO> getMyLectureList(int memNo);
	public MyClassVO getMyLecture(int classNo);

	public List<ClassBoardVO> getClassBoardList(int classNo);
	public ClassBoardVO getClassBoard(int classBrdNo);
	public void incrementClassBrdHit(int classBrdNo);

	public List<HomeworkVO> getHomeworkList(int classNo);
	public int insertHomework(HomeworkSubmitVO homeworkSubmitVO);
	
	public List<ExampleVO> getExampleList(Map<String, String> examMap);

	public List<TrainingVO> getTrainingList(int classNo);

	public int classOpenCnt(@Param("pagingVO") PaginationVO<ClassVO> pagingVO, @Param("memNo") int memNo);

	public List<ClassVO> classOpenList(@Param("pagingVO") PaginationVO<ClassVO> pagingVO, @Param("memNo") int memNo);

	public List<MyClassVO> classScheduleList(int memNo);

	public List<MyClassVO> classScheduleList2(MyClassVO myClassVO);

	public List<MyClassVO> memberList();

	public List<MemberStdVO> memberSutList();

	public int createClassOpen(ClassVO classVO);

	public List<ClassVO> todayProcessClassListPro(int memNo);
	public List<ClassVO> todayProcessClassListStu(int memNo);

	public List<HomeworkSubmitVO> getHomeworkSubmitList(Map<String, String> dataMap);

	public int updateHomeworkSb(HomeworkSubmitVO homeworkSubmitVO);

	public HomeworkSubmitVO homeworkSubmitDetail(int hwSbNo);

	public ExampleQuestionVO getExampleQst(int examNo);

}