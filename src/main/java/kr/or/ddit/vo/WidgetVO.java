package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

// 위젯 정보
@Data
public class WidgetVO {
	private int memNo;
	private int x;
	private int y;
	private int w;
	private int h;
	private String content;
	private String widType;

	public WidgetVO() {}
	
	public WidgetVO(int memNo, int x, int y, int w, int h, String content, String widType) {
		this.memNo = memNo;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.content = content;
		this.widType = widType;
	}
}
