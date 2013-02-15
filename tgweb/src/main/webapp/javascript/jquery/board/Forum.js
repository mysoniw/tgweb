
//*****************************************************************************
//* 필터 버튼 클릭을 시뮬레이션합니다.
//*****************************************************************************

function ActiveFilter(buttonID)
{
    var objButton = document.getElementById(buttonID);
    if (objButton != null && event.keyCode == 13)
        __doPostBack(buttonID.replace(/_/img, "$"), "");
}

//*****************************************************************************
//*****************************************************************************
//* 아티클 작성, 답변, 편집 페이지 관련 함수
//*****************************************************************************
//*****************************************************************************

//*****************************************************************************
//* 아티클 본문 입력란의 크기를 조절합니다.
//*****************************************************************************

function AdjustTextArea(textareaID, type, textareaInfoID)
{
    var objTextArea       = document.getElementById(textareaID);
    var objTextAreaInfoID = document.getElementById(textareaInfoID);
    if (objTextArea == null)
        return;
    
    var currentHeight      = objTextArea.style.height;
    var currentHeightValue = parseInt(currentHeight.replace(/px/img, ""), 10);
    var adjustHeightValue  = 0;
    
    if (type.toUpperCase() == "E")
        adjustHeightValue = currentHeightValue + 32;
    else if (type.toUpperCase() == "R")
        adjustHeightValue = currentHeightValue - 32;
    
    objTextArea.style.height = adjustHeightValue + "px";
    
    if (objTextAreaInfoID != null)
        objTextAreaInfoID.value = objTextArea.style.height;
}

//*****************************************************************************
//* 선택한 텍스트 영역을 지정한 HTML 태그로 태깅합니다.
//*****************************************************************************

function ApplyHTMLTag(objTextArea, tagType, objCheckBox) {

    if (objTextArea.isTextEdit) 
    {
        if (!objTextArea.caretPos) SaveCaret(objTextArea);
        switch (tagType.toUpperCase())
        {
            case "B" :
                objTextArea.caretPos.text = "<b>" + objTextArea.caretPos.text + "</b>";
                break;
            case "I" :
                objTextArea.caretPos.text = "<i>" + objTextArea.caretPos.text + "</i>";
                break;
            case "C" :
                objTextArea.caretPos.text = "\r\n<pre class=\"code_block\">\r\n" + objTextArea.caretPos.text + "\r\n</pre>\r\n";
                break;
            default :
                break;
        }
        objTextArea.caretPos.select();
    }
    
    if (objCheckBox != null) objCheckBox.checked = true;
}

//*****************************************************************************
//* 현재 캐럿 위치에 문자열을 입력합니다.
//*****************************************************************************

function InsertString(textareaID, insertText, checkboxID)
{   
    var objTextArea = document.getElementById(textareaID);
    if (objTextArea.isTextEdit) 
    {
        if (!objTextArea.caretPos) SaveCaret(objTextArea);       
        objTextArea.caretPos.text = insertText;
        objTextArea.caretPos.select();
    }
    
    var objCheckBox = document.getElementById(checkboxID);
    if (objCheckBox != null) objCheckBox.checked = true;
}

//*****************************************************************************
//* 현재 선택된 영역을 별도의 속성에 저장합니다.
//*****************************************************************************

function SaveCaret(objTextArea)
{
    if (objTextArea.isTextEdit) 
        objTextArea.caretPos = document.selection.createRange();
}

//*****************************************************************************
//* 코드 블럭이 설정된 뒤 호출되어 크린업 작업을 처리합니다.
//*****************************************************************************

function CleanUpCodeBlock(textareaID)
{
    var objTextArea = document.getElementById(textareaID);
    if (objTextArea != null) 
    {
        objTextArea.innerText = objTextArea.innerText.replace(/\r\n\r\n<pre class=/img, "\r\n<pre class=");
        objTextArea.innerText = objTextArea.innerText.replace(/pre>\r\n\r\n/img, "pre>\r\n");
    }
}

//*****************************************************************************
//* 지정한 파일을 다운로드합니다.   
//*****************************************************************************

function DownloadFile(target, number, tableID)
{
    var targetURL = "Downloader.aspx?tableID=" + tableID + "&number=" + number + "&target=" + target;
    if (window.downloadHiddenFrame == null)
        window.document.body.insertAdjacentHTML("beforeEnd", "<iframe name=\"downloadHiddenFrame\" width=\"0px\" height=\"0px\"></iframe>");
        
    var objFrameDocument = window.downloadHiddenFrame.document;
    objFrameDocument.open();
    objFrameDocument.write(
        "<frameset name=\"innerDownloadFrameset\" rows=\"100%\">" +
        "<frame name=\"innerDownloadFrame\" src=\"" + targetURL + "\">" +
        "</frameset>");
    objFrameDocument.close();
}

//*************************************************************************
//* 커멘트의 바이트 크기를 점검하여 250 보다 크면 false 를 리턴합니다.
//*************************************************************************

function CheckCommentLength(source)
{
    var size = GetTextByteSize(Trim(source))
    if (size > 250)
    {
        alert("커멘트의 내용은 250 바이트까지만 입력하실 수 있습니다.");
        return false;
    }
    return true;    
}

function GetTextByteSize(source)
{
    var Count = 0;
    for (var i = 0; i < source.length; i++) 
        Count += (source.charCodeAt(i) > 128) ? 2 : 1;
    return Count;
}