<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<article class="form">
		<p>스페이스바를 1초이상 길게 누를시 작동 설정</p>
		<button onclick="sendSpeech();">혹은 버튼 클릭시 작동 설정</button>
    	<p class="output">...diagnostic messages</p>
	</article>
</body>

<script>
$(function () {
	
	var STTFlag = false;
	var STTFuncFlag = false;
	
	$(document).keydown(function (e) {
		if(STTFlag){
			return;
		}
		console.log(e.keyCode);
		STTFlag = true;
		
		setTimeout(function() {
			if(STTFlag){
				console.log("trigger on...")
				sendSpeech();
			}
		}, 1000); 
		/* 누르고 1초 후 음성인식 시작 */
	})
	
	$(document).keyup(function (e) {
		if(e.keyCode == 32){ /* keyCode == 32 스페이스바를 누를때 flag 바뀜 */
			STTFlag = false;
		}
	})
	
})





var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
var SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList;
var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent;
var diagnosticPara = document.querySelector('.output');

function sendSpeech() {
  var recognition = new SpeechRecognition();
  var speechRecognitionList = new SpeechGrammarList();
  recognition.grammars = speechRecognitionList;
  recognition.lang = 'ko-KR';
  recognition.interimResults = false; // true: 중간 결과를 반환, false: 최종 결과만 반환
  recognition.continious = false; // true: 음성인식을 계속해서 수행, false: 음성인식을 한번만 수행
  recognition.maxAlternatives = 1;

  recognition.start();

  recognition.onresult = function(event) {
    var speechResult = event.results[0][0].transcript.toLowerCase();
    console.log('Confidence: ' + event.results[0][0].confidence);
    console.log('Speech Result: ' + speechResult);
    diagnosticPara.textContent = 'Speech received: ' + speechResult + '.';
  }

  recognition.onaudiostart = function(event) {
      //Fired when the user agent has started to capture audio.
      //오디오 캡처를 시작하면 실행
      console.log('SpeechRecognition.onaudiostart');
  }

  recognition.onaudioend = function(event) {
      //Fired when the user agent has finished capturing audio.
      //오디오 캡처를 완료하면 실행
      console.log('SpeechRecognition.onaudioend');
  }

  recognition.onend = function(event) {
      //Fired when the speech recognition service has disconnected.
      //음성 인식 서비스의 연결이 끊어지면 실행
      console.log('SpeechRecognition.onend');
  }

  recognition.onnomatch = function(event) {
      //Fired when the speech recognition service returns a final result with no significant recognition. 
      //This may involve some degree of recognition, which doesn't meet or exceed the confidence threshold.
      //음성 인식 서비스가 중요한 인식 없이 최종 결과를 반환하면 실행 
      //여기에는 신뢰도 임계값을 충족하거나 초과하지 않는 어느 정도의 인식이 포함될 수 있습니다.
      //(인식률이 낮아 신뢰도가 낮을수 있는 결과를 반환 했을 때)
      console.log('SpeechRecognition.onnomatch');
  }

  recognition.onsoundstart = function(event) {
      //Fired when any sound — recognisable speech or not — has been detected.
      //소리가 감지되면 실행
      console.log('SpeechRecognition.onsoundstart');
  }

  recognition.onsoundend = function(event) {
      //Fired when any sound — recognisable speech or not — has stopped being detected.
      //소리 감지가 중지되면 실행
      console.log('SpeechRecognition.onsoundend');
  }

  recognition.onspeechstart = function (event) {
      //Fired when sound that is recognised by the speech recognition service as speech has been detected.
      //음성으로 인식된 소리가 감지되면 실행
      console.log('SpeechRecognition.onspeechstart');
  }
  recognition.onstart = function(event) {
      //Fired when the speech recognition service has begun listening to incoming audio with intent to recognize grammars associated with the current SpeechRecognition.
      //SpeechRecognition과 관련된 텍스트로 인식하기 위한 오디오를 듣기 시작하면 실행
      console.log('SpeechRecognition.onstart');
  }
}
</script>
</html>