package kr.or.ddit.config;

import java.util.ArrayList;
import java.util.Date;
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

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.ICounselService;
import kr.or.ddit.vo.ChatRecordVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CounselHandler extends TextWebSocketHandler {

	// 소켓에 연결된 전체 세션, 모든 세션에 메시지를 전송하기 위함
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// 데이터 관련된 서비스 연결
	@Inject
	private ICounselService counselService;

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		log.info("/chat websocket open...");
		log.info("session : " + session.getAttributes());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("msg payload : " + message.getPayload());

		
		ObjectMapper mapper = new ObjectMapper();
		ChatRecordVO chatRecordVO = mapper.readValue(message.getPayload(), ChatRecordVO.class);
		int chatRoomNo = (int) session.getAttributes().get("chatRoomNo");
		MemberVO memberVO = (MemberVO) session.getAttributes().get("member");
		
		chatRecordVO.setChatRoomNo(chatRoomNo);
		chatRecordVO.setMemNo(memberVO.getMemNo());
		chatRecordVO.setChatSender(memberVO.getMemName());
		
		String resStr = chatRecordVO.getResString();
		
		if(resStr != null && (resStr.equals("open") || resStr.equals("close"))) {
			//해당 방에 채팅 
			for(WebSocketSession sess: sessionList) {	// 모든 세션 루프
				int roomNo = (int) sess.getAttributes().get("chatRoomNo");
				if(chatRecordVO.getChatRoomNo() == roomNo) {		// 같은 방인지 체크
					sess.sendMessage(new TextMessage(new Gson().toJson(chatRecordVO))); 
				}
			}
		} else {
			ServiceResult res = counselService.addRecord(chatRecordVO);
			
			if (res.equals(ServiceResult.OK)) {
				//해당 방에 채팅 
				for(WebSocketSession sess: sessionList) {	// 모든 세션 루프
					int roomNo = (int) sess.getAttributes().get("chatRoomNo");
					if(chatRecordVO.getChatRoomNo() == roomNo) {		// 같은 방인지 체크
						sess.sendMessage(new TextMessage(new Gson().toJson(chatRecordVO))); 
					}
				}
			} else { // DB 저장 실패
				log.info("chat msg insert failed...");
				chatRecordVO.setResString(res.toString());
				session.sendMessage(new TextMessage(new Gson().toJson(chatRecordVO)));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("websocket close...");
		log.info("session : " + session.getAttributes());
		sessionList.remove(session);
	}
	
	

}
