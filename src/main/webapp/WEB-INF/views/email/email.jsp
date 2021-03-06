<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<meta charset="UTF-8">
<title>이메일 인증</title>
<!-- 이메일 이메일.jsp -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>
<script type="text/javascript">
	if(${member.mid==null}){
		alert('로그인 후 이용하시기 바랍니다.');
		location.href="../member/login";
	}
</script>
<style>
table {
	width: 50%;
	margin-left: auto;
	margin-right: auto;
}

.correct {
	color: green;
}

.incorrect {
	color: red;
}
</style>
<body>
	<table>
		<tbody>
			<tr>
				<td>
					<div class="mail_wrap">
						<br>
						<div class="mail_name">이메일</div>
						<input class="form-control" name="memberMail"><br>

						<div class="mail_check_wrap">
							인증번호 입력란
							<div class="mail_check_input_box" id="mail_check_input_box_false">
								<input class="mail_check_input" disabled="disabled"
									style="width: 100%; height: 30px;">
							</div>

							<div class="clearfix"></div>
							<span id="mail_check_input_box_warn"></span> <br>
						</div>
					</div>

				</td>
			</tr>
			<tr>
				<td><br>
					<button class="mail_check_button btn btn-success" id="sendbutton">인증번호
						전송</button>
					<button class="write_button btn btn-success" disabled="disabled"
						id="applywritebutton" onclick="location.href='../apply/writeView'"
						style="float: right;">펀딩신청</button> <br></td>
			</tr>
		</tbody>
	</table>


	<script>
		var code = ""; //이메일전송 인증번호 저장위한 코드

		/* 인증번호 이메일 전송 */
		$(".mail_check_button").click(function() {

			var email = $(".form-control").val(); // 입력한 이메일
			var checkBox = $(".mail_check_input"); // 인증번호 입력란
			var boxWrap = $(".mail_check_input_box"); // 인증번호 입력란 박스

			$.ajax({

				type : "GET",
				url : "mailCheck?email=" + email,
				success : function(data) {

					//console.log("data : " + data);
					checkBox.attr("disabled", false);
					boxWrap.attr("id", "mail_check_input_box_true");
					code = data;
				}

			});

		});

		/* 인증번호 비교 */
		$(".mail_check_input").blur(function() {

			var inputCode = $(".mail_check_input").val(); // 입력코드    
			var checkResult = $("#mail_check_input_box_warn"); // 비교 결과     

			if (inputCode == code) { // 일치할 경우
				checkResult.html("인증번호가 일치합니다.");
				checkResult.attr("class", "correct");

				document.getElementById("applywritebutton").disabled = false;

			} else { // 일치하지 않을 경우
				checkResult.html("인증번호를 다시 확인해주세요.");
				checkResult.attr("class", "incorrect");

				document.getElementById("applywritebutton").disabled = true;
			}

		});
	</script>
</body>
</html>