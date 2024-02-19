package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.CommunityChatRecordVO;
import kr.or.ddit.vo.CommunityMemberVO;
import kr.or.ddit.vo.CommunityVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MyClassVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ScheduleDataVO;

public interface ICommunityService {

	public List<CommunityVO> list();
	
	public List<CommunityVO> list(PaginationVO<CommunityVO> pagingVO);

	public int communityAllCount(PaginationVO<CommunityVO> pagingVO);
	
	public List<CommunityVO> myCommunityList(Map<String, Object> paramMap);

	public int myCommunityListCount(PaginationVO<CommunityVO> pagingVO);
	
	public int insert(CommunityVO communityVO);

	public CommunityVO communDetail(int cmNo);

	public int commuUpdate(CommunityVO communityVO);

	public int communStatus(CommunityVO communityVO);

	public ServiceResult applyForCoummnity(CommunityMemberVO cmMemberVO);

	public List<CommunityVO> myCmApplyList(PaginationVO<CommunityVO> pagingVO);

	public List<CommunityVO> myCmList(int memNo);

	public ServiceResult removeApplyCommunity(CommunityMemberVO cmMemberVO);

	public CommunityVO getCmDetail(int cmNo);

	public List<CommunityChatRecordVO> getCmChatList(int cmNo);

	public ServiceResult addRecord(CommunityChatRecordVO chatLog);

	public List<MyClassVO> scheduleList(MyClassVO myClassVO);

	public List<MyClassVO> classSchShare(MyClassVO myClassVO);

	public List<ScheduleDataVO> scheduleShare(ScheduleDataVO scheduleDataVO);

	public ServiceResult addCommunitySch(ScheduleDataVO scheduleDataVO);

	public List<CommunityMemberVO> myRegCmList(int memNo);

	public int myCmApplyListCnt(PaginationVO<CommunityVO> pagingVO);






	
	
	
	

}
