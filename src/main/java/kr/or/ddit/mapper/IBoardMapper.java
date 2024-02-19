package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.AnonymousBoardVO;
import kr.or.ddit.vo.AnonymousReplyVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.GalleryPaginationVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ReplyVO;

public interface IBoardMapper {
	//공지사항
	public List<BoardVO> noticeBoardList(@Param("pagingVO")PaginationVO<BoardVO> pagingVO);
	
	public int noticeBoardListCnt(@Param("pagingVO")PaginationVO<BoardVO> pagingVO);

	public List<BoardVO> noticeWidget();
	
	/* public List<AnonymousBoardVO> anonyList(); */
	
	public AnonymousBoardVO anonyDetail(int anonBrdNo);
	
	
	public int anonyCount(PaginationVO<AnonymousBoardVO> pagingVO);
	
	public List<AnonymousBoardVO> anonyList(PaginationVO<AnonymousBoardVO> pagingVO);
	
	public void anonIncHitCount(int anonBrdNo);
	 // 댓글 목록을 가져오는 메소드
    public List<AnonymousReplyVO> getAnonComments(int brdNo);
    
    // 댓글을 추가하는 메소드 
    public int addAnonComment(AnonymousReplyVO replyVO);
    
    // 댓글을 수정하는 메소드
    public int updateComment(ReplyVO replyVO);
    
    // 댓글을 삭제하는 메소드
    public int deleteComment(int rpNo);
	//분실물---------------------------
	//리스트
	public List<BoardVO> lostItems(GalleryPaginationVO<BoardVO> grypagingVO);
	//등록
	public int insertLostItem(BoardVO boardVO);

	public void insert(AnonymousBoardVO anonymousBoardVO);

	public int delete(int anonBrdNo);

	public BoardVO getBoardData(int brdNo);

	public void boardCountHit(int brdNo);

	public int lostItemListCnt(GalleryPaginationVO<BoardVO> grypagingVO);

	public int createNotice(BoardVO boardVO);

	public BoardVO selectNotice(int brdNo);

	public int deleteNotice(int brdNo);

	public int modifyNotice(BoardVO boardVO);

}
