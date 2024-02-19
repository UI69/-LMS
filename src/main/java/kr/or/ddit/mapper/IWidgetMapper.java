package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.WidgetVO;

public interface IWidgetMapper {
	
	// public int updateWidget(List<WidgetVO> widgetList);

	public List<WidgetVO> widgetList(int memNo);

	public int createWidget(List<WidgetVO> widget);

	public WidgetVO selectWidget(WidgetVO selectWidget);

	public int deleteWidgetData(int memNo);

}
