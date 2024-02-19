package kr.or.ddit.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.or.ddit.entity.FileType;
import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.IBoardService;
import kr.or.ddit.utils.UploadFileUtils;
import kr.or.ddit.vo.AnonymousBoardVO;
import kr.or.ddit.vo.AnonymousReplyVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.GalleryPaginationVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ReplyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class BoardController {

	@Inject
	private IBoardService boardService;

	// 게시판 관련

	// 공지 게시글 목록
	// 공지 게시글 상세
	// 공지 게시글 작성
	// 공지 게시글 수정

	// 분실물 게시글 목록

	// 익명 게시글 목록

	// 익명 페이징 검색 , 목록
	@RequestMapping(value = "/anonymouseBoard.do")
	public String anonyBoard(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {

		PaginationVO<AnonymousBoardVO> pagingVO = new PaginationVO<AnonymousBoardVO>();

		// 검색
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		pagingVO.setCurrentPage(currentPage);

		int totalRecord = boardService.anonyCount(pagingVO); // 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);

		List<AnonymousBoardVO> dataList = boardService.anonyList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("pagingVO", pagingVO);

		log.info("pagingVO 값 => {}", pagingVO);

		return "student/anonymousBoard";
	}

	// 댓글 추가
	@RequestMapping(value = "/addComment", method = RequestMethod.POST)
	public String addComment(AnonymousReplyVO replyVO) {

		log.info("replyVO : " + replyVO);

		int res = boardService.addAnonComment(replyVO);

		log.info("res :" + res);

//    	if(res == 0) {
//    		return "success";
//    	} else {
//    		return "failed";
//    	}

		return "redirect:/DYUniv/anonymousDetail.do?anonBrdNo=" + replyVO.getAnonBrdNo();
	}

	// 댓글 삭제
	@RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
	public String deleteComment(@RequestParam("anonRpNo") int anonRpNo, @RequestParam("anonBrdNo") int anonBrdNo,
			RedirectAttributes ra) {
		log.info("deleteComment() run..");
		log.info("anonRpNo : " + anonRpNo);

		int res = boardService.deleteComment(anonRpNo);

		if (res == 1) {
			ra.addFlashAttribute("message", "삭제 완료");
		} else {
			ra.addFlashAttribute("message", "삭제 실패");
		}
		return "redirect:/DYUniv/anonymousDetail.do?anonBrdNo=" + anonBrdNo;
	}

	@RequestMapping(value = "/ananytest2", method = RequestMethod.GET)
	public String anonytest1(Model model) {
		return "student/anonymousInsert";
	}

	@RequestMapping(value = "/ananytest3", method = RequestMethod.GET)
	public String anonytest2(Model model) {
		return "student/anonymousInsert";
	}

	// 익명 게시글 상세 + 익명 댓글 목록

	@RequestMapping(value = "/anonymousDetail.do", method = RequestMethod.GET)
	public String anonyDetail(int anonBrdNo, Model model, HttpServletRequest req) {
		log.info("anonyDetail() 실행");
		log.info("넘겨받은 anonBrdNo : " + anonBrdNo);

		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		model.addAttribute("member", memberVO);

		AnonymousBoardVO anonyVO = boardService.anoyDetail(anonBrdNo);
		model.addAttribute("anonyVO", anonyVO);

		List<AnonymousReplyVO> replyList = boardService.getAnonComments(anonBrdNo);
		model.addAttribute("replyList", replyList);

		return "student/anonymousDetail";
	}

	/*
	 * @RequestMapping(value="/anonymousDetail.do", method= RequestMethod.GET)
	 * public String anonyReply(int rpNo,Model model) { log.info("anonyReply() 실행"
	 * ); log.info("넘겨받은 rpNo : " + rpNo); ReplyVO replyVO =
	 * boardService.anonyReply(rpNo); model.addAttribute("replyVO",replyVO); return
	 * "student/anonymousDetail";
	 * 
	 * }
	 */
	// 익명 게시글 작성
	@RequestMapping(value = "/anonymousInsertForm.do", method = RequestMethod.GET)
	public String anonyInsertForm() {
		log.info("anonyInsertForm() 실행...!");

		return "student/anonymousInsert";

	}

	@RequestMapping(value = "/anonymousInsert.do", method = RequestMethod.POST)
	public String crudRegister(AnonymousBoardVO anonymousBoardVO, Model model, HttpServletRequest request)
			throws IOException {
		log.info("crudRegister() 실행...!");

		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");

		int memNo = member.getMemNo();

		log.info("member 값 => {}", member);
		log.info("memNo 값 => " + memNo);

		anonymousBoardVO.setMemNo(memNo);

		boardService.anonyInsert(anonymousBoardVO);
		// 게시글을 입력 후 최신 게시글 번호가 담겨있다(boardNo)
		log.info("게시글 등록 후 만들어진 최신 게시글 번호 : " + anonymousBoardVO.getAnonBrdNo());

		model.addAttribute("msg", "등록이 완료되었습니다!");
		return "redirect:/DYUniv/anonymousDetail.do?anonBrdNo=" + anonymousBoardVO.getAnonBrdNo();
	}

	@RequestMapping(value = "/anonytest", method = RequestMethod.GET)
	public String test(AnonymousBoardVO anonymousBoardVO, Model model) {
		return "student/anonymousInsert";
	}

	// 익명 게시글 삭제

	@RequestMapping(value = "/anonymousDelete.do", method = RequestMethod.POST)
	public String anonyDelete(HttpServletRequest req, int anonBrdNo, Model model, RedirectAttributes ra) {
		String goPage = "";

		ServiceResult result = boardService.deleteAnony(req, anonBrdNo);
		if (result.equals(ServiceResult.OK)) { // 삭제 성공
			goPage = "redirect:/DYUniv/anonymouseBoard.do";
			ra.addFlashAttribute("message", "게시글 삭제가 완료 되었습니다!");
		} else { // 삭제 실패
			goPage = "redirect:/DYUniv/anonymousDetail.do?anonBrdNo=" + anonBrdNo;
		}
		return goPage;
	}

	// 익명 댓글 작성
	// 익명 댓글 삭제

	// 강의 자료실 게시글 목록
	// 강의 게시글 상세
	// 강의 게시글 작성

	// 공지사항
	@RequestMapping(value = "/noticeBoard.do")
	public String noticeBoard(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, HttpServletRequest request, Model model) {

		PaginationVO<BoardVO> pagingVO = new PaginationVO<BoardVO>();

		// 리스트 게시글 수 설정
		pagingVO.setScreenSize(7);
		pagingVO.setMainscreenSize(7);

		// 검색
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		pagingVO.setCurrentPage(currentPage);

		int totalRecord = boardService.noticeBoardListCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<BoardVO> dataList = boardService.noticeBoardList(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);

		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");

		String memRole = member.getMemRole();

		model.addAttribute("memRole", memRole);
		model.addAttribute("pagingVO", pagingVO);

		if (member.getMemRole().equals("ROL003")) {
			// 관리자 정보
			return "employer/noticeBoard";
		} else if (member.getMemRole().equals("ROL002")) {
			// 교수정보
			return "professor/noticeBoard";
		} else /* (memberVO.getMemRole().equals("학생코드")) */ {
			return "student/noticeBoard";
		}
	}

	@RequestMapping(value = "/noticeBoardDetail.do/{brdNo}", method = RequestMethod.GET)
	public String detailNotice(@PathVariable("brdNo") int brdNo, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");

		String memRole = member.getMemRole();
		model.addAttribute("memRole", memRole);

		BoardVO boardVO = boardService.getBoardData(brdNo);
		model.addAttribute("boardVO", boardVO);

		log.info("boardVO : ", boardVO);

		if (member.getMemRole().equals("ROL003")) {
			// 관리자 정보
			return "employer/noticeBoardDetail";
		} else if (member.getMemRole().equals("ROL002")) {
			// 교수정보
			return "professor/noticeBoardDetail";
		} else /* (memberVO.getMemRole().equals("학생코드")) */ {
			return "student/noticeBoardDetail";
		}
	}

	@PostMapping("/noticeBoardDelete.do")
	public String deleteNotice(@RequestParam int brdNo, RedirectAttributes ra) {

		int res = boardService.deleteNotice(brdNo);

		if (res == 1) {
			ra.addFlashAttribute("message", "삭제에 성공하였습니다");
		} else {
			ra.addFlashAttribute("message", "삭제에 실패하였습니다");
		}

		return "redirect:/DYUniv/noticeBoard.do";
	}

	@GetMapping("/noticeBoardModify.do")
	public String ModifyNoticeGet(int brdNo, Model model) {

		BoardVO boardVO = boardService.selectNotice(brdNo);

		model.addAttribute("notice", boardVO);
		model.addAttribute("status", "u");

		return "employer/noticeBoardCreate";
	}

	@PostMapping("/noticeBoardModify.do")
	public String ModifyNoticePost(
			@RequestParam int brdNo, 
			@RequestParam String brdTitle, 
			@RequestParam String brdCont,
			HttpServletRequest request, 
			Model model) {
		
		BoardVO boardVO = new BoardVO();

		boardVO.setBrdNo(brdNo);
		boardVO.setBrdTitle(brdTitle);
		boardVO.setBrdCont(brdCont);
		
		int success = boardService.modifyNotice(boardVO);
		
		return "redirect:/DYUniv/noticeBoardDetail.do/" + brdNo;
	}

	// 공지사항 추가
	@GetMapping("/noticeBoardCreate.do")
	public String CreateNoticeGet() {
		return "employer/noticeBoardCreate";
	}

	@PostMapping("/noticeBoardCreate.do")
	public String CreateNoticePost(@RequestParam String brdTitle, @RequestParam String brdCont,
			HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");

		int memNo = member.getMemNo();
		String brdWriter = member.getMemId();

		BoardVO boardVO = new BoardVO();

		boardVO.setBrdTitle(brdTitle);
		boardVO.setBrdCont(brdCont);
		boardVO.setMemNo(memNo);
		boardVO.setBrdWriter(brdWriter);

		int success = boardService.createNotice(boardVO);
		int brdNo = boardVO.getBrdNo();

		/* return "redirect:/DYUniv/noticeBoardDetail.do/" + brdNo; */
		return "redirect:/DYUniv/noticeBoard.do";
	}

	// 공지사항 ck에디터 파일업로드
	@RequestMapping("/imageUpload.do")
	public String imageUpload(HttpServletRequest req, HttpServletResponse resp, MultipartHttpServletRequest multiFile)
			throws Exception {
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null; // 외부 응답으로 내보낼 때 사용 객체
		OutputStream out = null; // 본문 내용에 추가한 이미지를 파일로 생성할 객체
		long limitSize = 1024 * 1024 * 2; // 업로드 파일 최대 크기(2MB)

		MultipartFile file = multiFile.getFile("upload");

		// 파일 객체가 null이 아니고 파일 사이즈가 0보다 크고 파일명이 공백이 아닌 경우 무조건 파일 데이터가 존재할 경우
		if (file != null && file.getSize() > 0 && StringUtils.isNotBlank(file.getName())) {
			// 데이터 MIME타입이 'image/'를 포함한 이미지 파일인지 체크
			if (file.getContentType().toLowerCase().startsWith("image/")) {
				// 업로드 한 파일 사이즈가 최대 크기 2MB보다 클 때
				if (file.getSize() > limitSize) {
					JsonObject jsonMsg = new JsonObject();
					JsonArray jsonArr = new JsonArray();
					jsonMsg.addProperty("message", "2MB 미만의 이미지만 업로드 가능합니다.");
					jsonArr.add(jsonMsg);
					json.addProperty("uploaded", 0);
					json.add("error", jsonArr.get(0));

					// 위 형식의 Json 데이터를 출력한다.
					resp.setCharacterEncoding("UTF-8");
					printWriter = resp.getWriter();
					printWriter.println(json);
				} else { // 정상 크기 범위의 이미지 파일인 경우
					try {
						String fileName = file.getName(); // 파일명 얻어오기
						byte[] bytes = file.getBytes(); // 파일 데이터 얻어오기

						// 업로드 경로 설정
						String uploadPath = req.getServletContext().getRealPath("/resources/img");

						File uploadFile = new File(uploadPath);
						if (!uploadFile.exists()) {
							uploadFile.mkdirs();
						}

						fileName = UUID.randomUUID().toString(); // UUID의 random 파일명을 생성
						uploadPath = uploadPath + "/" + fileName + ".jpg"; // 업로드 경로 + 파일명
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes); // 파일복사

						printWriter = resp.getWriter();
						String fileUrl = req.getContextPath() + "/resources/img/" + fileName + ".jpg";

						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);

						// 위 형식의 JSON 데이터를 출력
						printWriter.println(json);
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						if (out != null)
							out.close();
						if (printWriter != null)
							printWriter.close();
					}
				}
			}
		}
		return null;
	}

	// 분실물 게시글 목록
	@RequestMapping(value = "/lostItemBoard.do")
	public String lostItemBoard(
			HttpServletRequest req ,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, HttpServletRequest request, Model model) {

		GalleryPaginationVO<BoardVO> grypagingVO = new GalleryPaginationVO<BoardVO>();
		
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		
		// 검색
		if (StringUtils.isNotBlank(searchWord)) {
			grypagingVO.setSearchType(searchType);
			grypagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		grypagingVO.setCurrentPage(currentPage);

		int totalRecord = boardService.lostItemListCnt(grypagingVO);
		grypagingVO.setTotalRecord(totalRecord);

		List<BoardVO> lostItemList = boardService.lostItems(grypagingVO);
		grypagingVO.setDataList(lostItemList);

		model.addAttribute("grypagingVO", grypagingVO);
		model.addAttribute("lostItemList", lostItemList);
		log.info("lostItemList :" + lostItemList);

		if(memberVO.getMemRoleStr().equals("교직원")) {
			return "employer/lostItemBoard";			
		} else {
			return "student/lostItemBoard";
		}
	}

	// 분실물 등록
	@PostMapping("/lostItemBoardinset.do")
	public String lostItemBoardinsert(BoardVO boardVO, HttpServletRequest req, RedirectAttributes ra) {

		log.debug("boardVO : " + boardVO);
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		int memNo = memberVO.getMemNo();

		boardVO.setMemNo(memNo);
		boardVO.setBrdType("BRD002");

		List<FilesVO> fileList = new ArrayList<FilesVO>();

		try {
			if (boardVO.getFileList() != null && boardVO.getFileList().size() > 0) {
				for (int i = 0; i < boardVO.getFiles().length; i++) {
					FilesVO filesVO = UploadFileUtils.uploadFile(boardVO.getFiles()[i], FileType.HOMEWORK_SUBMIT, req,
							boardVO.getBrdNo());

					filesVO.setFileGroupNo(i + 1);
					fileList.add(filesVO);
				}
				if (boardVO.getFiles().length != fileList.size()) {
					throw new Exception();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

			ra.addFlashAttribute("message", "파일 등록에 실패!!!");

			return "redirect:/DYUniv/employer/lostItemBoard/" + boardVO.getBrdNo();
		}
		log.debug("fileList : " + fileList);

		boardVO.setFileList(fileList);
		ServiceResult res = boardService.insertLostItem(boardVO);

		if (res.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "저장에 성공하였습니다");
		} else {
			ra.addFlashAttribute("message", "저장에 실패하였습니다");
		}

		return "redirect:/DYUniv/lostItemBoard.do";
	}
}
