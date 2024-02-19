package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.ChatRecordVO;
import kr.or.ddit.vo.CounselVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ScheduleDataVO;

public interface ICounselMapper {

	List<CounselVO> getCounselList(int studentMemNo);

	int addRecord(ChatRecordVO chatRecordVO);

	List<ChatRecordVO> getRecordList(int chatRoomNo);


	List<ScheduleDataVO> counselSchDataList(int memNo);

	int addReserveCousel(CounselVO counselVO);

	int updateSchedule(ScheduleDataVO dataVO);

	List<CounselVO> getProCounselList(int proMemNo);

	CounselVO getCounselInfo(int cnslNo);

	int updateCnslDetail(CounselVO counselVO);
	
	List<MemberVO> getCounselor(@Param("pagingVO") PaginationVO<MemberVO> pagingVO);

	int getCounselorCnt(@Param("pagingVO") PaginationVO<MemberVO> pagingVO);

	String getMemName(int memNo);

	int addCounselSchedule(ScheduleDataVO scheduleDataVO);

	int deleteCounselSchedule(int schDataNo);

	/* int addCounsel(ScheduleDataVO scheduleDataVO); */

}
