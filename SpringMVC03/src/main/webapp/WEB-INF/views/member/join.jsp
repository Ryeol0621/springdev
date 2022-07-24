<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>MVC03</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function() {
	if(${!empty msgType}){
		if(${msgType eq "실패 메시지"}){
			$("#msgType").attr("class", "modal-content panel-warning");
			$("#resultMsg").modal("show");
		}
	}
});

function registerCheck() {
	var id = $("#memID").val();
	if(id == null || id == ""){
		alert("아이디를 입력하세요.");
		return false;
	}
	$.ajax({
		url: "${contextPath}/registerCheck.do",
		type: "get",
		data: {"id":id}, 
		success: function(result){
			if(result==1){
				$("#checkMessage").html("사용할 수 있는 아이디 입니다.");
				$("#checkType").attr("class", "modal-content panel-success");
			}else{
				$("#checkMessage").html("사용할 수 없는 아이디 입니다.");
				$("#checkType").attr("class", "modal-content panel-warning");
			}
			$("#myModal").modal("show");
		},
		error: function(){
			alert("error");
		}
	});
}

function passwordCheck(){
	
	var memPassword1 = $("#memPassword1").val();
	var memPassword2 = $("#memPassword2").val();
	
	if(memPassword1 != memPassword2){
		$("#passwordMessage").html("비밀번호가 서로 일치하지 않습니다.");
		$("#passwordMessage").css("color", "red");
	}else{
		$("#passwordMessage").css("color", "green").html("비밀번호가 일치합니다.");
// 		$("#passwordMessage").html("비밀번호가 일치합니다.");
		$("#memPassword").val(memPassword1);
	}
}

function goInsert() {
	var memAge = $("#memAge").val();
	if(memAge == null || memAge == ""){
		alert("나이를 입력하세요");
		return false;		
	}
	document.frm.submit();
}
</script>
<body>
<div class="container">
<jsp:include page="../common/header.jsp"/>
  <h2>Panel Heading</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Panel Heading</div>
    <div class="panel-body">
    	<form name="frm" action="${contextPath}/memberReg.do" method="post">
    	<input type="hidden" id="memPassword" name="memPassword" value="">
		<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
			<tr>
				<td style="width: 110px; vertical-align: middle;">아이디</td>
				<td><input id="memID" name="memID" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력하세요."> </td>
				<td style="width: 110px;"><button type="button" class="btn btn-info btn-sm" onclick="registerCheck()">중복확인</button></td>
			</tr>
			<tr>
				<td style="width: 110px; vertical-align: middle;">비밀번호</td>
				<td colspan="2"><input id="memPassword1" name="memPassword1" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비민번호를 입력하세요."> </td>
			</tr>
			<tr>
				<td style="width: 110px; vertical-align: middle;">비밀번호확인</td>
				<td colspan="2"><input id="memPassword2" name="memPassword2" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비민번호를 확인하세요."> </td>
			</tr>
			<tr>
				<td style="width: 110px; vertical-align: middle;">이름</td>
				<td colspan="2"><input id="memName" name="memName" class="form-control" type="text" maxlength="20" placeholder="이름을 입력하세요."> </td>
			</tr>
			<tr>
				<td style="width: 110px; vertical-align: middle;">나이</td>
				<td colspan="2"><input id="memAge" name="memAge" class="form-control" type="number" maxlength="20" placeholder="나이를 입력하세요."> </td>
			</tr>
			<tr>
				<td style="width: 110px; vertical-align: middle;">성별</td>
				<td colspan="2">
					<div class="form-group" style="text-align: center; margin: 0 auto;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input id="memGender" name="memGender" type="radio" autocomplete="off" value="남자" checked>남자
							</label>
							<label class="btn btn-primary">
								<input id="memGender" name="memGender" type="radio" autocomplete="off" value="여자" >여자
							</label>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td style="width: 110px; vertical-align: middle;">이메일</td>
				<td colspan="2"><input id="memEmail" name="memEmail" class="form-control" type="email" maxlength="200" placeholder="이메일을 입력하세요."> </td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: left;">
					<span id="passwordMessage"></span>
					<input type="button" value="등록" class="btn btn-primary btn-sm pull-right" onclick="goInsert()">
				</td>
			</tr>
		</table>
		</form>
	</div>
	<!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content pane-info" id="checkType">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">메시지 확인</h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 실패 메시지 출력 -->
	<div id="resultMsg" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div id="msgType" class="modal-content pane-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">${msgType}</h4>
	      </div>
	      <div class="modal-body">
	        <p>${msg}</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
    <div class="panel-footer">Panel footer</div>
  </div>
</div>

</body>
</html>


