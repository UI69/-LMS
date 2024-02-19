package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.IFacilityMapper;
import kr.or.ddit.mapper.IUnivManagementMapper;
import kr.or.ddit.service.IUnivManagementService;
import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.CalendarVO;
import kr.or.ddit.vo.FacilityRentVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.UnivScheduleVO;

@Service
public class UnivManagementServiceImpl implements IUnivManagementService {
	
	@Inject
	private IUnivManagementMapper mapper;
	
	@Inject
	private IFacilityMapper facilityMapper;
	
	// 학사일정 리스트(동기)
	@Override
	public List<UnivScheduleVO> univScheduleList(PaginationVO<UnivScheduleVO> pagingVO) {		
		return mapper.univScheduleList(pagingVO);
	}
	
	// 학사일정 리스트(캘린더)
	@Override
	public List<UnivScheduleVO> univSchedule() {		
		return mapper.univSchedule();
	}
	
	// 학사일정 리스트 count
	@Override
	public int univSchCnt(PaginationVO<UnivScheduleVO> pagingVO) {
		return mapper.univSchCnt(pagingVO);
	}
	
	// 학사일정 등록
	@Override
	public ServiceResult addSchedule(UnivScheduleVO scheduleVO) {
		ServiceResult result = null;
		
		int status = mapper.addSchedule(scheduleVO);
		if(status > 0)
		{
			result = ServiceResult.OK;
		}else
		{
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
	// 학사일정 리스트(비동기)
	@Override
	public List<UnivScheduleVO> univScheduleWidget() {
		return mapper.univScheduleWidget();
	}
	
	// 학사일정 수정(비동기)
	@Override
	public int updateSchedule(UnivScheduleVO univScheduleVO) {
		return mapper.updateSchedule(univScheduleVO);
	}
	// 학사일정 수정(동기)
	@Override
	public int updateSchedule1(UnivScheduleVO scheduleVO) {
		return mapper.updateSchedule1(scheduleVO);
	}
	// 학사일정 삭제(동기)
	@Override
	public int deleteSchedule(UnivScheduleVO univScheduleVO) {
		return mapper.deleteSchedule(univScheduleVO);
	}
	
	// 시설 예약 리스트
	@Override
	public List<FacilityRentVO> facilityRentList(PaginationVO<FacilityRentVO> pagingVO) {
		return mapper.facilityRentList(pagingVO);
	}
	
	// 건물 리스트
	@Override
	public List<BuildingVO> buildingList() {
		return mapper.buildingList();
	}
	
	// 건물 선택
	@Override
	public BuildingVO buildingSelect(BuildingVO buildingVO) {
		System.out.println("buildingVO =>" + buildingVO);
		return mapper.buildingSelect(buildingVO);
	}
	
	// 시설 선택
	@Override
	public FacilityVO facilitySelect(FacilityVO facilityVO) {
		return mapper.facilitySelect(facilityVO);
	}
	
	// 시설 예약
	@Override
	public ServiceResult facReservation(FacilityRentVO facilityRentVO) {
		ServiceResult result = null;
		
		int status = mapper.facReservation(facilityRentVO);
		if(status > 0)
		{
			result = ServiceResult.OK;
		}else
		{
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
	// 건물 데이터 가져오기
	@Override
	public List<BuildingVO> getBuildingData() {
		return facilityMapper.getBuildingData();
	}

	// 시설 전체 예약 가져오기
	@Override
	public List<FacilityRentVO> getfacilityResvData(PaginationVO<FacilityRentVO> pagingVO) {
		return facilityMapper.getfacilityResvData(pagingVO);
	}

	// 시설 전체 예약 가져오기의 count
	@Override
	public int facilityResvCnt(PaginationVO<FacilityRentVO> pagingVO) {
		return facilityMapper.facilityResvCnt(pagingVO);
	}

	// 시설 예약 상태 수정
	@Override
	public int updateFacilityResvStatus(FacilityRentVO facilityRentVO) {
		return facilityMapper.updateFacilityResvStatus(facilityRentVO);
	}
	
	// 시설 예역 현황(캘린더)
	@Override
	public List<FacilityRentVO> facilityRentCal(int facNo) {		
		return facilityMapper.facilityRentCal(facNo);
	}
	
	
	
}
