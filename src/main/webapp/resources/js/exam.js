/**
 * 
 */

function addExcelQstList(qstNo, examQstObj) {
    var qstChList = examQstObj.qstChList;
    
    var code = ''
        +'<li class="row Qst">                                             '
        +'<div class="col-1">                                              '
        +'	<span class="box-title" style="">'+ qstNo +'</span>           '
        +'</div>                                                           '
        +'<div class="col-9">	                                           '
        +'	<button class="btn btn-secondary btn-sm text-truncate max-w-150 qstDetail">' + examQstObj.examQst + ' </button> '
        +'</div>                                                           '
        +'<div class="col-2 position-relative">	                           '
        +'	<button type="button" class="btn-close position-absolute top-50 start-50 translate-middle qstDelBtn" title="삭제"></button> '
        +'</div>                                                           '
        +'<input type="hidden" class="qstName" value="' + examQstObj.examQst +'"> '
        +'<input type="hidden" class="qstFileName" value=""> '
        +'<input type="hidden" class="qstFileNo" value="0"> '
        +'<input type="hidden" class="qstScore" value="' + examQstObj.qstScore +'"> '
        +'<input type="hidden" class="qstCorrect" value="' + examQstObj.qstCorrect +'"> '

	    for (var i = 0; i < qstChList.length; i++) {
	        if(qstChList[i].chStr != null && qstChList[i].chStr != ""){
	            code += '<input type="hidden" class="qstChoice" value="' + qstChList[i].chStr +'"> '
	        }
	    }
        
        code += '</li>        ';

    Qst.append(code);
}

function updateQstList() {
    console.log("update")
    var qstlist = Qst.find("li");
    
    var qstListNo = examQstNo.val();
    console.log("now qstNo : " + qstListNo)
    
    for (var i = 0; i < qstlist.length; i++) {
        if($(qstlist[i]).find(".box-title").text() == qstListNo){
            var qdetail = $(qstlist[i]);
            qdetail.find(".qstDetail").text(examQst.val());
            qdetail.find(".qstName").val(examQst.val());
            qdetail.find(".qstFileName").val(examImg.val())
            qdetail.find(".qstFileNo").val(examImgFileNo.val())
            qdetail.find(".qstScore").val(qstScore.val())
            qdetail.find(".qstCorrect").val(qstCorrect.val())
            
            $(qdetail).find(".qstChoice").remove();
            
            var qstChoice = qchoice.find(".choiceStr");
            
            for (var i = 0; i < qstChoice.length; i++) {
                code = '<input type="hidden" class="qstChoice" value="' + $(qstChoice[i]).val() +'"> '
                $(qdetail).append(code);
            }
        }
    }
}

function addQstList() {
    var qstNo = Qst.find("li").length + 1;
    
    var qstChoice = qchoice.find(".choiceStr");
    var chStr = [];
    
    for (var i = 0; i < qstChoice.length; i++) {
        chStr.push($(qstChoice[i]).val());
    }
    
    console.log("chStr : ",chStr);
    
    var code = ''
        +'<li class="row Qst">                                             '
        +'<div class="col-1">                                              '
        +'	<span class="box-title" style="">'+ qstNo +'</span>           '
        +'</div>                                                           '
        +'<div class="col-9">	                                           '
        +'	<button class="btn btn-secondary btn-sm text-truncate max-w-150 qstDetail">' + examQst.val() + ' </button> '
        +'</div>                                                           '
        +'<div class="col-2 position-relative">	                           '
        +'	<button type="button" class="btn-close position-absolute top-50 start-50 translate-middle qstDelBtn" title="삭제"></button> '
        +'</div>                                                           '
        +'<input type="hidden" class="qstName" value="' + examQst.val() +'"> '
        +'<input type="hidden" class="qstFileName" value="' + examImg.val() +'"> '
        +'<input type="hidden" class="qstFileNo" value="' + examImgFileNo.val() +'"> '
        +'<input type="hidden" class="qstScore" value="' + qstScore.val() +'"> '
        +'<input type="hidden" class="qstCorrect" value="' + qstCorrect.val() +'"> '

        for (var i = 0; i < chStr.length; i++) {
            code += '<input type="hidden" class="qstChoice" value="' + chStr[i] +'"> '
        }
        
        code += '</li>        ';

    Qst.append(code);
}

function addCh(val, chNo) {
    var code = ''
        +'<li class="row choice">                     '
        +'<div class="col-1">                         '
        +'	<span class="box-title" >' +chNo+'.</span>'
        +'</div>                                      '
        +'<div class="col-10">	                      '
        +'	<input class="form-control choiceStr" value="' + val + '">    '
        +'</div>                                      '
        +'<div class="col-1 position-relative">	      '
        +'<button type="button" class="btn-close position-absolute top-50 start-50 translate-middle chDelBtn" title="삭제"></button>'
        +'</div>                                      '
        +'</li>                                       '
    qchoice.append(code);
}

qstScore.on("change", function () {
    try{
        parseInt(this.value);
    } catch (e) {
        this.value = 1;
    }
    
    if(this.value < 1){
        this.value = 1;
    }
    
    if(this.value > 100){
        this.value = 100;
    }
})

qstCorrect.on("change", function () {
    console.log("changes...", this.value);
    
    try{
        parseInt(this.value);
    } catch (e) {
        this.value = 1;
    }
    
    if(this.value < 1){
        this.value = 1;
    }
    
    var chl = qchoice.find("li").length;
    if(this.value > chl){
        this.value = chl;
    }
})

$("#examTime").on("change", function(){
    console.log("changes...", this.value);
    
    try{
        parseInt(this.value);
    } catch (e) {
        this.value = 10;
    }
    
    if(this.value < 10){
        this.value = 10;
    }
    
    if(this.value > 180){
        this.value = 180;
    }
})

//문제 임시 목록 추가
addQstBtn.on("click", function () {
    console.log("addQst");
    
    if(examQstNo.val() == 0){
        //문제 목록 추가
        addQstList();
    } else {
        updateQstList();
    }
    
    //제출 폼 초기화
    resetQstBtn.trigger("click");
    resetChoiceBtn.trigger("click");
    updateTotalScore();
})


//보기 삭제 버튼
$(document).on("click", ".chDelBtn", function () {
    console.log("del");
    $(this).parents("li").remove();
    
    var chl = qchoice.find("li");
    
    //보기 번호 재설정
    for (var i = 2; i < chl.length; i++) {
        $(chl[i]).find(".box-title").text( (i + 1) + ".");
    }
})

//보기 추가
addChoiceBtn.on("click", function (){
    var chNo = qchoice.find("li").length + 1;
    
    if(chNo > 10){
        alert("보기는 최대 10개입니다.");
        return false;
    }
    
    addCh("", chNo);
    
})

//설정중인 보기 초기화
resetChoiceBtn.on("click", function (){
    var code = ''
        +'<li class="row choice">                     '
        +'<div class="col-1">                         '
        +'	<span class="box-title" >1.</span>        '
        +'</div>                                      '
        +'<div class="col-10">	                      '
        +'	<input class="form-control choiceStr">    '
        +'</div>                                      '
        +'<div class="col-1 position-relative">	      '
        +'</div>                                      '
        +'</li>                                       '
        +'<li class="row choice">                     '
        +'<div class="col-1">                         '
        +'	<span class="box-title" >2.</span>        '
        +'</div>                                      '
        +'<div class="col-10">	                      '
        +'	<input class="form-control choiceStr">    '
        +'</div>                                      '
        +'<div class="col-1 position-relative">	      '
        +'</div>                                      '
        +'</li>                                       '
    
    $("#qchoice").html(code);
})

//설정중인 문제 초기화
resetQstBtn.on("click", function () {
    examQst.val("");
    examImg.val("");
    examImgFileNo.val("");
    qstCorrect.val("1");
    qstScore.val("5");
    examQstNo.val("0")
    addQstBtn.text("문제 저장");
})

//파일 업로드
examImg.on("change", function (event) {
    console.log("file name : " + $(this).val());
    
    var file = event.target.files[0];
    
    //사진여부 확인
    if(!isImageFile(file)){
        console.log("not img file...");
        alert("사진만 등록 가능합니다.");
        examImg.val("");
        return false;
    }
    
    addQstBtn.attr("disabled", true);
    
    var formData = new FormData();
    formData.append("files", file);
    
    $.ajax({
        url : "/DYUniv/examFileUpload.ajax",
        type : "post",
        data : formData,
        processData : false,
        contentType : false,
        success : function(res){
            if(res > 0){
                console.log("file upload success. res : "+ res);
                examImgFileNo.val(res);
            } else {
                alert("파일 업로드 실패...")
            }
            addQstBtn.removeAttr("disabled");
        },
        error : function(request,status,error){        
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);  
            addQstBtn.removeAttr("disabled");
        }
    })
})

//과제 선택
exSelect.on("change", function () {
    var examNo = $(this).val();
    
    if(examNo == null || examNo == ""){
        return false;
    }
    
    var data = {
            "examNo" : examNo
    }
    
    exSubList.html(
        '<tr>'
            + '<td colspan="6">조회하실 게시물이 존재하지 않습니다.</td>'
        + '</tr>'
    );

    $.ajax({
        type: 'post',
        url: '/DYUniv/class/exSubmitList',
        data : data,
        success: function (res) { /* 결과 성공 콜백함수 */
            console.log(res);
        
            code = '';

            if(res != null && res.length > 0){
                $.each(res, function(i,v)  {
                    
                    var fileNo = "0";
                    var fileName = "(제출 파일 없음)";
                    
                    if(v.fileNo != 0){
                        fileNo = v.fileNo;
                        fileName = v.fileName;
                    }
                    
                    code += '<tr class="exMemList">';
                    code += '	<td class="">' + v.memId + '</td>';
                    code += '	<td class="memName" idx="'+ v.memNo +'">' + v.memName + '</td>';
                    code += '	<td>' + v.examName + '</td>';
                    code += '	<td>' + v.answerDate.substr(0,10) + '</td>';
                    code += '	<td class="text-center"><button class="btn btn-primary-light btn-xs examDetailBtn" idt="' + v.examNo + '">시험지 체점하기</button></td>';
                    code += '	<td class="exScore text-end" idx="'+ v.examNo +'"><input type="number" value="'+ v.totalScore +'" readonly> </td>';
                    code += '</tr>';
                });
            } 
            //console.log(code);
            exSubList.html(code);
        }
    })
})

function updateTotalScore() {
    console.log("set totalscore")
    var qstlist = Qst.find("li");
    
    var totalScore = 0;
    
    for (var i = 0; i < qstlist.length; i++) {
        //console.log($(qstlist[i]).find(".qstScore").val());
        var score = $(qstlist[i]).find(".qstScore").val();
        totalScore += parseInt(score);
    }
    console.log(totalScore);
    examTotalScore.val(totalScore);
}