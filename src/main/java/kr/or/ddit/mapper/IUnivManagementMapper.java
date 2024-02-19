package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.CalendarVO;
import kr.or.ddit.vo.FacilityRentVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.UnivScheduleVO;

public interface IUnivManagementMapper {

	public List<UnivScheduleVO> univScheduleList(PaginationVO<UnivScheduleVO> pagingVO);	// 학사일정 리스트
	public List<UnivScheduleVO> univSchedule();						// 학사일정 리스트(캘린더)
	public int univSchCnt(PaginationVO<UnivScheduleVO> pagingVO);	// 학사일정 리스트 count
	public int addSchedule(UnivScheduleVO scheduleVO);				// 학사일정 추가
	public List<UnivScheduleVO> univScheduleWidget();
	public int updateSchedule(UnivScheduleVO univScheduleVO);		// 학사일정 수정
	public int updateSchedule1(UnivScheduleVO scheduleVO);			// 학사일정 수정
	public int deleteSchedule(UnivScheduleVO univScheduleVO);		// 학사일정 삭제
	public List<FacilityRentVO> facilityRentList(PaginationVO<FacilityRentVO> pagingVO);	// 시설 예약 리스트
	public List<BuildingVO> buildingList();							// 건물 리스트
	public BuildingVO buildingSelect(BuildingVO buildingVO);		// 건물 선택
	public FacilityVO facilitySelect(FacilityVO facilityVO);		// 시설 선택
	public int facReservation(FacilityRentVO facilityRentVO);		// 시설 예약
//	public List<FacilityRentVO> facilityRentCal(int facNo);			// 시설 예약 리스트(캘린더)
	
}