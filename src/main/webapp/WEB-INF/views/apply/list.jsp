<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<br>
<br>
<title>펀딩 목록</title>
<!-- 펀딩 list.jsp 목록 -->
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}
</style>
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}
</style>
</head>
<body>
	<div class="container">
		<section id="container">
			<form role="form" method="get">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>카테고리</th>
							<th>이름</th>
							<th>작성자</th>
							<th>등록날짜</th>
						</tr>
					</thead>

					<c:forEach items="${list}" var="list">
						<tr>
							<td><c:out value="${list.fcate}" /></td>
							<td><a href="readView?fid=${list.fid}"><c:out
										value="${list.fname}" /></a></td>
							<td><c:out value="${list.writer}" /></td>
							<td><c:out value="${list.fdate}" /></td>
						</tr>
					</c:forEach>
				</table>

				<div class="search row">
					<div class="col-xs-2 col-sm-2">
						<select name="searchType" class="form-control">
							<option value="c"
								<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>카테고리</option>
							<option value="n"
								<c:out value="${scri.searchType eq 'n' ? 'selected' : ''}"/>>이름</option>
						</select>
					</div>

					<div class="col-xs-10 col-sm-10">
						<div class="input-group">
							<input type="text" name="keyword" id="keywordInput"
								value="${scri.keyword}" class="form-control" /> <span
								class="input-group-btn">
								<button id="searchBtn" type="button" class="btn btn-primary">검색</button>
							</span>
						</div>
					</div>

					<div class="mb-3" style="margin: 0 auto; width: 30%;">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
								<li><a
									href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}" var="idx">
								<li
									<c:out value="${pageMaker.cri.page == idx ? 'class=info' : ''}" />>
									<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a
									href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
							</c:if>
						</ul>
					</div>

					<script>
						$(function() {
							$('#searchBtn')
									.click(
											function() {
												self.location = "list"
														+ '${pageMaker.makeQuery(1)}'
														+ "&searchType="
														+ $(
																"select option:selected")
																.val()
														+ "&keyword="
														+ encodeURIComponent($(
																'#keywordInput')
																.val());
											});
						});
					</script>
				</div>
			</form>
		</section>
	</div>
</body>
</html>