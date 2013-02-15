<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<link href="/javascript/jquery/board/css/Site.css" rel="stylesheet" type="text/css" />
<link href="/javascript/jquery/board/css/uploadify.css" rel="stylesheet" type="text/css" />
<script src="/javascript/jquery/board/jquery.form.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/jquery.cookie.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/jquery.simplemodal-1.2.3.min.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/swfobject.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/jquery.uploadify.v2.1.4.js?aaa=11" type="text/javascript"></script>
<script src="/javascript/jquery/board/Common.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/Init.js" type="text/javascript"></script>
<script src="/javascript/jquery/board/Forum.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#ctl00_userid")
		.css("color", "silver")
		.focus(function() {
			$(this).css("color", "black")
			if ($(this).val() == "아이디") {
				$(this).val("");
			}
		})
		.blur(function() {
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
<form method="post">
	<table cellpadding="0" cellspacing="0" border="0" width="100%" style="background-color:White;">
		<tr>
			<td style="padding:20px;vertical-align:top">
			<script type="text/javascript">
				String.prototype.unescapeHtml = function () {
				    var temp = document.createElement("div");
				    temp.innerHTML = this;
				    var result = temp.childNodes[0].nodeValue;
				    temp.removeChild(temp.firstChild);
				    return result;
				};
			
				var forumListRowTemplate =
				"<tr style='background:white' idx='{0}' commentCnt='{5}' depth='{6}' isDeleted='{7}' userId='{8}'>" +
				"   <td style='text-align:right;;padding-right:10px'>{0}</td>" +
				"   <td align='left'><a href='#' idx='{0}'>{1}</a></td>" +
				"   <td style='text-align:center'>{2}</td>" +
				"   <td style='text-align:center'>{3}</td>" +
				"   <td style='text-align:right;padding-right:10px'>{4}</td>" +
				"</tr>";
				var commentListRowTemplate =
				"<tr style='background:white' idx='{0}' userId='{4}'>" +
				"<td style='width:80px'>{1}</td>" +
				"<td>{2}</td>" +
				"<td style='font-size:11px;width:80px'>{3}</td>" +
				"</tr>";
				var commentCountInfoTemplate = " <span id='commentInfo'><img src='/javascript/jquery/board/image/forumCommentCnt.gif' />" +
				"(<span id='commentCntVal'>{0}</span>)</span>";
				var forumReTemplate = "<img src='/javascript/jquery/board/image/forumBlank.gif' style='width:{0}px;height:0px' /><img src='/javascript/jquery/board/image/forumRe.gif' /> ";
				var fileListTemplate = "<div idx='{0}' svrFileName='{3}'>" +
				"<a href='supBoard.do?method=file&idx={0}&svrFileName={3}' target='_new'><img src='/javascript/jquery/board/image/F.gif' border='0' /> <u>{1}</u> ({2})</a></div> ";
				var _currentIdx = 0;
				var _currentThread = 0;
				var _currentDepth = 0;
				var _currentPage = 1;
				var _totalItemCount = 0;
				var _pageCount = 0;
				//########### 페이지 당 출력 레코드 수 #########
				var _recordPerPage = 20;
				//##################################################
				var iLoop = 1;
				var iLoopEnd = 10;
				var Forum = function() {
				}
				$(document).ready(function() {
					if (Common.queryString("page").length > 0) {
						_currentPage = Common.queryString("page");
					}

					//초기에 목록을 출력한다.
					Forum.OutputList();

					//직접 하이퍼링크로 온 경우에는 해당 본문을 출력한다.
					if (Common.queryString("idx").length > 0) {
						_currentIdx = Common.queryString("idx");
						Forum.OutputContent();
						Forum.OutputCommentList();
					}

					//목록 버튼을 누르면, 본문을 숨긴다.
					$("img.toList").click(function() {
						$("div#contents").slideUp();
						Forum.OutputList();
					});

					//답변하기 링크 설정
					$("img#reply").click(function() {
						location.href = Common.format("supBoard.do?method=c&idx={0}&thread={1}&depth={2}&page={3}"
						, _currentIdx, _currentThread, _currentDepth, _currentPage);
					});

					//수정하기 링크 설정
					$("img#edit").click(function() {
						location.href = "supBoard.do?method=c&mode=e&idx=" + _currentIdx + "&page=" + _currentPage;
					});

					//삭제하기 링크 설정
					$("img#del").click(function() {
						if (confirm("정말로 삭제하시겠습니까?"))
							Forum.DeleteForumData();
						else
							return;
					});

					//인증되지 않은 사용자에게는 글쓰기 관련 버튼, 코멘트 입력창 모두 히든처리
//					if ($.cookie("userID") == null) {
//						$("#write2").hide();
//						$("#formComment").hide();
//					}

					//파일 업로드 설정(Flash)
					$("#uploadify").uploadify({
						uploader: "/javascript/jquery/board/uploadify.swf",
						cancelImg: "/javascript/jquery/board/image/cancel.png",
						script: "/trusted/supBoard.do?method=upload",
						//folder: "c:/files",
						//scriptAccess: "always",
						//displayData     : 'speed',
						//scriptData: {idx: _currentIdx},
						auto: true,
						buttonImg: "/javascript/jquery/board/image/ForumUpload.gif",
						onSelect: function() {
							$("#uploadify").uploadifySettings("scriptData", {idx: _currentIdx});
						},
						onAllComplete: function(event,fileObj) {
						//	$("#uploadify").uploadifyClearQueue();
							Forum.OutputFileList();
						}
					});

					//코멘트 등록 버튼 클릭 처리기
					$("#addComment").click(function() {
						var comment = $("#comment").val();
						if (comment.replace(/\s/g, "").length == 0) {
							alert("코멘트를 작성해 주십시오");
							return;
						}
						if (comment.length > 1000) {
							alert("코멘트의 길이가 너무 깁니다. 1000글자 제한입니다");
							return;
						}
						Common.showProgressBox("코멘트를 저장중입니다...");
						$.ajax({
							url : "supBoard.do?method=commentCreate",
							type: "post",
							contentType: "application/x-www-form-urlencoded",
							data : {pIdx: _currentIdx, comment: Common.replaceJSONSafeEscape(comment)},
							success : function(data) {
								$("#comment").val("");
								//포럼 코멘트 목록 재출력
								Forum.OutputCommentList();
								//현재 목록의 제목 TD를 찾아가서, 코멘트 값이 있는 span 값을 바꾼다
								var cell = $("tr[idx='" + _currentIdx + "'] td:eq(1)");
								var commentVal = cell.find("span#commentCntVal");
								if (commentVal.length > 0) { // 이미 코멘트 정보를 가지고 이는 글이라면
									commentVal.text(commentVal.text() * 1 + 1); //코멘트 수 +1 하기
								} else {	//아직 코멘트 이미지와 수가 존재하지 않는 상황이라면!
									cell.append(Common.format(commentCountInfoTemplate, 1));
								}
								//모달 닫기
								$.modal.close();
							}
						});
					});

					//Ajax 에러 처리 핸들러 등록
					$("#errorInfo").ajaxError(function(info, obj) {
						var err;
						eval("err = " + obj.responseText);
						alert(err.Message);
						if (err.Message.indexOf("인증되지 않은") > -1) {
							location.href = "/";
						}
						$(info.target)
						.empty()
						.html(obj.responseText);
						$.modal.close();
					});
				});

				Forum.OutputList = function() {
					Common.showProgressBox("로딩중입니다...");
					$.ajax({
						url : "supBoard.do?method=s",
						type: "post",
						contentType: "application/x-www-form-urlencoded",
						data : {pageNo: _currentPage, recordSize: _recordPerPage},
						success : function(data) {
							var listData;
							$.each(data, function() {
								if (this.length > 0)	_totalItemCount = this[0].totalCount;
								$("#ForumList tbody").empty();
								var insertDate;
								$.each(this, function(index, obj) {
									//최신 글이면 new 이미지 처리
									insertDate = obj.insertDate.split(" ")[0];
									if (Forum.IsRecentData(obj.insertDate)) {
										insertDate += " <img src='/javascript/jquery/board/image/new.gif' />";
									}
									listData = Common.format(forumListRowTemplate,
									obj.idx,
									Common.escapeHTML(obj.subject),
									obj.userName,
									insertDate,
									obj.readCount,
									obj.commentCount,
									obj.depth,
									obj.deleted,
									obj.userId
									);
									
									$("#ForumList tbody").append(listData);
								});
	
								//답변 들여쓰기 및 코멘트 출력
								$("tr[idx]").each(function() {
									//각 목록에서 코멘트수가 0 이상이면 그를 표현낸다.
									var count = $(this).attr("commentCnt");
									if (count > 0) {
										$(this).find("td:eq(1)")
										.append(Common.format(commentCountInfoTemplate, count));
									}
	
									//답변 글이라면 들여쓰기 및 Re 이미지를 추가한다
									var depth = $(this).attr("depth");
									if (depth > 0) {
										$(this).find("td:eq(1)")
										.prepend(Common.format(forumReTemplate, depth * 7));
									}
	
									//답변이 있지만 삭제된 질문 글이라면 비활성 처리한다
									var isDeleted = $(this).attr("isDeleted");
									if (isDeleted == "1") {
										var temp = $(this).find("td:eq(1)").text();
										$(this).find("td:eq(1)")
										.empty()
										.append($("<strike style=\"color:silver\"></strike>").text(temp))
										.end()
										.css("color", "silver");
									}
								});
	
								//정상적인 목록의 하이퍼링크에 onclick 이벤트를 건다
								$("tr[isDeleted=0] a[idx]").click(function() {
									_currentIdx = $(this).attr("idx");
									
									$("#ForumList tr").css("background", "white");
									$(this).parents("tr[idx]").css("background", "khaki");
									Forum.OutputContent();
									Forum.OutputCommentList();
								});
	
								$("div#list").hide().slideDown('normal', function() {
									$.modal.close();
								});
	
								//페이저 출력
								Forum.OutputPager();
							});
						} //end success
					}); //end ajax
							
				};

				//본문 데이터 수신 및 출력
				Forum.OutputContent = function() {
					Common.showProgressBox("본문을 로드하는 중입니다...");
					$("#comment").val("");
					var currentUrl = location.protocol + "//" + location.host + location.pathname
					+ "?method=l&idx=" + _currentIdx;
					$("#directLink")
					.css("font-size", "11px")
					.css("font-family", "'맑은 고딕', 'verdana'")
					.html("이글의 직접 링크는 <a style='color:blue' href='" + currentUrl + "'>" + currentUrl + "</a> 입니다");
					$.ajax({
						url : "supBoard.do?method=r",
						type: "post",
						contentType: "application/x-www-form-urlencoded",
						data : {idx: _currentIdx, updateReadCount: true},
						success : function(data) {
							
							Forum.manipulateUIByAuth(data.userId);
							var contents = data.contents;
							if (data.UseHtml == "False")
								contents = Common.escapeHTML(contents);
							//UseHtml, UseAutoBR
							$("div#title").text(data.subject);
							_currentThread = data.thread * 1;
							_currentDepth = data.depth * 1;
							$("span#userName").text(data.userName);
							$("span#userName").attr("userId", data.userId);
							$("span#inputDate").text(data.insertDate);
							$("span#read").text(data.readCount);
							$("pre#text").html(contents
							.replace(/\r/g, "&nbsp;<br />") //IE
							.replace(/\n/g, "&nbsp;<br />") //FF
							.replace(/\s\s/g, " &nbsp;")
							.replace(/\t/g, " &nbsp; &nbsp;"));
							//클릭된 row의 조회수를 증가시킨다(화면 업데이트).
							var readCell = $("tr[idx=" + _currentIdx + "] td:last");
							readCell.text(readCell.text() * 1 + 1);
							//관련 첨부파일 목록을 가져온다.
							Forum.OutputFileList();
							$.modal.close();
							$("div#contents").hide().slideDown();
						}
					});
				}

				//사용자의 인증 여부에 따라, 글쓴이와 같은지에 따라 명령버튼을 숨김
				Forum.manipulateUIByAuth = function(userId) {
					//현재 사용자가 세션이 있다면, 글쓰기 및 답변하기를 보이고
					$("#authCommand").show();
					$("#formComment").show();
					//글쓴이와 동일하면, 수정/삭제버튼 및 파일 업로드를 보인다
					if ("<security:authentication property='principal.email' />".unescapeHtml() == userId) {
						$("#authorCommand").show();
						$("#fileUploadCell").show();
					} else {
						$("#authorCommand").hide();
						$("#fileUploadCell").hide();
					}
				}

				// 관련 코멘트 수신 및 출력
				Forum.OutputCommentList = function() {
					$("#CommentList tbody").empty();
					$.ajax({
						url : "supBoard.do?method=comment",
						type: "post",
						contentType: "application/x-www-form-urlencoded",
						data : {pIdx: _currentIdx},
						success : function(data) {
							if (data.length == 0)
								return;
							var commentData;
							$.each(data, function(index, obj) {
								commentData = Common.format(commentListRowTemplate,
								obj.idx,
								obj.userName,
								obj.comment
								.replace(/\r/g, "&nbsp;<br />")
								.replace(/\s\s/g, " &nbsp;")
								.replace(/\t/g, " &nbsp; &nbsp;")
								, obj.insertDate,
								obj.userId);
								$("#CommentList tbody").append(commentData);
							});

							//홀수 라인은 배경색을 다르게 한다.
							$("#CommentList tr:odd").css("background", "#F8F8F8");

							//자신이 쓴 코멘트에는 삭제링크를 보이게 한다.
							$("#CommentList td:last-child").each(function() {
								var row = $(this).parent();
								var userId = row.attr("userId");
								//글쓴이와 현재 사용자가 동일하다면
								
								if ("<security:authentication property='principal.email' />".unescapeHtml() == userId) {
									var idx = row.attr("idx");
									$("<img src='/javascript/jquery/board/image/commentDel.gif' />")
									.appendTo($(this).parent().find("td:last"))
									.click(function() {
										if (confirm("정말로 삭제하시겠습니까?"))
											Forum.DeleteComment(idx);
										else
											return;
									});
								}
							});

							//코멘트 제일 마지막으로 이동시킨다.
							self.location.href = "#endOfCommentList";
						}
					});
				}

				//글 삭제 메서드
				Forum.DeleteForumData = function() {
					$.ajax({
						url : "supBoard.do?method=d",
						type: "post",
						contentType: "application/x-www-form-urlencoded",
						data : {idx: _currentIdx, thread: _currentThread},
						success : function(data) {
							$("div#contents").slideUp();
							Forum.OutputList();
						}
					});
				}

				//코멘트 삭제 메서드
				Forum.DeleteComment = function(idx) {
					$.ajax({
						url : "supBoard.do?method=commentDelete",
						type: "post",
						contentType: "application/x-www-form-urlencoded",
						data : {pIdx: _currentIdx, idx: idx},
						success : function(data) {
							//포럼 코멘트 목록 재출력
							Forum.OutputCommentList();
							//현재 목록의 제목 TD를 찾아가서, 코멘트 값이 있는 span 값을 바꾼다
							var cell = $("tr[idx='" + _currentIdx + "'] td:eq(1)");
							var commentVal = cell.find("span#commentCntVal");
							commentVal.text(commentVal.text() - 1); //코멘트 수 -1 하기
							//만일, 코멘트 수가 0인 상태라면, 코멘트 이미지와 값을 아예 제거한다
							if (commentVal.text() * 1 == 0) {
								cell.children("#commentInfo").remove();
							}
						}
					});
				}

				//첨부파일 목록 출력
				Forum.OutputFileList = function() {
					$("#fileList").empty();
					$.ajax({
						url : "supBoard.do?method=fileList",
						type: "post",
						contentType: "application/x-www-form-urlencoded",
						data : {idx: _currentIdx},
						success : function(data) {
							
//							if (data.d.length == 0 && $.cookie("userID") == $("span#userName").text()) {
//								$("#fileUploadRow").show();
//								return;
//							}
//							if (data.length == 0) {
//								$("#fileUploadRow").hide();
//								return;
//							}
//							$("#fileUploadRow").show();
							var file;

							$.each(data, function(index, obj) {
								file = $(Common.format(fileListTemplate, obj.idx, obj.fileName, obj.fileSize, obj.svrFileName));
								
								if ("<security:authentication property='principal.email' />".unescapeHtml() == $("span#userName").attr("userId")) {
									$("<img src='/javascript/jquery/board/image/commentDel.gif' />").click(function() {
										if (confirm("정말로 삭제하시겠습니까?"))
											Forum.DeleteFile(obj);
										else
											return;
									}).prependTo(file);
								}
								file.appendTo($("#fileList"));
							});
							if (data.length > 0)	$("#fileList").prepend($("<b style='color:brown'>첨부 파일 목록</b><p>"));
						}
					});
				}

				//첨부파일 제거

				Forum.DeleteFile = function(file) {
					$.ajax({
						url : "supBoard.do?method=fileDelete",
						type: "post",
						contentType: "application/x-www-form-urlencoded",
						data : {idx: file.idx, svrFileName: file.svrFileName},
						success : function(data) {
							Forum.OutputFileList();
						}
					});
				}

				//페이저 출력부
				Forum.OutputPager = function() {
					_pageCount = Math.ceil(_totalItemCount / _recordPerPage);
					var pageLink;
					$("#pager").empty();
					if (iLoopEnd > _pageCount)
						iLoopEnd = _pageCount;
					for ( var page = iLoop; page <= iLoopEnd; page++) {
						pageLink = $("<a> " + page + " </a>")
						.addClass("link")
						.click(function() { //페이지 번호를 클릭하는 경우의 처리
							_currentPage = parseInt($(this).text());
							$("#pager a").removeClass("pageLinkSelected");
							$(this).addClass("pageLinkSelected");
							$("div#contents").slideUp();
							Forum.OutputList(); //리스트 재출력
						});

						//현재 페이지만 스타일을 다르게 한다
						if (page == _currentPage)
							pageLink.addClass("pageLinkSelected");
						$("#pager").append(pageLink);
					}

					//이전 10 페이지 관련 처리
					if (_currentPage > 10) {
						$("#pagePrev10")
						.attr("src", "/javascript/jquery/board/image/Prev10_A.gif")
						.addClass("link")
						.click(Forum.GoPrevPage);
					} else {
						$("#pagePrev10").attr("src", "/javascript/jquery/board/image/Prev10_B.gif").removeClass("link");
						$("#pagePrev10").unbind("click", Forum.GoPrevPage);
					}

					//다음 10 페이지 관련 처리
					if (_pageCount > iLoopEnd) {
						$("#pageNext10")
						.attr("src", "/javascript/jquery/board/image/Next10_A.gif")
						.addClass("link")
						.click(Forum.GoNextPage);
					} else {
						$("#pageNext10").attr("src", "/javascript/jquery/board/image/Next10_B.gif").removeClass("link");
						$("#pageNext10").unbind("click", Forum.GoNextPage);
					}
				}

				Forum.GoNextPage = function() {
					iLoop += 10;
					iLoopEnd += 10;
					if (iLoopEnd > _pageCount)
						iLoopEnd = _pageCount;
					_currentPage = iLoop;
					$("div#contents").slideUp();
					Forum.OutputList(); //리스트 재출력
				}

				Forum.GoPrevPage = function() {
					iLoop -= 10;
					iLoopEnd -= 10;

					iLoopEnd = Math.ceil(iLoopEnd / 10) * 10; //최종구역이 아니라면, 페이지 end 수를 10의 배수로 맞춘다
					if (iLoop < 1)
						iLoopEnd = 1;
					if (iLoopEnd < 10)
						iLoopEnd = 10;
					_currentPage = iLoop;
					$("div#contents").slideUp();
					Forum.OutputList(); //리스트 재출력
				}

				//주어진 시간문자열이 최신글인지를 판별하는 함수
				Forum.IsRecentData = function(d) { //d는 2008-4-12 20:23:40 과 같은 포맷이어야 함
					var boolRecent = false;
					var dTemp = d.split(" ");
					if (dTemp.length < 2)
						return;
					var date = dTemp[0].split("-");
					var time = dTemp[1].split(":");
					var cDate = new Date(date[0], date[1] - 1, date[2], time[0], time[1], time[2]);
					var hoursApart = Math.abs(Math.round((new Date() - cDate) / 3600000));
					if (hoursApart < 24) // 24시간 이내에 올라온 글이 최신글 ㅎㅎ
						boolRecent = true;
					//1000* 60 * 60 / 3600000
					return boolRecent;
				}
			</script> <!-- 포럼 본문 //-->
			<div id="contents" style="display:none">
				<div style="width:680px; font-size:14px; text-align:left; font-family:'맑은 고딕', verdana;">
					<b>본문</b>
				</div>
				<br />
				<table id="t2" cellspacing="0" cellpadding="4" style="background-color:#efefef;width:680px;">
					<tr>
						<td class="siteBar"><img style="float:left;" src="/javascript/jquery/board/image/forumHeaderLeftEdge.png" />
							<div style="float:left; padding: 8px 0px 0px 5px;font-weight:bold" id="title"></div> 
							<img style="float:right;" src="/javascript/jquery/board/image/forumHeaderRightEdge.png" />
						</td>
					</tr>
					<tr>
						<td style="background:white">
							<span style="float:left">작성자 : <span id="userName"></span></span> 
							<span style="float:right">작성일 : <span id="inputDate"></span>, 조회 : <span id="read"></span></span>
						</td>
					</tr>
					<tr>
						<td align="left" style="background:#FAFAFA;border:solid 1px silver; height:30px;padding:7px"><span id="directLink" style="float:right"></span><br /> <pre id="text"></pre></td>
					</tr>
					<tr id="fileUploadRow">
						<td style="background:white;border:solid 1px silver;border-top:solid 1px white">
							<table width="100%">
								<tr>
									<td id="fileUploadCell" style="width:380px;vertical-align:top">
										<div id="uploadify"></div>
									</td>
									<td id="fileList"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right" style="border-bottom:solid 1px #dddddd">
							<span id="authorCommand" style="display:none"> <img id="edit" src="/javascript/jquery/board/image/forumEdit.gif" class="link" />
								<img id="del" src="/javascript/jquery/board/image/forumDelete.gif" class="link" />
							</span>
							<span id="authCommand" style="display:none">
								<img id="reply" src="/javascript/jquery/board/image/forumReply.gif" class="link" />
								<a id="write" href="supBoard.do?method=c">
									<img src="/javascript/jquery/board/image/forumInsert.gif" class="link" />
								</a>
							</span>
							<img src="/javascript/jquery/board/image/forumList.gif" class="toList" />
						</td>
					</tr>
				</table>
				<!-- 코멘트 입력부 -->
				<div id="formComment">
					<table cellspacing="0" cellpadding="6" style="border-bottom:solid 1px silver; width:680px; height:100px; background:gray">
						<tr style="background:#F2F2F2">
							<td style="width:580px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="/javascript/jquery/board/image/ForumComment.gif" style="vertical-align:middle" /> &nbsp;&nbsp;<font color="gray">[1000자 이내]</font><br />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <textarea name="comment" rows="2" cols="80" id="comment" wrap="hard" style="border:solid 1px silver;height:60px;width:520px;"></textarea></td>
							<td style="width:100px"><img id="addComment" src="/javascript/jquery/board/image/forumAddComment.gif" /></td>
						</tr>
					</table>
				</div>
				<!-- 코멘트 출력부 -->
				<table id="CommentList" cellspacing="0" cellpadding="5" style="border-bottom:solid 1px silver; width:680px; background:gray">
					<tbody></tbody>
				</table>
				<a name="#endOfCommentList"></a> <br />
			</div> <!-- 포럼 목록 출력부 -->
			<div style="width:680px; font-size:14px; text-align:left; font-family:'맑은 고딕', verdana;">
				<b>목록</b>
			</div>
			<br />
			<div id="list">
				<table id="ForumList" cellspacing="1" cellpadding="4" style="border:solid 1px silver; width:680px">
					<thead>
						<tr>
							<th class="siteBar" style="width:50px;"><img style="float:left;" src="/javascript/jquery/board/image/forumHeaderLeftEdge.png" />
								<div style="float:left; padding: 8px 0px 0px 5px;">번호</div> <img style="float:right;" src="/javascript/jquery/board/image/forumHeaderRightEdge.png" /></th>
							<th class="siteBar" style="width:390px;"><img style="float:left;" src="/javascript/jquery/board/image/forumHeaderLeftEdge.png" />
								<div style="float:left; padding: 8px 0px 0px 5px;">제목</div> <img style="float:right;" src="/javascript/jquery/board/image/forumHeaderRightEdge.png" /></th>
							<th class="siteBar" style="width:80px;"><img style="float:left;" src="/javascript/jquery/board/image/forumHeaderLeftEdge.png" />
								<div style="float:left; padding: 8px 0px 0px 25px;">작성자</div> <img style="float:right;" src="/javascript/jquery/board/image/forumHeaderRightEdge.png" /></th>
							<th class="siteBar" style="width:100px;"><img style="float:left;" src="/javascript/jquery/board/image/forumHeaderLeftEdge.png" />
								<div style="float:left; padding: 8px 0px 0px 25px;">작성일</div> <img style="float:right;" src="/javascript/jquery/board/image/forumHeaderRightEdge.png" /></th>
							<th class="siteBar" style="width:60px;"><img style="float:right;" src="/javascript/jquery/board/image/forumHeaderRightEdge.png" />
								<div style="float:right; padding: 8px 10px 0px 5px;">조회</div></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div> <!-- 명령 버튼  -->
			<table id="command" cellspacing="0" width="680px" style="margin-top:5px">
				<tr>
					<td style="padding-left:10px"><img id="pagePrev10" src="/javascript/jquery/board/image/Prev10_B.gif" /> <span id="pager"></span> <img id="pageNext10" src="/javascript/jquery/board/image/Next10_B.gif" /></td>
					<td align="right" style="height:22px"><a id="write2" href="supBoard.do?method=c"><img src="/javascript/jquery/board/image/forumInsert.gif" alt="작성하기" class="link" />
					</a></td>
				</tr>
			</table>
			<table id="Table2" cellspacing="0" width="680px">
				<tr>
					<td align="left">
						<div id="errorInfo" style="table-layout:fixed;width:650px; color:Red"></div>
					</td>
				</tr>
			</table></td>
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
