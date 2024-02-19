package kr.or.ddit.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.AnonymousBoardVO;
import kr.or.ddit.vo.AnonymousReplyVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.GalleryPaginationVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ReplyVO;

public interface IBoardService {
	public List<BoardVO> noticeBoardList(PaginationVO<BoardVO> pagingVO);

	public int noticeBoardListCnt(PaginationVO<BoardVO> pagingVO);
	
	public List<BoardVO> noticeWidget();
	
	
	//분실물
	public List<BoardVO> lostItems(GalleryPaginationVO<BoardVO> grypagingVO);

	public ServiceResult insertLostItem(BoardVO boardVO);

	//대나무숲
	/* public List<AnonymousBoardVO> anonylist(); */
	
	public AnonymousBoardVO anoyDetail(int anonBrdNo);

	public void anonyInsert(AnonymousBoardVO anonymousBoardVO);

	public ServiceResult deleteAnony(HttpServletRequest req, int anonBrdNo);

	public int anonyCount(PaginationVO<AnonymousBoardVO> pagingVO);

	public List<AnonymousBoardVO> anonyList(PaginationVO<AnonymousBoardVO> pagingVO);

	public List<AnonymousReplyVO> getAnonComments(int brdNo);

	public int addAnonComment(AnonymousReplyVO replyVO);

	public void updateComment(ReplyVO replyVO);

	public int deleteComment(int rpNo);

	public BoardVO getBoardData(int brdNo);


	public int lostItemListCnt(GalleryPaginationVO<BoardVO> grypagingVO);


	public int createNotice(BoardVO boardVO);

	public BoardVO selectNotice(int brdNo);

	public int deleteNotice(int brdNo);

	public int modifyNotice(BoardVO boardVO);

}
