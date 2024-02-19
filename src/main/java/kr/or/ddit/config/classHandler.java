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

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.ILectureService;
import kr.or.ddit.vo.ClassListenVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.ReserveClassVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class classHandler extends TextWebSocketHandler {

	// 소켓에 연결된 전체 세션, 모든 세션에 메시지를 전송하기 위함
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// 데이터 관련된 서비스 연결
	@Inject
	private ILectureService lectureService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		log.info("/class websocket open...");
		
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("msg payload : " + message.getPayload());

		// 신청 데이터 변환
		ObjectMapper mapper = new ObjectMapper();
		ReserveClassVO reserveClassVO = mapper.readValue(message.getPayload(), ReserveClassVO.class);

		MemberVO memberVO = (MemberVO) session.getAttributes().get("member");
		reserveClassVO.setMemNo(memberVO.getMemNo());
		
		// 수강목록 중복 확인
		ServiceResult check = lectureService.classDuplCheck(reserveClassVO);
		
		// 중복이면 해당 인원에게만 중복 메시지 전송
		if(check.equals(ServiceResult.FAILED)) {
			reserveClassVO.setApplyType("duplicate");
			session.sendMessage(new TextMessage(new Gson().toJson(reserveClassVO)));
			return;
		}
		
		// 수강 인원 확인
		ClassListenVO classListenVO = lectureService.classMemCntCheck(reserveClassVO);
		classListenVO.setMemNo(memberVO.getMemNo());
		
		if(classListenVO.getEnabledApply()) {
			//수강 신청
			reserveClassVO.setResStatusCode("RES002");
			reserveClassVO.setClassMaxMem(classListenVO.getClassMaxMem());
			int cnt = lectureService.addListenClass(reserveClassVO);
			
			// 수강정보 전송
			if (cnt > 0) {
				log.info("class listen insert success...");
				// 수강정보 업데이트
				classListenVO.applySuccessMem();
				//업데이트 정보 전송
				for(WebSocketSession sess: sessionList) {
					sess.sendMessage(new TextMessage(new Gson().toJson(classListenVO)));
				}
			} else { // DB 저장 실패
				log.info("class listen insert failed...");
				// 해당 인원에게 실패 메시지 전송
				reserveClassVO.setApplyType("failed");
				session.sendMessage(new TextMessage(new Gson().toJson(reserveClassVO)));
				return;
			}
		} else {
			// 해당 인원에게 초과 메시지 전송
			reserveClassVO.setApplyType("over");
			session.sendMessage(new TextMessage(new Gson().toJson(reserveClassVO)));
			return;
		}
	}

	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("websocket close...");
		log.info("session : " + session.getAttributes());
		sessionList.remove(session);
	}

}
