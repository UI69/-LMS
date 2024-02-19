package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.ICommunityMapper;
import kr.or.ddit.service.ICommunityService;
import kr.or.ddit.vo.CommunityChatRecordVO;
import kr.or.ddit.vo.CommunityMemberVO;
import kr.or.ddit.vo.CommunityVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MyClassVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ScheduleDataVO;


@Service
@Transactional(rollbackFor = Exception.class)
public class CommunityServiceImpl implements ICommunityService {

	@Inject
	private ICommunityMapper communityMapper;
	
	@Override
	public List<CommunityVO> list() {
		return communityMapper.list();
	}

	@Override
	public int insert(CommunityVO communityVO) {
		int cnt = communityMapper.insert(communityVO);
		
		if(cnt > 0) {
			CommunityMemberVO cmMemberVO = new CommunityMemberVO();
			
			cmMemberVO.setCmNo(communityVO.getCmNo());
			cmMemberVO.setMemNo(communityVO.getMemNo());
			
			communityMapper.applyForCoummnity(cmMemberVO);
		}
		
		return cnt;
	}

//	@Override
//	public List<CommunityVO> myCommunityList(int memNo) {
//		return communityMapper.myCommunityList(memNo );
//	}

	@Override
	public List<CommunityVO> myCommunityList(Map<String, Object> paramMap) {
		return communityMapper.myCommunityList(paramMap);
	}
	
	
	@Override
	public CommunityVO communDetail(int cmNo) {
		
		return communityMapper.communDetail(cmNo);
	}

	@Override
	public int commuUpdate(CommunityVO communityVO) {
		return communityMapper.commuUpdate(communityVO);
	}

	@Override
	public int communStatus(CommunityVO communityVO) {
		return communityMapper.communStatus(communityVO);
	}

	@Override
	public List<CommunityVO> list(PaginationVO<CommunityVO> pagingVO) {
		return communityMapper.list(pagingVO);
	}

	@Override
	public int communityAllCount(PaginationVO<CommunityVO> pagingVO) {
		
		return communityMapper.communityAllCount(pagingVO);
	}

	@Override
	public int myCommunityListCount(PaginationVO<CommunityVO> pagingVO) {
		
		return communityMapper.myCommunityListCount(pagingVO);
	}

	@Override
	public ServiceResult applyForCoummnity(CommunityMemberVO cmMemberVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		int duplCnt = communityMapper.duplCmMember(cmMemberVO);
		
		if(duplCnt > 0) {
			return ServiceResult.EXIST;
		}
		
		int cnt = communityMapper.applyForCoummnity(cmMemberVO);
		
		if(cnt == 1) {
			res = ServiceResult.OK;
		}
		
		return res;
	}

	@Override
	public List<CommunityVO> myCmApplyList(PaginationVO<CommunityVO> pagingVO) {
		return communityMapper.myCmApplyList(pagingVO);
	}

	@Override
	public List<CommunityVO> myCmList(int memNo) {
		return communityMapper.myCmList(memNo);
	}

	@Override
	public ServiceResult removeApplyCommunity(CommunityMemberVO cmMemberVO) {
		ServiceResult res = ServiceResult.FAILED;

		int cnt = communityMapper.removeApplyCommunity(cmMemberVO);
		
		if(cnt == 1) {
			res = ServiceResult.OK;
		}
		
		return res;
	}

	@Override
	public CommunityVO getCmDetail(int cmNo) {
		return communityMapper.getCmDetail(cmNo);
	}

	@Override
	public List<CommunityChatRecordVO> getCmChatList(int cmNo) {
		return communityMapper.getCmChatList(cmNo);
	}

	@Override
	public ServiceResult addRecord(CommunityChatRecordVO chatLog) {
		ServiceResult res = ServiceResult.FAILED;

		int cnt = communityMapper.addRecord(chatLog);
		
		if(cnt == 1) {
			res = ServiceResult.OK;
		}
		
		return res;
	}

	
	@Override
	public List<MyClassVO> scheduleList(MyClassVO myClassVO) {
		
		return communityMapper.scheduleList(myClassVO);
	}

	@Override
	public List<MyClassVO> classSchShare(MyClassVO myClassVO) {
		
		// 일정 스케줄 List
		//List<MyClassVO> classSchShare = communityMapper.classSchShare(myClassVO);
		//ScheduleDataVO scheduleDataVO = new ScheduleDataVO();
		//scheduleDataVO.setMemNo(myClassVO.getMemNo());
		
		return communityMapper.classSchShare(myClassVO);
	}

	@Override
	public List<ScheduleDataVO> scheduleShare(ScheduleDataVO scheduleDataVO) {		
		return communityMapper.scheduleShare(scheduleDataVO);
	}

	@Override
	public ServiceResult addCommunitySch(ScheduleDataVO scheduleDataVO) {	
		ServiceResult res = ServiceResult.FAILED;
		
		try {
			int cnt = 0;
			List<Integer> memList = scheduleDataVO.getMemNoList();
			
			for(int memNo : memList) {
				scheduleDataVO.setMemNo(memNo);
				cnt += communityMapper.addCommunitySch(scheduleDataVO);
			}
			
			if(cnt == memList.size()) {
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
	public List<CommunityMemberVO> myRegCmList(int memNo) {
		return communityMapper.myRegCmList(memNo);
	}

	@Override
	public int myCmApplyListCnt(PaginationVO<CommunityVO> pagingVO) {
		return communityMapper.myCmApplyListCnt(pagingVO);
	}

	





}
