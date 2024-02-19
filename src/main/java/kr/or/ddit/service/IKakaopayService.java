package kr.or.ddit.service;

import java.util.Map;

import kr.or.ddit.vo.KakaoApproveResponse;
import kr.or.ddit.vo.KakaoReadyResponse;

public interface IKakaopayService {

	KakaoReadyResponse kakaoPayReady(Map<String, String> certMap);

	KakaoApproveResponse approveResponse(String pgToken);

}
