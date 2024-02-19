package kr.or.ddit.config;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import kr.or.ddit.service.ICommunityService;
import kr.or.ddit.vo.CommunityChatRecordVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CommunityHandler extends TextWebSocketHandler {

	// 소켓에 연결된 전체 세션, 모든 세션에 메시지를 전송하기 위함
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// 데이터 관련된 서비스 연결
	@Inject
	private ICommunityService communityService;

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		log.info("/community websocket open...");
		log.info("session : " + session.getAttributes());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("msg payload : " + message.getPayload());

		ObjectMapper mapper = new ObjectMapper();
		CommunityChatRecordVO chatLog = mapper.readValue(message.getPayload(), CommunityChatRecordVO.class);

		log.info("cm chat : " + chatLog.toString());
		int cmNo = (int) session.getAttributes().get("cmNo");
		MemberVO memberVO = (MemberVO) session.getAttributes().get("member");
		chatLog.setCmNo(cmNo);
		chatLog.setMemNo(memberVO.getMemNo());
		chatLog.setChatSender(memberVO.getMemName());
		
		ServiceResult res = communityService.addRecord(chatLog);
		
		if (res.equals(ServiceResult.OK)) {
			//해당 방에 채팅 
			for(WebSocketSession sess: sessionList) {	// 모든 세션 루프
				int roomNo = (int) sess.getAttributes().get("cmNo");
				if(chatLog.getCmNo() == roomNo) {		// 같은 방인지 체크
					sess.sendMessage(new TextMessage(new Gson().toJson(chatLog))); 
				}
			}
		} else { // DB 저장 실패
			log.info("chat msg insert failed...");
			chatLog.setResString(res.toString());
			session.sendMessage(new TextMessage(new Gson().toJson(chatLog)));
		}

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("websocket close...");
		log.info("session : " + session.getAttributes());
		sessionList.remove(session);
		session.getAttributes().remove("cmNo");
		log.info("session attr remove after : " + session.getAttributes());
	}

}
