package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.ICounselMapper;
import kr.or.ddit.service.ICounselService;
import kr.or.ddit.vo.ChatRecordVO;
import kr.or.ddit.vo.CounselVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ScheduleDataVO;

@Service
public class CounselServiceImpl implements ICounselService {

	@Inject
	ICounselMapper counselMapper;
	
	@Override
	public List<CounselVO> getCounselList(int studentMemNo) {
		return counselMapper.getCounselList(studentMemNo);
	}

	@Override
	public ServiceResult addRecord(ChatRecordVO chatRecordVO) {
		ServiceResult res = null;
		int cnt = counselMapper.addRecord(chatRecordVO);
		if(cnt == 1) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		return res;
	}

	@Override
	public List<ChatRecordVO> getRecordList(int chatRoomNo) {
		return counselMapper.getRecordList(chatRoomNo);
	}

	@Override
	public List<MemberVO> getCounselor(PaginationVO<MemberVO> pagingVO) {
		return counselMapper.getCounselor(pagingVO);
	}

	@Override
	public List<ScheduleDataVO> counselSchDataList(int memNo) {
		return counselMapper.counselSchDataList(memNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public ServiceResult addReserveCousel(CounselVO counselVO, ScheduleDataVO dataVO) {
		
		int addcnt = 0;
		int modcnt = 0;
		
		//상담 신청
		try {
			addcnt = counselMapper.addReserveCousel(counselVO);
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceResult.FAILED;
		}
		
		if(addcnt == 0) {
			return ServiceResult.FAILED;
		}
		
		try {
			modcnt = counselMapper.updateSchedule(dataVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(modcnt == 1) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public List<CounselVO> getProCounselList(int proMemNo) {
		return counselMapper.getProCounselList(proMemNo);
	}

	@Override
	public CounselVO getCounselInfo(int cnslNo) {
		return counselMapper.getCounselInfo(cnslNo);
	}

	@Override
	public int updateCnslDetail(CounselVO counselVO) {
		return counselMapper.updateCnslDetail(counselVO);
	}

	@Override
	public int getCounselorCnt(PaginationVO<MemberVO> pagingVO) {
		return counselMapper.getCounselorCnt(pagingVO);
	}

	@Override
	public String getMemName(int memNo) {
		return counselMapper.getMemName(memNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public ServiceResult addCounselSchedule(ScheduleDataVO scheduleDataVO) {
		
		/* int counselCnt = 0; */
		int counselScheduleCnt = 0;
		
		// 일정 생성
		try {
			counselScheduleCnt = counselMapper.addCounselSchedule(scheduleDataVO);
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceResult.FAILED;
		}
		
		if (counselScheduleCnt == 0) {
			return ServiceResult.FAILED;
		}
		
		return ServiceResult.OK;
		
		
		// 상담 생성
		/*
		 * try { counselCnt = counselMapper.addCounsel(scheduleDataVO); } catch
		 * (Exception e) { e.printStackTrace(); return ServiceResult.FAILED; }
		 * 
		 * if(counselCnt == 0) { return ServiceResult.FAILED; }
		 * 
		 * if(counselCnt == 1) { return ServiceResult.OK; } else { return
		 * ServiceResult.FAILED; }
		 */
	}

	@Override
	public int deleteCounselSchedule(int schDataNo) {
		return counselMapper.deleteCounselSchedule(schDataNo);
	}



}
