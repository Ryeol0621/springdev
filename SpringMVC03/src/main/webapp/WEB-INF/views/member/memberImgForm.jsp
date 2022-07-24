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
  <script type="text/javascript">
	  $(document).ready(function() {
			if(${!empty msgType}){
				$("#msgType").attr("class", "modal-content panel-warning");
				$("#resultMsg").modal("show");
			}
		});
  </script>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp"/>
  <h2>Panel Heading</h2>
  <div class="panel panel-default">
    <div class="panel-heading">이미지등록</div>
    <div class="panel-body">
		<form action="${contextPath}/memberImgUpload.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="memID" value="${dto.memID}">
		<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
			<tr>
				<td style="width: 110px; vertical-align: middle;">아이디</td>
				<td>${dto.memID}</td>
			</tr>
			<tr>
				<td style="width: 110px; vertical-align: middle;">사진등록</td>
				<td colspan="2">
					<span class="btn btn-default">
						이미지 업로드<input type="file" name="memProfile" id="memProfile">
					</span>
				</td>
			</tr>
				<td colspan="2" style="text-align: left;">
					<input type="submit" value="등록" class="btn btn-primary btn-sm pull-right">
				</td>
			</tr>
		</table>
		</form>
	</div>
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
