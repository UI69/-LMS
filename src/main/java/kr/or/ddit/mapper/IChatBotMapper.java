package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.ChatBotVO;

public interface IChatBotMapper {
	
	public ChatBotVO selectField(String key);

	public List<String> getKeyword();
	
}
