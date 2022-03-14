<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<title>게시판</title>
</head>
<script type="text/javascript">
	$(document).ready(
			function() {
				var formObj = $("form[name='updateForm']");

				$(document).on("click", "#fileDel", function() {
					$(this).parent().remove();
				})

				fn_addFile();

				$(".cancel_btn").on(
						"click",
						function() {
							event.preventDefault();
							location.href = "/board/readView?bno=${update.bno}"
									+ "&page=${scri.page}"
									+ "&perPageNum=${scri.perPageNum}"
									+ "&searchType=${scri.searchType}"
									+ "&keyword=${scri.keyword}";
						})

				$(".update_btn").on("click", function() {
					if (fn_valiChk()) {
						return false;
					}
					formObj.attr("action", "/board/update");
					formObj.attr("method", "post");
					formObj.submit();
				})
			})

	function fn_valiChk() {
		var updateForm = $("form[name='updateForm'] .chk").length;
		for (var i = 0; i < updateForm; i++) {
			if ($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null) {
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
	}
	function fn_addFile() {
		var fileIndex = 1;
		//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
		$(".fileAdd_btn")
				.on(
						"click",
						function() {
							$("#fileIndex")
									.append(
											"<div><input type='file' style='float:left;' name='file_"
													+ (fileIndex++)
													+ "'>"
													+ "</button>"
													+ "<button type='button' style='float:right;' id='fileDelBtn'>"
													+ "삭제" + "</button></div>");
						});
		$(document).on("click", "#fileDelBtn", function() {
			$(this).parent().remove();

		});
	}
</script>
<style>
table {
	width: 60%;
	margin-left: auto;
	margin-right: auto;
}
</style>

<body>

	<div id="root">
		<section id="container">
			<form name="updateForm" role="form" method="post"
				action="/board/update" enctype="multipart/form-data">
				<input type="hidden" name="bno" value="${update.bno}"
					readonly="readonly" /> <input type="hidden" id="page" name="page"
					value="${scri.page}"> <input type="hidden" id="perPageNum"
					name="perPageNum" value="${scri.perPageNum}"> <input
					type="hidden" id="searchType" name="searchType"
					value="${scri.searchType}"> <input type="hidden"
					id="keyword" name="keyword" value="${scri.keyword}">
				<table>
					<tbody>
						<tr>
							<td>
								<div class="mb-3">
									<label for="title">제목</label><input type="text" id="title"
										name="title" value="${update.title}" class="form-control"
										title="제목을 입력하세요." />
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="mb-3">
									<label for="content">내용</label>
									<textarea id="content" name="content" class="form-control"
										rows="10" title="내용을 입력하세요."><c:out
											value="${update.content}" /></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="mb-3">
									<label for="writer">작성자</label><input type="text" id="writer"
										name="writer" class="form-control" value="${update.writer}"
										readonly="readonly" />
								</div>
							</td>
						</tr>
						<tr>
							<td><label for="regdate">작성날짜</label> <fmt:formatDate
									value="${update.regdate}" pattern="yyyy-MM-dd" /></td>
							<br>
						</tr>
						<tr>
							<td>
								<button type="button" class="btn btn-success update_btn">저장</button>
								<button type="button" class="btn btn-primary cancel_btn">취소</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</section>
		<hr />
	</div>
</body>
</html>