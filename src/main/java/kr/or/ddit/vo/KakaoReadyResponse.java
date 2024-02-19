package kr.or.ddit.vo;

import org.springframework.http.HttpEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import kr.or.ddit.service.IKakaopayService;
import lombok.Data;

@Data
public class KakaoReadyResponse {
	private String tid; // 결제 고유 번호
	private String next_redirect_mobile_url; // 모바일 웹일 경우 받는 결제페이지 url private String next_redirect_pc_url; // pc 웹일 경우 받는 결제 페이지
	private String next_redirect_pc_url;	 // pc 웹일 경우 받는 결제 페이지
	private String created_at;
}
