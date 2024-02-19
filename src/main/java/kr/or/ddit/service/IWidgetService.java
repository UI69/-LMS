package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.WidgetVO;

public interface IWidgetService {

	public List<WidgetVO> widgetList(int memNo);

	public ServiceResult createWidget(List<WidgetVO> widget);

	// public int updateWidget(List<WidgetVO> widgetList);

	public WidgetVO selectWidget(WidgetVO selectWidget);

	public ServiceResult deleteWidgetData(int memNo);

}
