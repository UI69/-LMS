package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.IClassManagementMapper;
import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.service.IClassManagementService;
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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ClassManagementImpl implements IClassManagementService {

	@Inject
	private IClassManagementMapper classManagementMapper;

	@Inject
	private IFileMapper fileMapper;
	
//	@Override
//	public List<ClassVO> progressClassList(int memNo) {
//		return classManagementMapper.progressClassList(memNo);
//	}

	@Override
	public ServiceResult addClassBrd(ClassBoardVO classBoardVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		int filesCnt = 0;
		int brdCnt = 0;
		
		List<FilesVO> files = classBoardVO.getFileList();
		System.out.println("files : " + files);
		
		try {
			//파일 업로드
			if(files != null && files.size() > 0) {		//업로드할 파일이 있을때 
				log.info("is file...");
				
				//파일 번호 설정
				int fileNo = fileMapper.getFileSeq();
				for(FilesVO file : files) {
					file.setFileNo(fileNo);
				}
				
				filesCnt += fileMapper.addFile(files);
				
				//자료실 게시글 등록
				if(filesCnt == files.size()) {		//업로드 파일 갯수가 같을때
					classBoardVO.setFileNo(fileNo);
					brdCnt = classManagementMapper.addClassBrd(classBoardVO);
				}
			} else {	//업로드 파일이 없을때
				log.info("is not file...");
				//자료실 게시글 등록
				brdCnt = classManagementMapper.addClassBrd(classBoardVO);
			}
			
			//결과 반환, 에러처리
			if(brdCnt == 1) {
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
	public ServiceResult addClassHomework(HomeworkVO hwVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		int filesCnt = 0;
		int brdCnt = 0;
		
		List<FilesVO> files = hwVO.getFileList();
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
				
				//자료실 게시글 등록
				if(filesCnt == files.size()) {		//업로드 파일 갯수가 같을때
					hwVO.setFileNo(fileNo);
					brdCnt = classManagementMapper.addClassHomework(hwVO);
				}
			} else {	//업로드 파일이 없을때
				//자료실 게시글 등록
				brdCnt = classManagementMapper.addClassHomework(hwVO);
			}
			//결과 반환, 에러처리
			if(brdCnt == 1) {
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
	public List<HomeworkSubmitVO> getHwSubmitList(int classNo) {
		return classManagementMapper.getHwSubmitList(classNo);
	}

	@Override
	public List<HomeworkSubmitVO> getHwSubList(int hwNo) {
		return classManagementMapper.getHwSubList(hwNo);
	}

	@Override
	public ServiceResult updateHwScore(List<HomeworkSubmitVO> hwSubList) {
		ServiceResult res = ServiceResult.FAILED;
		
		int cnt = 0;
		try {
			for (int i = 0; i < hwSubList.size(); i++) {
				cnt += classManagementMapper.updateHwScore(hwSubList.get(i));
			}
			
			if(cnt != hwSubList.size()) {
				throw new Exception();
			} else {
				res = ServiceResult.OK;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<ExamAnswerVO> getExSubList(int examNo) {
		return classManagementMapper.getExSubList(examNo);
	}

	@Override
	public List<ListenerVO> myClassCheck(int classNo) {
		return classManagementMapper.myClassCheck(classNo);
	}

	@Override
	public ServiceResult addExample(ExampleVO exampleVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		int exCnt = 0;
		int qstCnt = 0;
		
		try {
			exCnt = classManagementMapper.addExample(exampleVO);
			//시험 등록
			if(exCnt != 1) {
				throw new Exception();
			}
			int examNo = exampleVO.getExamNo();

			// 문제 등록
				// 보기 등록
			for(ExampleQuestionVO exQst : exampleVO.getExamQstList()) {
				exQst.setExamNo(exampleVO.getExamNo());
				qstCnt += classManagementMapper.addQuestion(exQst);
				
				int chCnt = 0;
				int examQstNo = exQst.getExamQstNo();
				
				for(QuestionChoiceVO qstCh : exQst.getQstChList()) {
					qstCh.setExamNo(examNo);
					qstCh.setExamQstNo(examQstNo);
					chCnt += classManagementMapper.addQstChoiceList(qstCh);
				}
								
				if(chCnt != exQst.getQstChList().size()) {
					throw new Exception();
				}
			}
			
			if(qstCnt != exampleVO.getExamQstList().size()) {
				throw new Exception();
			} else {
				res = ServiceResult.OK;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceResult.FAILED;
		}
		
		return res;
	}

	@Override
	public List<ExampleVO> getExampleList(int classNo) {
		return classManagementMapper.getExampleList(classNo);
	}
	
	@Override
	public int attendCheck(List<AttendVO> attendList) {
		
		int cnt = 0;
		
		for(AttendVO atVO : attendList) {
			
			// 출석 추가 확인
			if(atVO.getAtNo() == 0) {
				cnt += classManagementMapper.attendCheck(atVO);	
			} else {	// 기존의 데이터 변경 확인
				
				AttendVO attendVO = classManagementMapper.getAttendCheck(atVO);	// 중복 체크 
				
				//변경 내용 체크
				if(attendVO.getAtStatus().equals(atVO.getAtStatus())) { 	// 출석 내용 변경 없음
					cnt++;
				}else {														// 출석 내용 업데이트
					cnt += classManagementMapper.updateAttendCheck(atVO);
				}
			}
		}
		
		if(cnt != attendList.size()) {
			try {
				throw new Exception();
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
		}
		
		return cnt;
	}
	
	@Override
	public List<ListenerVO> listenerList(int classNo) {
		return classManagementMapper.listenerList(classNo);
	}

	@Override
	public ListenerVO getListener(ListenerVO listenerVO) {
		return classManagementMapper.getListener(listenerVO);
	}

	@Override
	public ServiceResult addLectureRating(ListenerRatingVO listenerRatingVO) {
		ServiceResult res = ServiceResult.FAILED;
		int cnt = 0;
				
		int classNo = listenerRatingVO.getClassNo();
		int memNo = listenerRatingVO.getMemNo();
		int listenNo = listenerRatingVO.getListenNo();
		
		
		try {
			
			for(LectureRatingVO lectureRatingVO : listenerRatingVO.getLecRatingList() ) {
				lectureRatingVO.setClassNo(classNo);
				lectureRatingVO.setMemNo(memNo);
				lectureRatingVO.setListenNo(listenNo);
				
				cnt += classManagementMapper.addLectureRating(lectureRatingVO);
			}
			
			if(cnt == listenerRatingVO.getLecRatingList().size()) {
				int liCnt = classManagementMapper.updateListener(listenerRatingVO);
				
				if(liCnt != 1) {
					throw new Exception();
				} else {
					res = ServiceResult.OK;
				}
			} else {
				throw new Exception();
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	
	@Override
	public List<ListenerVO> examScoreList(int classNo) {
		return classManagementMapper.examScoreList(classNo);
	}
	@Override
	public List<ListenerVO> hwScoreList(int classNo) {
		return classManagementMapper.hwScoreList(classNo);
	}

	@Override
	public List<Map<String, Object>> atScoreList(int classNo) {
		return classManagementMapper.atScoreList(classNo);
	}

	@Override
	public Integer examStandartScore(int classNo) {
		return classManagementMapper.examStandartScore(classNo);
	}

	@Override
	public Integer hwStandartScore(int classNo) {
		return classManagementMapper.hwStandartScore(classNo);
	}	
	
	@Override
	public ServiceResult updateScore(List<ListenerVO> listenerList) {
		ServiceResult res = ServiceResult.FAILED;
		int status = 0;
		int classNo = 0;
		
		try {
			// 학점 일괄 update
			for(int i = 0; i < listenerList.size(); i++) {
				Map<String, Object> listenItem = (Map<String, Object>) listenerList.get(i);
				ListenerVO listenVO = new ListenerVO();
				classNo =  Integer.parseInt((String)listenItem.get("classNo"));
				String classScore = (String) listenItem.get("classScore");
				Integer memNo = (Integer) listenItem.get("memNo");
				
				listenVO.setClassNo(classNo);
				listenVO.setClassScore(classScore);
				listenVO.setMemNo(memNo);
				
				status += classManagementMapper.updateScore(listenVO);
			}
			
			if(status != listenerList.size()) {
				throw new Exception();
			}
			
			// 강의 상태 코드 update
			ClassVO classVO = new ClassVO();
			classVO.setClassNo(classNo);
			classVO.setClassStatusCode("CLS007");
			
			int cnt = 0;
			cnt = classManagementMapper.classStatusUpdate(classVO);
			if(cnt == 1) {
				res = ServiceResult.OK;
			} else {
				throw new Exception();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<ClassVO> scoreSetting(int memNo) {
		return classManagementMapper.scoreSetting(memNo);
	}

	@Override
	public List<ClassVO> progressClassList(PaginationVO<ClassVO> pagingVO, int memNo) {
		
		return classManagementMapper.progressClassList(pagingVO, memNo);
	}

	@Override
	public int managementCnt(PaginationVO<ClassVO> pagingVO, int memNo) {
		
		return classManagementMapper.managementCnt(pagingVO, memNo);
	}

	@Override
	public ScoreValueVO getScoreVal(int classNo) {
		return classManagementMapper.getScoreVal(classNo);
	}
	

	
}
