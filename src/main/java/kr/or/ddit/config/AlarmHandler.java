package kr.or.ddit.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AlarmHandler extends TextWebSocketHandler {

	// 소켓에 연결된 전체 세션, 모든 세션에 메시지를 전송하기 위함
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// 데이터 관련된 서비스 연결
//	@Inject
//	private IChatService chatService;

	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		log.info("/alarm websocket open...");
		
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("msg payload : " + message.getPayload());

//		ObjectMapper mapper = new ObjectMapper();
//		ChatLogVO chatLog = mapper.readValue(message.getPayload(), ChatLogVO.class);
//		
//		int cnt = chatService.chat(chatLog);
//
//		if (cnt > 0) {
//			//해당 방에 전체 채팅 s
//			for(WebSocketSession sess: sessionList) {
//				int roomNo = (int) sess.getAttributes().get("roomNo");
//				if(chatLog.getRoomNo().equals(String.valueOf(roomNo))) {
//					sess.sendMessage(new TextMessage(new Gson().toJson(chatLog))); 
//				}
//			}
//		} else { // DB 저장 실패
//			log.info("chat msg insert failed...");
//		}

	}

	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("websocket close...");
		log.info("session : " + session.getAttributes());
		sessionList.remove(session);
	}

}
