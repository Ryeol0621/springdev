<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>      
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC02</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	$(document).ready(function(){
		loadList();	
	});
  	
  	function loadList() {
		$.ajax({
			url : "boardList.do",
			type : "get",
			dataType : "json",
			success : makeView,
			error : function (){
				alert("error");
			}
		});
	}
  	
  	function makeView(data) {
		var list ="<table class='table table-bordered table-hover'>";
		list += "<tr>";
		list += "<td>번호</td>";
		list += "<td>제목</td>";
		list += "<td>작성자</td>";
		list += "<td>작성일</td>";
		list += "<td>조회수</td>";
		list += "</tr>";
		$.each(data, function(index,data){ //data에서 값을 꺼내와서 function(index,data)에 넣는다
			list += "<tr>";
			list += "<td>"+data.idx+"</td>";
			list += "<td>"+data.title+"</td>";
			list += "<td>"+data.writer+"</td>";
			list += "<td>"+data.indatex+"</td>";
			list += "<td>"+data.count+"</td>";
			list += "</tr>";
		});
		list += "<tr>";
		list += "<td colspan='5'><button class='btn btn-info btn-sm' onclick='goForm()'>글쓰기</button></td>";
		list += "</tr>";
		list += "</table>";
		$("#view").html(list);
		
		$("#view").show();
		$("#insertForm").css("display", "none");
	}
  	
  	function goForm() {
  		//$("#view").css("display", "none");
  		$("#view").hide();
  		$("#insertForm").css("display", "block");
	}
  	
  	function goList() {
  		//$("#view").css("display", "block");
  		$("#view").show();
  		$("#insertForm").css("display", "none");
	}
  	
  	function goInsert() {
//   		var title   = $("#title").val();
//   		var content = $("#content").val();
//   		var writer  = $("#writer").val();
  		
  		var formData = $("#frm").serialize();
  		
  		$.ajax({
  			url: "boardInsert.do",
  			type: "post",
  			data: formData,
  			success: loadList,
  			error: function () {
				alert("error");
			}
  		});
  		
  		$("#title").val("");
  		$("#content").val("");
  		$("#writer").val("");
	}
  		
  </script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC02</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Boare</div>
    <div class="panel-body" id="view" >Panel Content</div>
    <div class="panel-body" id="insertForm" style="display: none;">
		<form id="frm">
			<table class="table">
				<tr>
					<td>제목</td>
					<td><input type="text" id="title" name="title" class="form-control"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="7" id="content" name="content" class="form-control"></textarea></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" id="writer" name="writer" class="form-control"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
						<button type="reset" class="btn btn-warning btn-sm">취소</button>
						<button type="button" class="btn btn-info btn-sm" onclick="goList()">목록</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
    <div class="panel-footer">Panel Content</div>
  </div>
</div>

</body>
</html>
