package kr.or.ddit.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IChatBotMapper;
import kr.or.ddit.service.IChatBotService;
import kr.or.ddit.vo.ChatBotVO;

@Service
public class ChatBotServiceImpl implements IChatBotService {

	@Inject
	private IChatBotMapper chatBotMapper;
	
	@Override
	public List<ChatBotVO> selectField(String key) {
		List<String> keywordList = settingMoveUrl(key);
		
		List<ChatBotVO> chatResList = new ArrayList<ChatBotVO>();
		
		for(String keyword : keywordList) {
			ChatBotVO botVO = chatBotMapper.selectField(keyword);
			chatResList.add(botVO);
		}
		
		return chatResList;
	}
	
	private List<String> settingMoveUrl(String key) {
		
		List<String> searchKeyword = chatBotMapper.getKeyword();
		
		List<String> keywordList = new ArrayList<String>();

		for(String keyword : searchKeyword) {
			if(key.contains(keyword)) {
				keywordList.add(keyword);
			}
		}

		return keywordList;
	}
	

}
