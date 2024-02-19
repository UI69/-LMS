package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.ChatRecordVO;
import kr.or.ddit.vo.CounselVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ScheduleDataVO;

public interface ICounselService {

	List<CounselVO> getCounselList(int studentMemNo);

	ServiceResult addRecord(ChatRecordVO chatRecordVO);

	List<ChatRecordVO> getRecordList(int chatRoomNo);

	List<MemberVO> getCounselor(PaginationVO<MemberVO> pagingVO);

	List<ScheduleDataVO> counselSchDataList(int memNo);

	ServiceResult addReserveCousel(CounselVO counselVO, ScheduleDataVO dataVO);

	List<CounselVO> getProCounselList(int proMemNo);

	CounselVO getCounselInfo(int cnslNo);

	int updateCnslDetail(CounselVO counselVO);

	int getCounselorCnt(PaginationVO<MemberVO> pagingVO);

	String getMemName(int memNo);

	ServiceResult addCounselSchedule(ScheduleDataVO scheduleDataVO);

	int deleteCounselSchedule(int schDataNo);

}
