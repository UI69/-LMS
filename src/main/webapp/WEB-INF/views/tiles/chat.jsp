<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<div id="chat-box-body">
  <div
    id="chat-circle"
    class="waves-effect waves-circle btn btn-circle btn-lg btn-warning l-h-70"
  >
    <div id="chat-overlay"></div>
    <span class="icon-Group-chat fs-30"
      ><span class="path1"></span><span class="path2"></span
    ></span>
  </div>

  <div class="chat-box">
    <div
      class="chat-box-header p-15 d-flex justify-content-between align-items-center"
    >
      <div class="flex-grow-1">
        <div class="text-dark fs-18">
          <strong>DDiTi</strong>
        </div>
        <div>
          <span class="badge badge-sm badge-dot badge-primary"></span>
          <span class="text-muted fs-12">음성인식 비서</span>
        </div>
      </div>
      <div class="chat-box-toggle">
        <a
          id="chat-box-toggle"
          class="waves-effect waves-circle btn btn-circle btn-danger-light h-40 w-40 rounded-circle l-h-45"
        >
          <span class="icon-Close fs-22"
            ><span class="path1"></span><span class="path2"></span
          ></span>
        </a>
      </div>
    </div>
    <div class="chat-box-body">
      <div class="chat-box-overlay"></div>
      <div class="chat-logs">
      
      	<div class="chat-msg user">
          <div class="d-flex align-items-center">
            <span class="msg-avatar">
              <img
                src="${pageContext.request.contextPath}/resources/images/avatar/2.jpg"
                class="avatar avatar-lg"
              />
            </span>
            <div class="mx-10">
              <a href="#" class="text-dark hover-primary fw-bold">chatbot DDiTi</a>
              <p class="text-muted fs-12 mb-0"></p>
            </div>
          </div>
          <div class="cm-msg-text">텍스트나 음성을 입력해주세요.</div>
        </div>
      
        <!-- 비서말풍선 시작 -->
        <%--
        <div class="chat-msg user">
          <div class="d-flex align-items-center">
            <span class="msg-avatar">
              <img
                src="${pageContext.request.contextPath}/resources/images/avatar/2.jpg"
                class="avatar avatar-lg"
              />
            </span>
            <div class="mx-10">
              <a href="#" class="text-dark hover-primary fw-bold"
                >Mayra Sibley</a
              >
              <p class="text-muted fs-12 mb-0">2 Hours</p>
            </div>
          </div>
          <div class="cm-msg-text">Hi there, I'm Jesse and you?</div>
        </div>
        --%>
        <!-- 비서말풍선 끝 -->
        <!-- 내 말풍선 시작 -->
        <%--
        <div class="chat-msg self">
          <div class="d-flex align-items-center justify-content-end">
            <div class="mx-10">
              <a href="#" class="text-dark hover-primary fw-bold">You</a>
              <p class="text-muted fs-12 mb-0">3 minutes</p>
            </div>
            <span class="msg-avatar">
              <img
                src="${pageContext.request.contextPath}/resources/images/avatar/3.jpg"
                class="avatar avatar-lg"
              />
            </span>
          </div>
          <div class="cm-msg-text">Nice to meet you too, Jesse. I'm John.</div>
        </div>
        --%>
        <!-- 내 말풍선 끝 -->
      </div>
      <!--chat-log -->
    </div>
    <div class="chat-input row">
      <!-- UI 전송 -->
      <div class="col-9">
	      <input type="text" id="chat-input" placeholder="마이크 버튼을 누르면 음성인식이 작동합니다."
	        value="" style="overflow: auto;" />      
      </div>
      <div class="col text-center pt-10">
	      <button type="button" id="chat-submit" class="btn btn-circle btn-primary btn-xs" style="" > 
	      	<i class="mdi mdi-send"></i>
	      </button>
	      <button onclick="sendSpeech();" type="button" class="btn btn-circle btn-primary btn-xs">
	      	<i class="mdi mdi-microphone"></i>
	      </button>      
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
	var INDEX = 0;
	
  var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
  var SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList;
  var SpeechRecognitionEvent =
    SpeechRecognitionEvent || webkitSpeechRecognitionEvent;
  // var diagnosticPara = document.querySelector(".output");

  /* speechResult <= 음성인식의 결과가 저장될 변수 */
  var speechResult;

  /* 챗봇 말(결과) */
  var chatbotText = [];

  function f_ajax(dataParam) {
	    console.log("dataParam", dataParam);

	    $.ajax({
	      type: "post",
	      url: "/DYUniv/chatBot/selectField",
	      data: JSON.stringify({
	        key: dataParam,
	      }),
	      contentType: "application/json; charset=UTF-8",
	      dataType: "text", // 서버에서 돌려주는 문자열에 {},[]
	      success: function (res) {
	    	console.log("res", res);
	        result = JSON.parse(res)
	        console.log("비동기 result", result);
	        chatbotText = [];
	        
	        if (result != null && result.length > 0) {
	        	
	        	if(result.length != 1){
	        		chatbotText.push("여러개의 검색 결과가 있어요.<br><br>");
	        	}
	        	
	        	$.each(result, function (i,v) {
	        		var str = "";
	        		if(i!=0){
	        			str += "<br>";
	        		}
					str += '<a href="/DYUniv/' + v.res + '">' +
		              v.answer + "(으)로 이동하기</a>";
		        	chatbotText.push(str);
				})
				console.log("chatbotText : ", chatbotText);
	          	generate_button_message(chatbotText, 'user'); 
	        } else {
	          console.log("error!! 비동기 실패");
	          chatbotText = [
	        	  "검색 결과가 없습니다."
	          ];
	          generate_button_message(chatbotText, 'user');
	        }
	      },
	      error: function (xhr, status, error) {
	        console.error("AJAX request failed:", status, error);
	      },
	    });
	  }
	  
	  $(function() {
		  $("#chat-submit").click(function(e) {
		    e.preventDefault();
		    var msg = $("#chat-input").val(); 
		    if(msg.trim() == ''){
		      return false;
		    }
		    
		    console.log("msg : " + msg);
		    
		    generate_message(msg, 'self');
		    var buttons = [
		        {
		          name: 'Existing User',
		          value: 'existing'
		        },
		        {
		          name: 'New User',
		          value: 'new'
		        }
		      ];
		    
		    /* 음성인식의 결과 생성 후 비동기 실행 */
		    f_ajax(msg);
		  })
		  
		  $(document).delegate(".chat-btn", "click", function() {
		    var value = $(this).attr("chat-value");
		    var name = $(this).html();
		    $("#chat-input").attr("disabled", false);
		    generate_message(name, 'self');
		  })

		});
	  
		function generate_message(msg, type) {
			INDEX++;
			var str="";
			str += "<div id='cm-msg-"+INDEX+"' class=\"chat-msg "+type+"\">";
			str += "          <div class=\"d-flex align-items-center justify-content-end\">";  
			str += "          <div class=\"mx-10\">"; 
			str += "          <a href=\"#\" class=\"text-dark hover-primary font-weight-bold\">You";
			str += "          <\/a>";
			/*str += "          <p class=\"text-muted font-size-12 mb-0\">Just now";
			str += "          <\/p>";*/
			str += "          <\/div>";
			str += "          <span class=\"msg-avatar\">";
			str += "            <img src=\"/resources/images/avatar/3.jpg\"  class=\"avatar avatar-lg\">";
			str += "          <\/span>"; 
			str += "          <\/div>"; 
			str += "          <div class=\"cm-msg-text\">";
			str += msg;
			str += "          <\/div>";
			str += "        <\/div>";
			$(".chat-logs").append(str);
			$("#cm-msg-"+INDEX).hide().fadeIn(300);
			if(type == 'self'){
			 $("#chat-input").val(''); 
			}    
			$(".chat-logs").stop().animate({ scrollTop: $(".chat-logs")[0].scrollHeight}, 1000);    
		}  
	 
		function generate_button_message(chatbotText, type){    
		  
		   INDEX++;
		   var str="";
			str += "<div id='cm-msg-"+INDEX+"' class=\"chat-msg user\">";    
			str += "          <div class=\"d-flex align-items-center\">";  
			str += "          <span class=\"msg-avatar\">";
			str += "            <img src=\"/resources/images/avatar/2.jpg\"  class=\"avatar avatar-lg\">";
			str += "          <\/span>";
			str += "          <div class=\"mx-10\">"; 
			str += "          <a href=\"#\" class=\"text-dark hover-primary font-weight-bold\">chatbot DDiTi";
			str += "          <\/a>";
			str += "          <\/div>"; 
			str += "          <\/div>"; 
			str += "          <div class=\"cm-msg-text\">";
			str += chatbotText;
			str += "          <\/div>";
			str += "        <\/div>";
			
			$(".chat-logs").append(str);
			$("#cm-msg-"+INDEX).hide().fadeIn(300);
			if(type == 'user'){
				$("#chat-input").val(''); 
			}    
			$(".chat-logs").stop().animate({ scrollTop: $(".chat-logs")[0].scrollHeight}, 1000); 
		
		}
  
  function sendSpeech() {
    var recognition = new SpeechRecognition();
    var speechRecognitionList = new SpeechGrammarList();
    recognition.grammars = speechRecognitionList;
    recognition.lang = "ko-KR";
    recognition.interimResults = false; // true: 중간 결과를 반환, false: 최종 결과만 반환
    recognition.continious = false; // true: 음성인식을 계속해서 수행, false: 음성인식을 한번만 수행
    recognition.maxAlternatives = 1;

    recognition.start();

    //음성인식의 결과를 텍스트로 반환
    recognition.onresult = function (event) {
      speechResult = event.results[0][0].transcript.toLowerCase();
      console.log("Confidence: " + event.results[0][0].confidence);
      console.log("Speech Result: " + speechResult);
      //diagnosticPara.textContent = 'Speech received: ' + speechResult + '.';
      
      var chartInputVal = $("#chat-input").val(speechResult);
      
      $("#chat-submit").trigger("click");
    };

    recognition.onaudiostart = function (event) {
      //Fired when the user agent has started to capture audio.
      //오디오 캡처를 시작하면 실행
      console.log("SpeechRecognition.onaudiostart");
      $("#chat-input").attr("placeholder", "지금 말씀하세요 !");
    };

    recognition.onaudioend = function (event) {
      //Fired when the user agent has finished capturing audio.
      //오디오 캡처를 완료하면 실행
      console.log("SpeechRecognition.onaudioend");
    };

    recognition.onend = function (event) {
      //Fired when the speech recognition service has disconnected.
      //음성 인식 서비스의 연결이 끊어지면 실행
      console.log("SpeechRecognition.onend");
      $("#chat-input").attr(
        "placeholder",
        "마이크 버튼을 누르면 음성인식이 작동합니다."
      );
    };

    recognition.onnomatch = function (event) {
      //Fired when the speech recognition service returns a final result with no significant recognition.
      //This may involve some degree of recognition, which doesn't meet or exceed the confidence threshold.
      //음성 인식 서비스가 중요한 인식 없이 최종 결과를 반환하면 실행
      //여기에는 신뢰도 임계값을 충족하거나 초과하지 않는 어느 정도의 인식이 포함될 수 있습니다.
      //(인식률이 낮아 신뢰도가 낮을수 있는 결과를 반환 했을 때)
      console.log("SpeechRecognition.onnomatch");
    };

    recognition.onsoundstart = function (event) {
      //Fired when any sound — recognisable speech or not — has been detected.
      //소리가 감지되면 실행
      console.log("SpeechRecognition.onsoundstart");
    };

    recognition.onsoundend = function (event) {
      //Fired when any sound — recognisable speech or not — has stopped being detected.
      //소리 감지가 중지되면 실행
      console.log("SpeechRecognition.onsoundend");
    };

    recognition.onspeechstart = function (event) {
      //Fired when sound that is recognised by the speech recognition service as speech has been detected.
      //음성으로 인식된 소리가 감지되면 실행
      console.log("SpeechRecognition.onspeechstart");
    };
    recognition.onstart = function (event) {
      //Fired when the speech recognition service has begun listening to incoming audio with intent to recognize grammars associated with the current SpeechRecognition.
      //SpeechRecognition과 관련된 텍스트로 인식하기 위한 오디오를 듣기 시작하면 실행
      console.log("SpeechRecognition.onstart");
    };
  }

  
</script>
