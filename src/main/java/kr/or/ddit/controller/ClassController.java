package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.entity.FileType;
import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.IClassService;
import kr.or.ddit.service.IProfessorInfoService;
import kr.or.ddit.service.IScoreValueService;
import kr.or.ddit.utils.UploadFileUtils;
import kr.or.ddit.vo.ClassBoardVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.ExampleQuestionVO;
import kr.or.ddit.vo.ExampleVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.HomeworkSubmitVO;
import kr.or.ddit.vo.HomeworkVO;
import kr.or.ddit.vo.LectureScheduleVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.MyClassVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ProfessorInfoVO;
import kr.or.ddit.vo.ScoreValueVO;
import kr.or.ddit.vo.TrainingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class ClassController {
	// 강의 관련

	// 강의 개설 신청
	// 강의 목록
	// 강의 상세

	// 내 강의 목록
	// 수강 시간표 조회
	// 성적 조회

	// 과제 목록
	// 과제 상세
	// 과제 생성
	// 과제 수정
	// 교수 기준 과제 제출 목록
	// 교수 기준 과제 제출 상세
	// 과제 점수 등록

	// 온라인 시험 목록
	// 온라인 시험 응시
	// 온라인 시험 제출
	// 온라인 시험 결과
	// 온라인 시험 출제
	// 시험 점수 등록?

	// 현장실습 신청
	// 현장실습 목록

	// 강의 평가
	// 강의 평가 결과

	// 성적 조회
	// 성적 입력
	// 성적 등록
	// 성적 정정(이의) 신청 목록
	// 성적 정정 허가/반려

	// 회원 출결 목록
	// 강의 출결 목록
	// 강의 출결 등록

	// 이 밑으로 구현 ============================================

	@Inject
	private IClassService classService;

	@Inject
	private IProfessorInfoService professorInfoService;

	@Inject
	private IScoreValueService scoreValueService;

	// 내 강의 리스트
	@GetMapping("/student/class/myClassList.do")
	public String myClassList(Model model, HttpServletRequest req) {

		HttpSession session = req.getSession();

		MemberVO memberVO = (MemberVO) session.getAttribute("member");

		int memNo = memberVO.getMemNo();
		
		List<MyClassVO> mylectureList = classService.getMyLectureList(memNo);
		model.addAttribute("mylectureList", mylectureList);

		return "student/myClassList";
	}

	// 학생 강의 화면
	@GetMapping("/student/class/classRoom/{classNo}")
	public String stdClassRoom(HttpServletRequest req, Model model, @PathVariable int classNo) {

		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");

		// 내 강의 정보
		MyClassVO myClassVO = classService.getMyLecture(classNo);
		model.addAttribute("myClassVO", myClassVO);

		// 강의자료실
		List<ClassBoardVO> classBoardList = classService.getClassBoardList(classNo);
		model.addAttribute("classBoardList", classBoardList);

		// 강의 과제
		List<HomeworkVO> homeworkList = classService.getHomeworkList(classNo);
		model.addAttribute("homeworkList", homeworkList);

		// 내 과제 제출 리스트
		int memNo = memberVO.getMemNo();
		Map<String, String> dataMap = new HashMap<String, String>();
		dataMap.put("memNo", String.valueOf(memNo));
		dataMap.put("classNo", String.valueOf(classNo));

		List<HomeworkSubmitVO> homeworkSubmitList = classService.getHomeworkSubmitList(dataMap);
		model.addAttribute("homeworkSubmitList", homeworkSubmitList);
		log.debug("homeworkSubmitList" + homeworkSubmitList);

		// 온라인 시험
		List<ExampleVO> exampleList = classService.getExampleList(dataMap);
		model.addAttribute("exampleList", exampleList);

		// 현장실습
		List<TrainingVO> trainingList = classService.getTrainingList(classNo);
		model.addAttribute("trainingList", trainingList);


		return "student/classRoom";
	}

	/* 과제 제출 */
	@PostMapping("/homeWorkSubmit.do")
	public String homeWorkSubmit(HttpSession session, HomeworkSubmitVO homeworkSubmitVO, int classNo,
			HttpServletRequest req, RedirectAttributes ra) {
		log.debug("homeWorkSubmit실행...!{}", homeworkSubmitVO);

		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();

		homeworkSubmitVO.setMemNo(memNo);

		if (homeworkSubmitVO.getHwSbNo() == 0) {		// 신규제출

			homeworkSubmitVO.setHwSbStatusCode("HWS002");
			List<FilesVO> fileList = new ArrayList<FilesVO>();

			try {
				/* 과제 없로드 */
				if (homeworkSubmitVO.getFileList() != null && homeworkSubmitVO.getFileList().size() > 0) {
					for (int i = 0; i < homeworkSubmitVO.getFiles().length; i++) {

						FilesVO filesVO = UploadFileUtils.uploadFile(homeworkSubmitVO.getFiles()[i],
								FileType.HOMEWORK_SUBMIT, req, homeworkSubmitVO.getHwSbNo());
						filesVO.setFileGroupNo(i + 1);
						fileList.add(filesVO);
					}

					if (homeworkSubmitVO.getFiles().length != fileList.size()) {
						throw new Exception();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				ra.addFlashAttribute("message", "파일 등록에 실패!!!");
				return "redirect:/DYUniv/student/class/classRoom/" + classNo;
			}

			log.debug("fileList : " + fileList);

			homeworkSubmitVO.setFileList(fileList);

			ServiceResult res = classService.insertHomework(homeworkSubmitVO);

			if (res.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "저장에 성공하였습니다");
			} else {
				ra.addFlashAttribute("message", "저장에 실패하였습니다");
			}

			return "redirect:/DYUniv/student/class/classRoom/" + classNo;
			
		} else {
			 
			//int hwSuNo = classService.updateHomeworkSb(homeworkSubmitVO);
			log.debug("update HomeworkSb : "+ homeworkSubmitVO);
			// >> update 하거나
			// >> 기존의 것을 delete, 그다음 insert
			
			List<FilesVO> fileList = new ArrayList<FilesVO>();
			try {
				/* 과제 없로드 */
				if (homeworkSubmitVO.getFileList() != null && homeworkSubmitVO.getFileList().size() > 0) {
					for (int i = 0; i < homeworkSubmitVO.getFiles().length; i++) {

						FilesVO filesVO = UploadFileUtils.uploadFile(homeworkSubmitVO.getFiles()[i],
								FileType.HOMEWORK_SUBMIT, req, homeworkSubmitVO.getHwSbNo());
						filesVO.setFileGroupNo(i + 1);
						fileList.add(filesVO);
					}

					if (homeworkSubmitVO.getFiles().length != fileList.size()) {
						throw new Exception();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				ra.addFlashAttribute("message", "파일 등록에 실패!!!");
				return "redirect:/DYUniv/student/class/classRoom/" + classNo;
			}

			log.debug("fileList : " + fileList);

			homeworkSubmitVO.setFileList(fileList);

			//ServiceResult res = classService.insertHomework(homeworkSubmitVO);
			ServiceResult res = classService.updateHomeworkSb(homeworkSubmitVO);
			
			if (res.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "저장에 성공하였습니다");
			} else {
				ra.addFlashAttribute("message", "저장에 실패하였습니다");
			}
			
			
		}

		return "redirect:/DYUniv/student/class/classRoom/" + classNo;
	}

	/* 시험 문제 출력 */
	@PostMapping("/exampleQuestion.do")
	public ExampleQuestionVO exampleQuestion(HttpSession session, int examNo, Model model) {
		log.debug("exampleQuestiont실행!!!:");
		ExampleQuestionVO exampleQuestionVO = classService.getExampleQst(examNo);

		model.addAttribute("exampleQuestionVO", exampleQuestionVO);
		log.debug("exampleQuestionVO{}:" + exampleQuestionVO);

		return exampleQuestionVO;
	}

	// 비동기 처리 ============================================

	/* 내 과제제출 가져오기 */
	  @ResponseBody
	  @PostMapping("/homeworkSubmitDetail.do") 
	  public HomeworkSubmitVO hwSubDetail(@RequestBody Map<String, Integer> hwSuMap ) {
	  
		  log.debug("hwSubDetail 실행!!!!{}",hwSuMap);
		  
		  HomeworkSubmitVO homeworkSubmitVO = classService.homeworkSubmitDetail(hwSuMap.get("hwSbNo"));
	  
		  return homeworkSubmitVO;
	  
	  }
	 

	/* 강의 자료실 Detail */
	@ResponseBody
	@GetMapping("/getClassBoardDetail.do")
	public ClassBoardVO getClassBoardDetail(int classBrdNo) {

		/* log.debug("classBrdNo"+ classBrdNo); */

		ClassBoardVO classBoardVO = classService.getClassBoard(classBrdNo);

		/* log.debug("classBoardVO"+ classBoardVO); */

		return classBoardVO;
	}

	///////////////////// 교수 강의 관련

	// 전체 강의 목록
	@GetMapping("/professor/classOpenList.do")
	public String ClassOpenList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "className") String searchType,
			@RequestParam(required = false) String searchWord, HttpServletRequest request, Model model) {

		/// 값 부여
		PaginationVO<ClassVO> pagingVO = new PaginationVO<ClassVO>();
		
		pagingVO.setScreenSize(7);
		pagingVO.setMainscreenSize(7);

		System.out.println("searchType" + searchType);
		System.out.println("searchWord" + searchWord);

		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		pagingVO.setCurrentPage(currentPage);

		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");

		int memNo = memberVO.getMemNo();

		System.out.println("memNo" + memNo);

		/// 서비스(로그인한 교수의 모든 강의 가져오기)
		// 총 게시글 수 가져오기
		int totalRecord = classService.classOpenCnt(pagingVO, memNo);
		pagingVO.setTotalRecord(totalRecord);
		// 총 목록 가져오기
		List<ClassVO> dataList = classService.classOpenList(pagingVO, memNo);
		pagingVO.setDataList(dataList);

		/// 값 주기
		model.addAttribute("pagingVO", pagingVO);
		return "professor/classOpenList";

	}

	// 강의 개설
	@GetMapping("/professor/newClassOpen.do")
	public String newClassOpen(Model model, HttpServletRequest req) {
		// 값꺼내기
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
		// 메소드
		ProfessorInfoVO professorInfoVO = professorInfoService.getAllProfessorInfo(memNo);
		List<LectureVO> lectureList = scoreValueService.getLectureList(memNo);
		List<ScoreValueVO> ScoreValueList = scoreValueService.getAllScoreValueData();
		
		
		// 값담기
		model.addAttribute("lectureList", lectureList);
		model.addAttribute("professorInfoVO", professorInfoVO);
		model.addAttribute("ScoreValueList", ScoreValueList);
		
		System.out.println("professorInfoVO" + professorInfoVO);
		
		return "professor/newClassOpen";
	}

	@ResponseBody
	@PostMapping("/professor/newClassOpen.do")
	public String createClassOpen(@RequestPart("classVO") ClassVO classVO, MultipartFile fileName,
			HttpServletRequest req, RedirectAttributes ra) {

		log.info("createClassOpen 실행 !");
		log.debug("ck:{}", classVO);
		log.info("req : " + req.toString());

		// validation 체크, 특히 파일
		if (fileName == null) {
			ra.addFlashAttribute("message", "강의 개설 실패");
			return "redirect:/professor/classOpenList.do";
		}

		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");

		int memNo = memberVO.getMemNo();

		classVO.setMemNo(memNo);
		classVO.setLecNo(classVO.getLectureList().get(0).getLecNo());

		// 파일업로드(강의계획서)
		try {
			FilesVO filesVO = UploadFileUtils.uploadFile(fileName, FileType.CLASS, req);
			classVO.setFile(filesVO);

			if (filesVO.getFilePath() == null) {
				throw new Exception();
			}

		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("message", "강의 개설 실패");
			return "redirect:/professor/classOpenList.do";
		}

		ServiceResult res = classService.createClassOpen(classVO);

		log.info("file upload success");

		if (res.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "강의 개설 성공");
		} else {
			ra.addFlashAttribute("message", "강의 개설 실패");
		}

		return "redirect:/professor/classOpenList.do";
	}

	// 수업 관리 메인
	@RequestMapping(value = "/professor/classRoom.do", method = RequestMethod.GET)
	public String proClassRoom() {
		return "professor/classRoom";
	}

	// 강의 시간표(임시)
	@GetMapping("/student/class/classSchedule.do")
	public String classSchedule(Model model, HttpServletRequest req) {

		HttpSession session = req.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");

		log.info("member : " + member);
		log.info("member.memNo : " + member.getMemNo());

		List<MyClassVO> classScheduleList = classService.classScheduleList(member.getMemNo());
		List<MemberStdVO> memberSutList = classService.memberStuList();

		model.addAttribute("classScheduleList", classScheduleList);
		model.addAttribute("memberSutList", memberSutList);
		return "student/classSchedule";
	}

	// 강의 시간표(ajax)
	@ResponseBody
	@GetMapping("/student/class/classSchedule.ajax")
	public List<MyClassVO> classSchedule2(HttpServletRequest req) {
		log.info("classSchedule2()..");

		HttpSession session = req.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");

		log.info("member : " + member);
		log.info("memNo : " + member.getMemNo());

		MyClassVO myClassVO = new MyClassVO();
		myClassVO.setMemNo(member.getMemNo());
		return classService.classScheduleList2(myClassVO);
	}

}
