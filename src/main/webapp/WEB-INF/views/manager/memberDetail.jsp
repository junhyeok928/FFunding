<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/manager/memberDetail.css" rel="stylesheet">  
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
	<!-- Begin Page Content -->
	<div class="container-fluid">
	
	   <!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Member Information</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
		           <!-- Page Heading -->
					<div class="textmark">
						<h1 class="h3 mb-0 text-gray-800">Modify Profile</h1>
					</div>
					<div class="modify">
						<form id="frm" method="post">
							<input type="hidden" name="adminck" value="0"/>
							<table class="modifytb">
								<tr>
									<th>ID</th>
									<td><input type="text" name="mid" value="${detail.mid}" readonly/></td>	 
								</tr>                           	
								<tr>
									<th>New Password</th>
									<td>
										<input type="hidden" name="mpw" value="${detail.mpw}"/>
										<input type="password" name="newpw" value="" autoComplete="off"/>
										<span class="warning" id="pwtext"></span>
									</td>	 
								</tr>                           	
								<tr>
									<th>New Password Verification</th>
									<td>
										<input type="password" name="newpwck" value="" autoComplete="off"/>
										<span class="warning" id="pctext"></span>
									</td>
								</tr>                           	
								<tr>
									<th>Name</th>
									<td>
										<input type="text" name="mname" value="${detail.mname}"/>
										<span class="warning" id="ntext">Please enter your name and check the space.</span>
									</td>	 
								</tr>                           	
								<tr>
									<th>Phone</th>
									<td>
										<input type="text" name="phone1" value="" class="phone1"/> - 
										<input type="text" name="phone2" value="" class="phone2"/> - 
										<input type="text" name="phone3" value="" class="phone3"/>
										<input type="hidden" name="mphone" value="${detail.mphone}"/>
										<span class="warning" id="phtext">Please enter your mobile number and check the space.</span>
									</td>		 
								</tr>                           	
								<tr>
									<th>Email</th>
									<td>
										<input type="text" name="email1" value="" class="email1"/> @ 
										<input type="text" name="email2" value="" class="email2"/>
										<input type="hidden" name="memail" value="${detail.memail}"/>
										<p class="warningp" id="etext">Please fill in the form of an email and check the space.</p>
									</td>		 
								</tr>                           	
								<tr>
									<th>Address</th>
									<td>
										<input type="text" name="maddress" id="address" value="${detail.maddress}" class="address1" placeholder="????????????" readonly/><br/>
										<input type="text" name="maddress_detail" value="${detail.maddress_detail}" class="address" placeholder="????????????"/>
									</td>		 
								</tr>                           	
								<tr>
									<th>Point</th>
									<td>
										<input type="number" name="point" value="${detail.point}" class="point" onkeyup="comm(this)"/>
										<p class="num"><fmt:formatNumber value="${detail.point}" pattern="#,###"/></p>
										<span class="warning" id="potext">Please enter the point.</span>
									</td>	 
								</tr>                           	
								<tr>
									<th>Division</th>
									<td class="division">
										<label for="general">?????????</label>
										<input type="radio" name="sellerck" id="general" value="0" ${detail.sellerck eq '0'.charAt(0)?'checked':''}/>
										<label for="seller">?????????</label>
										<input type="radio" name="sellerck" id="seller" value="1" ${detail.sellerck eq '1'.charAt(0)?'checked':''}/>
										<c:if test="${detail.naverid!='' || detail.googleid!='' || detail.kakaoid!=''}">
											<input type="hidden" name="sellerck" value="${detail.sellerck}"/>
										</c:if>
									</td>	 
								</tr>                           	
		                    </table>
						</form>
		              	<div class="buttons">
		               		<button id="uptBtn" class="btn btn-secondary btn-sm">??????</button>
		               		<button id="backBtn" class="btn btn-primary btn-sm">??????</button>
		              	</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->
	
	<!-- Modal-->
	<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
		    	<div class="modal-body">
		 			<div class="modal-title" id="exampleModalLongTitle"><span id="modalText" class="fontsz"></span></div>
				</div>
				<div class="modal-footer" id="modal-footer">
		   	    	<button type="button" class="fontsz btn btn-primary btn-sm" id="move">Go ListPage</button>
		    		<button type="button" class="fontsz btn btn-secondary btn-sm" id="close" data-dismiss="modal">Go CurrentPage</button>
		    	</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	//????????? ??????
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	//input????????? ????????? point ????????? ??????
	function comm(obj) {
		$(".num").text(comma(obj.value));
	}

	$(document).ready(function() {
		//?????? ????????? ??????
		if("${detail.naverid}"!="" || "${detail.googleid}"!="" || "${detail.kakaoid}"!="") {
			//???????????? ?????? ??????
			$("[name=newpw]").attr("disabled", true);
			$("[name=newpwck]").attr("disabled", true);
			//???????????? ??????
			$("input[type=radio]").attr("disabled", true);
		}
		
		
		//?????????????????? ?????????, ????????? ?????????
		let msg = "${param.msg}";
		if(msg!=null && msg!="") {
			$("#Modal").modal("show");
			$("#modalText").text(msg);
			$("#move").click(function(){
				location.href="/ffunding/manager/member";
			});
		}
		
		//??????????????? 3????????? ????????? ??????
		let phone = "${detail.mphone}";
		$("[name=phone1]").val(phone.substr(0,3));
		$("[name=phone2]").val(phone.substr(3,4));
		$("[name=phone3]").val(phone.substr(7,4));
		
		//????????? 2????????? ????????? ??????
		let email = "${detail.memail}";
		email = email.split("@");
		$("[name=email1]").val(email[0]);
		$("[name=email2]").val(email[1]);
	
		let noSpace = function(obj) {             
	      	var space = /\s/;
	        if(space.exec(obj.value)) {
	            obj = obj.replace(' ','');
	        }
	      }
		
		//??????????????? ????????? ????????????
		let open = function() {
			$("#pwtext").hide();
			$("#pctext").hide();
			$("#ntext").hide();
			$("#phtext").hide();
			$("#etext").hide();
			$("#potext").hide();
		}
		//???????????? ???????????? ??????
		open();
		
		//?????????????????? ???????????????
		let memberCk = function() {
			const mailck = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			const spaceck = /\s/;
			const pwck = /^[a-zA-Z0-9]{8,16}$/;
			
			if($("[name=mname]").val()==null || !($("[name=mname]").val()) || spaceck.exec($("[name=mname]").val())) {
				open();
				$("#ntext").show();
				$("[name=mname]").focus();
				return false;
			}
			if($("[name=phone1]").val()!=null && $("[name=phone1]").val()!="" || $("[name=phone2]").val()!=null && $("[name=phone2]").val()!="" || $("[name=phone3]").val()!=null && $("[name=phone3]").val()!="") {
				if(!($.isNumeric($("[name=phone1]").val())) || spaceck.exec($("[name=phone1]").val()) || $("[name=phone1]").val().length!=3) {
					open();
					$("#phtext").show();
					$("[name=phone1]").focus();
					return false;
				} else if(!($.isNumeric($("[name=phone2]").val())) || spaceck.exec($("[name=phone2]").val()) || $("[name=phone2]").val().length<3 || $("[name=phone2]").val().length>4) {
					open();
					$("#phtext").show();
					$("[name=phone2]").focus();
					return false;
				} else if(!($.isNumeric($("[name=phone3]").val())) || spaceck.exec($("[name=phone3]").val()) || $("[name=phone3]").val().length!=4) {
					open();
					$("#phtext").show();
					$("[name=phone3]").focus();
					return false;
				}
			} 
			if($("[name=email1]").val()!=null && $("[name=email1]").val()!="" || $("[name=email2]").val()!=null && $("[name=email2]").val()!="") {
				if(spaceck.exec($("[name=email1]").val())) {
					open();
					$("#etext").show();
					$("[name=email1]").focus();
					return false;
				} else if(!(mailck.test($("[name=email1]").val()+"@"+$("[name=email2]").val()))) {
					open();
					$("#etext").show();
					$("[name=email2]").focus();
					return false;
				}
			}
			if($("[name=point]").val()==null || !($("[name=point]").val()) || $("[name=point]").val()<0) {
				open();
				$("#potext").show();
				$("[name=point]").val("${detail.point}");
				$("[name=mname]").focus();
				return false;
			}
			//?????????????????? ???????????? ????????? ??????
			if($("[name=newpw]").val()!=null && $("[name=newpw]").val()!="") {
				//??????????????? ????????? ?????? ???????????????.
				if(spaceck.exec($("[name=newpw]").val())) {
					open();
					$("#pwtext").text("No spaces allowed.").show();
					$("[name=newpw]").focus();
					return false;
				//??????????????? 8-16??????????????????.
				} else if(!(pwck.test($("[name=newpw]").val()))) {
					open();
					$("#pwtext").text("Please enter 8-16 characters.").show();
					$("[name=newpw]").focus();
					return false;
				//?????????????????????????????? ???????????? ????????? ??????.
				} else if($("[name=newpwck]").val()==null || !($("[name=newpwck]").val())) {
					open();
					$("#pctext").text("Please enter the New Password Verification.").show();
					$("[name=newpwck]").focus();
					return false;
				//?????????????????? ??????????????????????????? ???????????? ??????????????????.
				} else if($("[name=newpw]").val()!=$("[name=newpwck]").val()) {
					open();
					$("#pctext").text("New Password and New Password verification do not match.").show();
					$("[name=newpwck]").focus();
					return false;
				}
			}
			open();
			return true;
		}
			
		$("#uptBtn").click(function() {
			let ck = memberCk();
			if(ck) {
				//????????? ???????????? ??????????????? ?????????
				if($("[name=phone1]").val()==null || $("[name=phone1]").val()=="" && $("[name=phone2]").val()==null || $("[name=phone2]").val()=="" && $("[name=phone3]").val()==null || $("[name=phone3]").val()=="") {
					$("[name=mphone]").val("");
				} else {
					$("[name=mphone]").val($("[name=phone1]").val()+$("[name=phone2]").val()+$("[name=phone3]").val());
				}
				//????????? ???????????? ????????? ?????????
				if($("[name=email1]").val()==null || $("[name=email1]").val()=="" && $("[name=email2]").val()==null || $("[name=email2]").val()=="") {
					$("[name=memail]").val("");
				} else {
					$("[name=memail]").val($("[name=email1]").val()+"@"+$("[name=email2]").val());
				}
				
				$("#frm").attr("action", "/ffunding/manager/member/detail/update");
				$("#frm").submit();
			}
		});
		
		//?????? ?????? ?????????, ??????????????? ???????????? ??????
		$("#backBtn").click(function() {
			location.href="/ffunding/manager/member";
		});
		
		//???????????? ????????? ?????? ??????api ??????
		$("#address").click(function() {
			new daum.Postcode({
	            oncomplete: function(data) {
	            	//????????? ?????? ???????????? ??????
	            	$("[name=maddress]").val(data.address);
	            	//???????????? ?????? ??? ??????????????? ????????? ??????
	            	$("[name=maddress_detail]").focus();
	            }
	        }).open();
		});
	});
</script>