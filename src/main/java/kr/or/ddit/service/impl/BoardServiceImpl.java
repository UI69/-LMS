package kr.or.ddit.service.impl;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.IBoardMapper;
import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.service.IBoardService;
import kr.or.ddit.vo.AnonymousBoardVO;
import kr.or.ddit.vo.AnonymousReplyVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.GalleryPaginationVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ReplyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements IBoardService {

	@Inject
	private IBoardMapper boardMapper;
	
	@Inject
	IFileMapper fileMapper;

	@Override
	public List<BoardVO> noticeBoardList(PaginationVO<BoardVO> pagingVO) {
		return boardMapper.noticeBoardList(pagingVO);
	}

	@Override
	public int noticeBoardListCnt(PaginationVO<BoardVO> pagingVO) {
		return boardMapper.noticeBoardListCnt(pagingVO);
	}

	@Override
	public List<BoardVO> noticeWidget() {
		return boardMapper.noticeWidget();
	}

	@Override
	public List<BoardVO> lostItems(GalleryPaginationVO<BoardVO> grypagingVO) {	
		return boardMapper.lostItems(grypagingVO);
	}

	@Override
	public ServiceResult insertLostItem(BoardVO boardVO) {
		
		log.debug("boardVO" + boardVO);
		
		ServiceResult res = ServiceResult.FAILED;
		
		int filesCnt = 0;
		int hwCnt = 0;
		
		List<FilesVO> files = boardVO.getFileList();
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
					boardVO.setFileNo(fileNo);
					hwCnt = boardMapper.insertLostItem(boardVO);
				}
			} else {	//업로드 파일이 없을때
				//과제 등록
				hwCnt = boardMapper.insertLostItem(boardVO);
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

	// 대나무숲
	/*
	 * @Override public List<AnonymousBoardVO> anonylist() { return
	 * boardMapper.anonyList(); }
	 */

	@Override
	public AnonymousBoardVO anoyDetail(int anonBrdNo) {
		// 디테일
		AnonymousBoardVO anonyVO = boardMapper.anonyDetail(anonBrdNo);
		
		//조회수 증가
		if (anonyVO != null) {
			boardMapper.anonIncHitCount(anonBrdNo);
		}
		
		return anonyVO ;
	}
	
	@Transactional(rollbackFor = IOException.class)
	@Override
	public void anonyInsert(AnonymousBoardVO anonymousBoardVO) {
		boardMapper.insert(anonymousBoardVO);
	}

	 @Override
	    public ServiceResult deleteAnony(HttpServletRequest req, int anonBrdNo) {
	        ServiceResult result = ServiceResult.FAILED;	
	        int rowcnt = boardMapper.delete(anonBrdNo);
	        if(rowcnt > 0) {
	            result = ServiceResult.OK;
	        }
	        return result;
	    }

	@Override
	public int anonyCount(PaginationVO<AnonymousBoardVO> pagingVO) {
		return boardMapper.anonyCount(pagingVO);
	}

	@Override
	public List<AnonymousBoardVO> anonyList(PaginationVO<AnonymousBoardVO> pagingVO) {
		return boardMapper.anonyList(pagingVO);

	}

	@Override
	public List<AnonymousReplyVO> getAnonComments(int brdNo) {
		return boardMapper.getAnonComments(brdNo);
	}

	@Override
	public int addAnonComment(AnonymousReplyVO replyVO) {
        return boardMapper.addAnonComment(replyVO);
		
	}

	@Override
	public void updateComment(ReplyVO replyVO) {
       boardMapper.updateComment(replyVO);
		
	}

	@Override
	public int deleteComment(int rpNo) {
		 return boardMapper.deleteComment(rpNo);
			
	}

	@Override
	public BoardVO getBoardData(int brdNo) {
		
		BoardVO boardVO = boardMapper.getBoardData(brdNo);
		
		//조회수 증가
		if (boardVO != null) {
			boardMapper.boardCountHit(brdNo);
		}
		
		return boardVO;
	}



	@Override
	public int lostItemListCnt(GalleryPaginationVO<BoardVO> grypagingVO) {
		
		return boardMapper.lostItemListCnt(grypagingVO);
	}

	@Override
	public int createNotice(BoardVO boardVO) {
		return boardMapper.createNotice(boardVO);
	}

	@Override
	public BoardVO selectNotice(int brdNo) {
		return boardMapper.selectNotice(brdNo);
	}

	@Override
	public int deleteNotice(int brdNo) {
		return boardMapper.deleteNotice(brdNo);
	}

	@Override
	public int modifyNotice(BoardVO boardVO) {
		return boardMapper.modifyNotice(boardVO);
	}

}
