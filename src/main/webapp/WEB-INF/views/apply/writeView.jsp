<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>펀딩 신청</title>
<!-- 펀딩 writeView.jsp -->
</head>
<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[name='writeForm']");
		$(".write_btn").on("click", function() {
			var fname = $("#fname").val();
			var fprice = $("#fprice").val();
			var fgoal = $("#fgoal").val();
			var fdate = $("#fdate").val();
			var fstartdate = $("#fstartdate").val();
			var fenddate = $("#fenddate").val();

			if (fname == "") {
				alert("펀딩 제품 이름을 입력하세요");
				$("#fname").focus();

				return false;
			}
			if (fprice == "") {
				alert("펀딩 가격을 입력하세요");
				$("#fprice").focus();

				return false;
			}
			if (fgoal == "") {
				alert("펀딩 목표 가격을 입력하세요");
				$("#fgoal").focus();

				return false;
			}
			if (fdate == "") {
				alert("펀딩 등록 날짜를 입력하세요");
				$("#fdate").focus();

				return false;
			}
			if (fstartdate == "") {
				alert("펀딩 시작 날짜를 입력하세요");
				$("#fstartdate").focus();

				return false;
			}
			if (fenddate == "") {
				alert("펀딩 종료 날짜를 입력하세요");
				$("#fenddate").focus();

				return false;
			}
			if (fn_valiChk()) {
				return false;
			}
			formObj.attr("action", "write");
			formObj.attr("method", "post");
			formObj.submit();
		});
		fn_addFile();
	})
	function fn_valiChk() {
		var regForm = $("form[name='writeForm'] .chk").length;
		for (var i = 0; i < regForm; i++) {
			if ($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null) {
				alert($(".chk").eq(i).attr("fcate"));
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
													+ "<button type='button' class='delete_btn btn btn-danger' style='float:right;' id='fileDelBtn'>"
													+ "삭제"
													+ "</button><br><br></div>");
						});
		$(document).on("click", "#fileDelBtn", function() {
			$(this).parent().remove();

		});
	}
	$(function() {
		$("#fdate").datepicker(
				{
					changeMonth : true,
					changeYear : true,
					minDate : '-50y',
					nextText : '다음 달',
					prevText : '이전 달',
					yearRange : 'c-50:c+20',
					showButtonPanel : true,
					currentText : '오늘 날짜',
					closeText : '닫기',
					dateFormat : "yy-mm-dd",
					showAnim : "slide",
					showMonthAfterYear : true,
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ]
				});
	});
	$(function() {
		$("#fstartdate").datepicker(
				{
					changeMonth : true,
					changeYear : true,
					minDate : '-50y',
					nextText : '다음 달',
					prevText : '이전 달',
					yearRange : 'c-50:c+20',
					showButtonPanel : true,
					currentText : '오늘 날짜',
					closeText : '닫기',
					dateFormat : "yy-mm-dd",
					showAnim : "slide",
					showMonthAfterYear : true,
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ]
				});
	});
	$(function() {
		$("#fenddate").datepicker(
				{
					changeMonth : true,
					changeYear : true,
					minDate : '-50y',
					nextText : '다음 달',
					prevText : '이전 달',
					yearRange : 'c-50:c+20',
					showButtonPanel : true,
					currentText : '오늘 날짜',
					closeText : '닫기',
					dateFormat : "yy-mm-dd",
					showAnim : "slide",
					showMonthAfterYear : true,
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ]
				});
	});
</script>
<style>
table {
	width: 60%;
	margin-left: auto;
	margin-right: auto;
}

div.greet {
	font-size: 30px;
	font-weight: 800;
}

div.write {
	font-size: 20px;
	font-weight: 650;
}

div.cate {
	font-size: 15px;
	font-weight: 150;
}

div.des {
	color: #BDBDBD;
}
</style>
<body>
	<br>
	<br>
	<section id="container">
		<form name="writeForm" method="post" action="write"
			enctype="multipart/form-data">
			<table>
				<tbody>
					<tr>
						<td><br>
							<div class="greet">
								메이커님, 환영합니다!<br> <br>
							</div>
							<div class="write">
								가벼운 마음으로 메이커님의 정보를 입력해 보세요.☺<br> <br>
							</div></td>
					</tr>

					<tr>
						<td>
							<div class="cate">
								<label for="fcate">카테고리*<br></label>
								<div class="des">서포터들이 관심을 가질만한 카테고리를 1개만 선택하세요</div>

								<select id="fcate" name="fcate" size="1" class="form-control">
									<option value="테크 · 가전">테크 · 가전</option>
									<option value="패션 · 잡화">패션 · 잡화</option>
									<option value="뷰티">뷰티</option>
									<option value="푸드">푸드</option>
									<option value="홈 · 리빙">홈 · 리빙</option>
									<option value="여행 · 레저">여행 · 레저</option>
									<option value="스포츠 · 모빌리티">스포츠 · 모빌리티</option>
									<option value="캐릭터 · 굿즈">캐릭터 · 굿즈</option>
									<option value="게임 · 취미">게임 · 취미</option>
								</select><br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="c">
								<label for="fname">펀딩 제품 이름*</label><input type="text"
									id="fname" name="fname" class="form-control"
									title="펀딩제품 이름을 입력하세요." /><br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="c">
								<label for="fprice">펀딩 가격*</label><br>
								<div class="des">원하시는 펀딩 가격을 입력해주세요</div>
								<input type="number" id="fprice" name="fprice"
									class="form-control" /><br>

							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="c">
								<label for="fgoal">펀딩 목표 가격*</label><br> <input type="number"
									id="fgoal" name="fgoal" class="form-control" /><br>
							</div>
						</td>
					</tr>
					<tr>
						<td><label for="fstartdate">펀딩 시작 날짜*</label><br> <input
							type="text" id="fstartdate" name="fstartdate"
							class="form-control" /><br></td>
					</tr>

					<tr>
						<td><label for="fenddate">펀딩 종료 날짜*</label><br> <input
							type="text" id="fenddate" name="fenddate" class="form-control" /><br></td>
					</tr>

					<tr>
						<td>
							<div class="c">
								<label for="fdes">제품 상세 설명</label><br>
								<textarea id="fdes" name="fdes" class="form-control" rows="10"
									title="내용을 입력하세요."></textarea>

								<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="mb-3">
								<label for="writer">작성자</label><input type="text" id="writer"
									name="writer" class="form-control" title="작성자를 입력하세요."
									value="${member.mid}" readonly="readonly" /><br>
							</div>
						</td>
					</tr>
					<tr>
						<td id="fileIndex"></td>
					</tr>
					<tr>
						<td>
							<div class="c">
								<br> <input type="checkbox" name="agreement" value="1"><label>&nbsp;(선택)
									개인 정보 수집 동의 </label><br> <br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<button class="fileAdd_btn btn btn-secondary" type="button">파일추가</button>
							<br>
						<br>
							<button class="write_btn" type="submit" id="write_btn"
								style="background-color: #58FAF4; color: white; border: 0; width: 250px; height: 35px; font-size: 40;">작성</button>

						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</section>
</body>
</html>