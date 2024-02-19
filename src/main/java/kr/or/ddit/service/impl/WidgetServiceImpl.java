package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.IWidgetMapper;
import kr.or.ddit.service.IWidgetService;
import kr.or.ddit.vo.WidgetVO;

@Service
public class WidgetServiceImpl implements IWidgetService {

	@Inject
	private IWidgetMapper widgetMapper;
	
	/**
	 *  사용자 번호로 위젯 정보를 모두 가져오는 메소드
	 */
	@Override
	public List<WidgetVO> widgetList(int memNo) {
		return widgetMapper.widgetList(memNo);
	}
	/**
	 * 	지정 위젯 정보를 새로 생성하는 메소드
	 */
	@Override
	public ServiceResult createWidget(List<WidgetVO> widget) {
		ServiceResult result = null;
		int status = widgetMapper.createWidget(widget);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	/**
	 * 	위젯 데이터 (포지션, 데이터) 업데이트
	 */
	/*
	 * @Override public int updateWidget(List<WidgetVO> widgetList) {
	 * 
	 * return widgetMapper.updateWidget(widgetList); }
	 */
	/**
	 *  사용자의 위젯 데이터 중 선택한 하나의 위젯 데이터를 가져옴
	 */
	@Override
	public WidgetVO selectWidget(WidgetVO selectWidget) {
		
		if(selectWidget.getWidType().equals("classBoard")) {
			selectWidget.setWidType("WID001");
		} else if(selectWidget.getWidType().equals("todo")) {
			selectWidget.setWidType("WID002");
		} else if(selectWidget.getWidType().equals("academicCal")) {
			selectWidget.setWidType("WID003");
		} else if(selectWidget.getWidType().equals("noticeBoard")) {
			selectWidget.setWidType("WID004");
		} else if(selectWidget.getWidType().equals("memo")) {
			selectWidget.setWidType("WID005");
		}
		
		return widgetMapper.selectWidget(selectWidget);
	}
	/**
	 * 	memNo를 통해 기존 위젯 데이터 모두 삭제
	 */
	@Override
	public ServiceResult deleteWidgetData(int memNo) {
		ServiceResult result = null;
		int status = widgetMapper.deleteWidgetData(memNo);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
}
