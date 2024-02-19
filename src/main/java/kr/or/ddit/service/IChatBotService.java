package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.ChatBotVO;

public interface IChatBotService {

	public List<ChatBotVO> selectField(String key);

}
