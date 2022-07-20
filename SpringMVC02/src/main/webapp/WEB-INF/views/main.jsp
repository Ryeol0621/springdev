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
		list += "</table>";
		$("#view").html(list);
	}
  		
  </script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC02</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Boare</div>
    <div class="panel-body" id="view" >Panel Content</div>
    <div class="panel-footer">Panel Content</div>
  </div>
</div>

</body>
</html>
