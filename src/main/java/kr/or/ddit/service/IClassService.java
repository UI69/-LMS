package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.entity.ServiceResult;
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

public interface IClassService {
	
	public MemberVO getMyMember(int memNo);

	public List<MyClassVO> getMyLectureList(int memNo);
	public MyClassVO getMyLecture(int classNo);

	public List<ClassBoardVO> getClassBoardList(int classNo);
	
	public ClassBoardVO getClassBoard(int classBrdNo);
	
	public List<HomeworkVO> getHomeworkList(int classNo);
	
	public ServiceResult insertHomework(HomeworkSubmitVO homeworkSubmitVO);

	public List<ExampleVO> getExampleList(Map<String, String> examMap);

	public List<TrainingVO> getTrainingList(int classNo);

	public int classOpenCnt(PaginationVO<ClassVO> pagingVO, int memNo);

	public List<ClassVO> classOpenList(PaginationVO<ClassVO> pagingVO, int memNo);

	public List<MyClassVO> classScheduleList(int memNo);
	
	public List<MyClassVO> classScheduleList2(MyClassVO myClassVO);

	public ServiceResult createClassOpen(ClassVO classVO);

	public List<MyClassVO> memberList();

	public List<MemberStdVO> memberStuList();

	public List<ClassVO> todayProcessClassListPro(int memNo);

	public List<HomeworkSubmitVO> getHomeworkSubmitList(Map<String, String> dataMap);

	public List<ClassVO> todayProcessClassListStu(int memNo);

	public ServiceResult updateHomeworkSb(HomeworkSubmitVO homeworkSubmitVO);

	public HomeworkSubmitVO homeworkSubmitDetail(int hwSbNo);

	public ExampleQuestionVO getExampleQst(int examNo);

}