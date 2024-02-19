package kr.or.ddit.service.impl;

import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import kr.or.ddit.service.IKakaopayService;
import kr.or.ddit.vo.KakaoApproveResponse;
import kr.or.ddit.vo.KakaoReadyResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class KakaopayServiceImpl implements IKakaopayService {
	
	static final String cid = "TC0ONETIME"; // 가맹점 테스트 코드
    static final String admin_Key = "4b7af8c78fb0f9b07f2cdcb8daa81ba9"; // 공개 조심! 본인 애플리케이션의 어드민 키를 넣어주세요
    private KakaoReadyResponse kakaoReady;
    
    @Override
	public KakaoReadyResponse kakaoPayReady(Map<String, String> certMap) {
    	
    	// 카카오페이 요청 양식
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();

		parameters.add("cid", cid);
		parameters.add("partner_order_id", "가맹점 주문 번호");
		parameters.add("partner_user_id", "가맹점 회원 ID");
		parameters.add("item_name", String.valueOf(certMap.get("certificate")));
		parameters.add("quantity", String.valueOf(certMap.get("crfCount")));
		parameters.add("total_amount", String.valueOf(certMap.get("totalAmount")));
		parameters.add("vat_amount", "0");
		parameters.add("tax_free_amount", "0");
		// 성공에 대한 화면 jsp 만들어야함  paymentSuccess.jsp
		parameters.add("approval_url", "http://localhost/DYUniv/payment/success"); // 성공 시 redirect url 
		parameters.add("cancel_url", "http://localhost/DYUniv/payment/cancel"); // 취소 시 redirect url 
		parameters.add("fail_url", "http://localhost/DYUniv/payment/fail"); // 실패 시 redirect url // 파라미터, 헤더

		HttpEntity<MultiValueMap<String, String>> requestEntity = new 
		HttpEntity<MultiValueMap<String, String>>(parameters, this.getHeaders());
		
		 // 외부에 보낼 url
		RestTemplate restTemplate = new RestTemplate();
		kakaoReady = restTemplate.postForObject(
			"https://kapi.kakao.com/v1/payment/ready",
			requestEntity,
			KakaoReadyResponse.class);
		return kakaoReady;
	}
    
    
	@Override
	public KakaoApproveResponse approveResponse(String pgToken) {
		// 카카오 요청
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("cid", cid);
		parameters.add("tid", kakaoReady.getTid());
		parameters.add("partner_order_id", "가맹점 주문 번호");
		parameters.add("partner_user_id", "가맹점 회원 ID");
		parameters.add("pg_token", pgToken);
		 // 파라미터, 헤더
		HttpEntity<MultiValueMap<String, String>> requestEntity = new 
		HttpEntity<MultiValueMap<String, String>>(parameters, this.getHeaders());
		 // 외부에 보낼 url
		RestTemplate restTemplate = new RestTemplate();
		KakaoApproveResponse approveResponse = restTemplate.postForObject(
			 "https://kapi.kakao.com/v1/payment/approve",
			requestEntity,
			KakaoApproveResponse.class);
		 
		return approveResponse;
	}
    
	private HttpHeaders getHeaders() {
		 HttpHeaders httpHeaders = new HttpHeaders();
		 String auth = "KakaoAK " + admin_Key;
		 httpHeaders.set("Authorization", auth);
		httpHeaders.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		 return httpHeaders;
	}

}
