package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.IClassMapper;
import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.mapper.ILectureScheduleMapper;
import kr.or.ddit.service.IClassService;
import kr.or.ddit.vo.ClassBoardVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.ExampleQuestionVO;
import kr.or.ddit.vo.ExampleVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.HomeworkSubmitVO;
import kr.or.ddit.vo.HomeworkVO;
import kr.or.ddit.vo.LectureScheduleVO;
import kr.or.ddit.vo.ListenerVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.MyClassVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.TrainingVO;

@Service
public class ClassServiceImpl implements IClassService{

	@Inject
	IClassMapper classMapper;
	
	@Inject
	ILectureScheduleMapper lectureScheduleMapper;
	
	@Inject
	IFileMapper fileMapper;

	@Override
	public List<MyClassVO> getMyLectureList(int memNo) {
		
		return classMapper.getMyLectureList(memNo);
	}

	@Override
	public List<ClassBoardVO> getClassBoardList(int classNo) {
		
		return classMapper.getClassBoardList(classNo);
	}
	
	@Override
	public List<HomeworkVO> getHomeworkList(int classNo) {
		return classMapper.getHomeworkList(classNo);
	}
	
	@Override
	public ServiceResult insertHomework(HomeworkSubmitVO homeworkSubmitVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		int filesCnt = 0;
		int hwCnt = 0;
		
		List<FilesVO> files = homeworkSubmitVO.getFileList();
		System.out.println("files : " + files);
		
		try {
			//파일 업로드
			if(files != null && files.size() > 0) {		//업로드할 파일이 있을때 
				//파일 번호 설정
				int fileNo = fileMapper.getFileSeq();
				for(FilesVO file : files) {
					file.setFileNo(fileNo);
				}
				
				filesCnt += fileMapper.addFile(files);
				
				//과제 등록
				if(filesCnt == files.size()) {		//업로드 파일 갯수가 같을때
					homeworkSubmitVO.setFileNo(fileNo);
					hwCnt = classMapper.insertHomework(homeworkSubmitVO);
				}
			} else {	//업로드 파일이 없을때
				//과제 등록
				hwCnt = classMapper.insertHomework(homeworkSubmitVO);
			}
			//결과 반환, 에러처리
			if(hwCnt == 1) {
				res = ServiceResult.OK;
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceResult.FAILED;
		}
		return res;
	}
	

	@Override
	public List<ExampleVO> getExampleList(Map<String, String> examMap) {
		return classMapper.getExampleList(examMap);
	}

	@Override
	public List<TrainingVO> getTrainingList(int classNo) {
		return classMapper.getTrainingList(classNo);
	}

	@Override
	public MyClassVO getMyLecture(int classNo) {
		return classMapper.getMyLecture(classNo);
	}

	@Override
	public MemberVO getMyMember(int memNo) {
		return classMapper.getMyMember(memNo);
	}
	
	@Override
	public ClassBoardVO getClassBoard(int classBrdNo) {
		
		classMapper.incrementClassBrdHit(classBrdNo);
		
		return classMapper.getClassBoard(classBrdNo);
	}

	
	
	@Override
	public int classOpenCnt(PaginationVO<ClassVO> pagingVO, int memNo) {
		return classMapper.classOpenCnt(pagingVO, memNo);
	}

	@Override
	public List<ClassVO> classOpenList(PaginationVO<ClassVO> pagingVO, int memNo) {
		return classMapper.classOpenList(pagingVO, memNo);
	}

	@Override
	public List<MyClassVO> classScheduleList(int memNo) {
		return classMapper.classScheduleList(memNo);
	}

	@Override
	public ServiceResult createClassOpen(ClassVO classVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		int filesCnt = 0;
		int classCnt = 0;
		int sheduleCnt = 0;
		
		FilesVO file = classVO.getFile();
		
		try {
			// 강의계획서 업로드
			int fileNo = 0;
			if(file != null && file.getFilePath() != null) {
				System.out.println("files : " + file);
				filesCnt += fileMapper.createFile(file);
				fileNo = file.getFileNo();					
			}
			
			System.out.println("강의계획서 업로드 성공 !~");
			
			// 강의개설
			int classNo = 0;
			if(filesCnt == 1){
				classVO.setFileNo(fileNo);
				classCnt = classMapper.createClassOpen(classVO);
				classNo = classVO.getClassNo();
			}

			System.out.println("강의 개설 성공 !~");
			
			// 강의스케줄 생성
			if(classCnt == 1) {
				List<LectureScheduleVO> lecScheduleList = classVO.getLecScheduleList();
				for(LectureScheduleVO lecScheduleVO : lecScheduleList) {
					System.out.println("lecScheduleVO : " + lecScheduleVO);
					
					lecScheduleVO.setClassNo(classNo);
					sheduleCnt += lectureScheduleMapper.createLectureSchedule(lecScheduleVO);
				}
			}

			System.out.println("강의 스케줄 생성 성공 !~");
			
			//에러처리
			if(sheduleCnt == classVO.getLecScheduleList().size()) {
				res = ServiceResult.OK;
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceResult.FAILED;
		}
		
		return res;
	}

	@Override
	public List<MyClassVO> classScheduleList2(MyClassVO myClassVO) {
		return classMapper.classScheduleList2(myClassVO);
	}

	@Override
	public List<MyClassVO> memberList() {
		return classMapper.memberList();
	}

	@Override
	public List<MemberStdVO> memberStuList() {
		return classMapper.memberSutList();
	}

	@Override
	public List<ClassVO> todayProcessClassListPro(int memNo) {
		return classMapper.todayProcessClassListPro(memNo);
	}
	
	@Override
	public List<HomeworkSubmitVO> getHomeworkSubmitList(Map<String, String> dataMap) {
		return classMapper.getHomeworkSubmitList(dataMap);
	}

	@Override
	public List<ClassVO> todayProcessClassListStu(int memNo) {
		return classMapper.todayProcessClassListStu(memNo);
	}
	@Override
	public ServiceResult updateHomeworkSb(HomeworkSubmitVO homeworkSubmitVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		int filesCnt = 0;
		int hwCnt = 0;
		
		List<FilesVO> files = homeworkSubmitVO.getFileList();
		System.out.println("files : " + files);
		
		try {
			//파일 업로드
			if(files != null && files.size() > 0) {		//업로드할 파일이 있을때 
				//파일 번호 설정
				int fileNo = fileMapper.getFileSeq();
				for(FilesVO file : files) {
					file.setFileNo(fileNo);
				}
				
				filesCnt += fileMapper.addFile(files);
				
				//과제 등록
				if(filesCnt == files.size()) {		//업로드 파일 갯수가 같을때
					homeworkSubmitVO.setFileNo(fileNo);
					hwCnt = classMapper.updateHomeworkSb(homeworkSubmitVO);
				}
			} else {	//업로드 파일이 없을때
				//과제 등록
				hwCnt = classMapper.updateHomeworkSb(homeworkSubmitVO);
			}
			//결과 반환, 에러처리
			if(hwCnt == 1) {
				res = ServiceResult.OK;
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceResult.FAILED;
		}
		
		return res;
		//return classMapper.updateHomeworkSb(homeworkSubmitVO);
	}

	@Override
	public HomeworkSubmitVO homeworkSubmitDetail(int hwSbNo) {
		
		return classMapper.homeworkSubmitDetail(hwSbNo);
	}

	@Override
	public ExampleQuestionVO getExampleQst(int examNo) {		
		return classMapper.getExampleQst(examNo);
	}



}
