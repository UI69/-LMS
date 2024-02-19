<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>

<body>
<h2>결제 성공</h2>
${kakaoApprove }

<h1></h1>
${kakaoApprove.item_name }

<div id="capture" style="padding: 10px; background: #f5da55">
<h4 style="color: #000;">결제한 증명서에 맞게 미리보기 출력  부분</h4>
	<div>
	상풍명 :졸업증명서  ex)  결제한 증명서 에 맞게    미리보기 나오고 다운로드 가 나와야 한다 
	</div>


</div>
<button id="pdfBtn">PDF 다운로드</button>



</body>

<script type="text/javascript">
function createPdf(){
	html2canvas(document.querySelector("#capture")).then(canvas => {
	// html2canvas를 사용하여 ID가 "capture"인 요소의 내용을 캡처
	
	var imgData = canvas.toDataURL('image/jpeg');
	// 캔버스 데이터를 JPEG 형식의 데이터 URL로 변환
	// PDF의 초기 매개변수를 설정
	
	var imgWidth = 210; 
	var pageHeight = imgWidth * 1.414; 
	var imgHeight = canvas.height * imgWidth / canvas.width;
	var heightLeft = imgHeight;
	var margin = 20;
	
	// jsPDF 라이브러리를 사용하여 새로운 PDF 문서를 생성
	var doc = new jsPDF('p', 'mm', 'a4');
	var position = 0;
	
		// 첫 페이지에 이미지를 추가합니다.
		doc.addImage(imgData, 'jpeg', margin, position, imgWidth, imgHeight);
		heightLeft -= pageHeight; // 남은 높이 갱신
		// 이미지 높이가 페이지 높이보다 클 경우 추가 페이지를 생성
		while (heightLeft >= 20) {
			position = heightLeft - imgHeight;
			doc.addPage();
			doc.addImage(imgData, 'jpeg', margin, position, imgWidth, imgHeight);
			heightLeft -= pageHeight;
			}
		
		// 생성된 PDF를 'sample.pdf'로 저장
		doc.save('sample.pdf');
		
		});
}
	// 버튼 클릭 시 createPdf 함수 호출
	$("#pdfBtn").on("click", function(){
		createPdf();
		
	});

</script>
