<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<link href="/javascript/jquery/board/css/Site.css" rel="stylesheet" type="text/css" />
<link href="/javascript/jquery/board/css/uploadify.css" rel="stylesheet" type="text/css" />
<script src="/javascript/jquery/board/jquery.form.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/jquery.cookie.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/jquery.simplemodal-1.2.3.min.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/Common.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/Init.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/Forum.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#ctl00_userid").css("color", "silver").focus(function() {
			$(this).css("color", "black")
			if ($(this).val() == "아이디") {
				$(this).val("");
			}
		}).blur(function() {
			if ($(this).val() == "") {
				$(this).css("color", "silver");
				$(this).val("아이디");
			}
		});

		$("#goBoard").click(function() {
			var selectedBoard = $("select#workPart").val();
			location.href = "/Forum/";

		});

		$("#accordion").accordion();
	});
</script>
<form id="boardWriteForm" method="post">
	<table cellpadding="0" cellspacing="0" border="0" width="100%" style="background-color:White;">
		<tr>
			<td style="padding:20px;vertical-align:top">
			<script type="text/javascript">
				var idx = 0;
				var thread = 0;
				var depth = 0;

				$(document).ready(function() {
					//인자로 넘어오는 쿼리스트링들을 로컬 DOM에 적재시킨다.
					if ("${params.idx}".length > 0)
						$("body").append($("<input id='idx' name='idx' />").val("${params.idx}").css("display", "none"));
					if ("${params.thread}".length > 0 && "${params.depth}".length > 0) {
						$("body").append($("<input id='thread' name='thread' />").val("${params.thread}").css("display", "none"));
						$("body").append($("<input id='depth' name='depth' />").val("${params.depth}").css("display", "none"));
						$("#postPart").text("답변 글");
					}
					if ("${params.mode}".length > 0) {
						$("body").append($("<input id='onEditing' name='onEditing' />").val("${params.mode}").css("display", "none"));
						$("#postPart").text("글 수정");
					}

					$("#toList").click(function() {
						var url = "supBoard.do?method=l";
						if ("${params.idx}".length > 0)
							url = url + "&idx=" + "${params.idx}";
						if ("${params.page}".length > 0) {
							url = url + "&page=" + "${params.page}";
						}
						location.href = url;
					});

					//답변 글이라면 원래의 본문을 페이지 하단에 안 보이게 출력
					if ($("input[id=thread]").get(0)) {
						idx = $("input[id=idx]").val();
						thread = $("input[id=thread]").val();
						depth = $("input[id=depth]").val();

						//ajax로 본문내용 수신
						Write.OutputContent();

						//질문글 보기 클릭시 내용 슬라이딩
						$("p#viewData").css("display", "").click(function() {
							$("div#parentContent").hide().slideDown();
						});
					}

					//글 수정이라면 원래글을 입력 컨트롤에 출력
					if ($("input[id=onEditing]").get(0)) {
						idx = $("input[id=idx]").val();
						Write.EditContent();
					}

					//B, I, 코드
					$(".tagging:eq(0)").click(function() {
						Write.ChangeToTag("B");
					});
					$(".tagging:eq(1)").click(function() {
						Write.ChangeToTag("I");
					});
					$(".tagging:eq(2)").click(function() {
						Write.ChangeToTag("CODE");
					});

					$("#useAutoBr").click(function() {
						if ($(this).get(0).checked)
							$("#contents").attr('wrap', 'hard');
						else
							$("#contents").attr('wrap', 'off');
					});

					///글 저장
					$("#submit").click(function() {
						if ($("#subject").val().replace(/\s/g, "").length == 0) {
							alert("제목을 작성해 주십시오");
							return;
						}
						
						if ($("#contents").val().replace(/\s/g, "").length == 0) {
							alert("본문을 작성해 주십시오");
							return;
						}

						Common.showProgressBox("저장하고 있습니다...");

						var targetURI;
						if ($("input[id=onEditing]").get(0))
							targetURI = "supBoard.do?method=up";
						else
							targetURI = "supBoard.do?method=cp";

						//alert(targetURI); return;
						
						var sss = {};
						
						$.extend(sss, {idx: idx, thread: thread, depth: depth}, $("#boardWriteForm").serializeObject());
						
						$.ajax({
							url : targetURI,
							type: "post",
							contentType: "application/x-www-form-urlencoded",
							data : $.extend({idx: idx, thread: thread, depth: depth}, $("#boardWriteForm").serializeObject()),
								
								/*
								"{" 
									+ Common.format(
										" subject:\"{0}\", useAutoBr:\"{1}\", useHtml:\"{2}\", thread:\"{3}\", depth:\"{4}\", contents:\"{5}\", idx : \"{6}\" "
										, Common.replaceJSONSafeEscape($("#subject").val())
										, $("#useAutoBr").get(0).checked ? "on" : "off"
										, $("#useHtml").get(0).checked ? "on" : "off"
										, thread
										, depth
										, Common.replaceJSONSafeEscape($("#contents").val()), idx)
									+ "}",
								*/
							success : function(data) {
								var query = "";
								
								if (data != null && data.idx > 0) {
									query = "&idx=" + data.idx;
								} else {
									query = "&idx=" + idx;
								}

								$.modal.close();
								location.href = "supBoard.do?method=l" + query;
							}
						});
					});

					//미리보기 버튼
					$(".tagging:last").click(function() {
						if ($("#useHtml").get(0).checked) {
							$("#view").html($("#contents").val().replace(/\r/g, '<br />'));
						} else {
							//alert(Common.escapeHTML($("#contents").text().replace(/\r/g, '<br />'));

							$("#view").html(Common.escapeHTML($("#contents").text()).replace(/\r/g, '<br />').replace(/\s\s/g, " &nbsp;"));
						}
						$("#view").slideUp('fast').slideDown();
					});

					$("#contents").select(function() {
						Write.StoreCarot();
					}).click(function() {
						Write.StoreCarot();
					}).keyup(function() {
						Write.StoreCarot();
					});

					//공통 ajax 예외 처리
//					$("#errorInfo").ajaxError(function(info, obj) {
//						$(info.target).empty().html(obj.responseText);
//					});
				});

				Write = function() {
				};
				Write.StoreCarot = function() {
					var textArea = $("#contents").get(0);
					if (textArea.createTextRange) {
						textArea.caretPos = document.selection.createRange().duplicate();
					}
				};

				Write.ChangeToTag = function(type) {
					var textArea = $("#contents").get(0);
					if (textArea.createTextRange && textArea.caretPos) {
						var position = textArea.caretPos;
						var replacedText = position.text;
						if (type == "B")
							replacedText = "<b>" + replacedText + "</b>";
						else if (type == "I")
							replacedText = "<i>" + replacedText + "</i>";
						else if (type == "CODE")
							replacedText = "<div class='code'>" + replacedText + "</div>";

						position.text = position.text.charAt(position.text.length - 1) == ' ' ? replacedText + ' ' : replacedText;
					} else {
						textArea.value = textArea.value;
					}
					textArea.focus();
				};

				//본문 데이터 수신 및 출력
				Write.OutputContent = function() {
					$.ajax({
						url : "supBoard.do?method=r",
						type: "post",
						contentType: "application/x-www-form-urlencoded",
						data : {idx: idx, updateReadCount: false},
						success : function(data) {
							
							var contents = data.contents;
							if (data.useHtml == 0)
								contents = Common.escapeHTML(contents);
							//UseHtml, UseAutoBR

							$("div#title").text(data.subject);
							$("#subject").val("Re: " + data.subject); //답변 제목 자동설정
							$("span#writer").text(data.userName);
							$("span#inputDate").text(data.insertDate);
							$("span#read").text(data.readCount);
							$("pre#text").html(contents.replace(/\r/g, "<br />").replace(/\s\s/g, " &nbsp;"));
						}
					});
				};

				Write.EditContent = function() {
					$.ajax({
						url : "supBoard.do?method=r",
						type: "post",
						contentType: "application/x-www-form-urlencoded",
						data : {idx: idx, updateReadCount: false},
						success : function(data) {
							
							var contents = data.contents;
							if (data.useHtml == 0)
								$("input#useHtml").get(0).checked = false;
							if (data.useAutoBr == 0)
								$("input#useAutoBr").get(0).checked = false;
							//UseHtml, UseAutoBR

							$("input#subject").val(data.subject);
							$("#contents").val(contents);
						}
					});
				};
			</script> <!-- 질문 글 / 답변 글 표시 -->
				<div style="width:100%; text-align:left;font-size:14px;; font-family:'맑은 고딕', verdana;">
					<b><span id="postPart" style="width:100%; text-align:left;font-size:14px;; font-family:'맑은 고딕', verdana;">새 글</span> 작성</b>
				</div> 
				<br /> <!-- 입력 폼 -->
				<table cellspacing="1" cellpadding="3" style="background-color:silver; width:680px">
					<tr>
						<td class="header">제 목</td>
						<td align="left" style="background-color:white"><input type="text" id="subject" name="subject" style="width:96%;" maxlength="60" /></td>
					</tr>
					<tr>
						<td colspan="2" style="background-color:white"><textarea id="contents" name="contents" style="height:200px;width:98%" rows="1" wrap="hard"></textarea></td>
					</tr>
				</table> <!-- 작성 방식 표시 -->
				<table cellspacing="1" cellpadding="3" style="background-color:white; width:680px">
					<tr>
						<td align="left" style="width:150px"><input type="checkbox" id="useHtml" name="useHtml" checked="checked" value="1" />
							<label for="useHtml">Html 사용하기</label>
						</td>
						<td align="left"><input type="checkbox" id="useAutoBr" name="useAutoBr" checked="checked" value="1" />
							<label for="useAutoBr">자동 줄바꿈</label>
						</td>
						<td align="right"><input type="button" class="tagging" value="B" />
							<input type="button" class="tagging" value="I" />
							<input type="button" class="tagging" value="코드" style="width:50px" />
							<input type="button" class="tagging" value="미리보기" style="width:70px" />
						</td>
					</tr>
					<tr>
						<td colspan="3" align="center"><pre id="view" style="display:none; background:red;padding:10px; text-align:left; border:solid 1px gray; background-color:white; width:640px">
				</pre></td>
					</tr>
				</table> <!-- 명령 버튼  -->
				<table cellspacing="0" width="680px">
					<tr>
						<td align="right" style="">
							<img id="submit" src="/javascript/jquery/board/image/forumSubmit.gif" alt="저장합니다" />
							<img id="toList" src="/javascript/jquery/board/image/forumList.gif" alt="목록으로" border="0" class="link" />
						</td>
					</tr>
				</table> <!-- 답변 입력 시 출력될 본문-->
				<p id="viewData" style="display:none;">
					<img src="/javascript/jquery/board/image/arrow.gif" /> <a href="#" style="font-weight:bold">질문 글 내용 보기</a>
				</p>

				<div id="parentContent" style="display:none">
					<table id="t2" cellspacing="0" cellpadding="4" style="background-color:#efefef; width:680px">
						<tr>
							<td class="siteBar"><img style="float:left;" src="/javascript/jquery/board/image/forumHeaderLeftEdge.png" />
								<div style="float:left; padding: 8px 0px 0px 5px;font-weight:bold" id="title"></div> <img style="float:right;" src="/javascript/jquery/board/image/forumHeaderRightEdge.png" /></td>
						</tr>
						<tr>
							<td style="background:white"><span style="float:left">작성자 : <span id="writer"></span>
							</span> <span style="float:right">작성일 : <span id="inputDate"></span>, 조회 : <span id="read"></span>
							</span></td>
						</tr>
						<tr>
							<td align="left" style="background:#FAFAFA;border:solid 1px silver; height:30px;padding:7px"><pre id="text"></pre></td>
						</tr>
					</table>
				</div>

				<div id="errorInfo" style="table-layout:fixed;width:650px; color:Red">
				</div>
			</td>
		</tr>
	</table>

	<!-- ajax 호출시 상태창으로 보여줄 부분 -->
	<div id="progressBox" style="display:none;padding:10px;">
		<a href='#' id="close" style="float:right; color:silver; padding-right:3px;">x</a>
		<p style="text-align:center;width:100%">
			<img src="/javascript/jquery/board/image/loader2.gif" />
		</p>
		<p style="text-align:center;width:100%;" id="message"></p>
	</div>
</form>
<br />
