<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>      
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC03</title>
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
			//url : "boardList.do",
			url : "board/all",
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
			list += "<td id='t"+data.idx+"'><a href='javascript:goContent("+data.idx+")'>"+data.title+"</a></td>";
			list += "<td>"+data.writer+"</td>";
			list += "<td>"+data.indate+"</td>";
			list += "<td id='cnt"+data.idx+"'>"+data.count+"</td>";
			list += "</tr>";
			
			list += "<tr id='c"+data.idx+"' style='display:none'>";
			list += "<td>내용</td>";
			list += "<td colspan='4'>";
			//list += "<textarea id='text"+data.idx+"' readonly rows='7'class='form-control'>"+data.content+"</textarea>";
			list += "<textarea id='text"+data.idx+"' readonly rows='7'class='form-control'></textarea>";
			
			//if(${dto.memID} == data.memID){  //값자체
			if("${dto.memID}" == data.memID){  //String
				list += "</br>"
				list += "<span id='ub"+data.idx+"'><button class='btn btn-info btn-sm' onclick='goUpdateForm("+data.idx+")'>수정화면</button></span> &nbsp"
				list += "<button class='btn btn-warning btn-sm' onclick='goDelete("+data.idx+")'>삭제</button> &nbsp"
				list += "<span id='listB"+data.idx+"'></span>"
			}else{
				list += "</br>"
				list += "<span id='ub"+data.idx+"'><button disabled class='btn btn-info btn-sm' onclick='goUpdateForm("+data.idx+")'>수정화면</button></span> &nbsp"
				list += "<button disabled class='btn btn-warning btn-sm' onclick='goDelete("+data.idx+")'>삭제</button> &nbsp"
				list += "<span id='listB"+data.idx+"'></span>"

			}
			list += "</td>";
			list += "</tr>";
			
		});
		if(${!empty dto}){
			list += "<tr>";
			list += "<td colspan='5'><button class='btn btn-info btn-sm' onclick='goForm()'>글쓰기</button></td>";
			list += "</tr>";
			list += "</table>";
		}
		
		$("#view").html(list);
		$("#view").show();
		$("#insertForm").css("display", "none");
	}
  	
  	function goContent(idx) {
  		if($("#c"+idx).css("display") == "none"){
	  		$.ajax({
	  			//url: "boardContent.do", 
	  			url: "board/"+idx, 
	  			type: "get",
	  			//data: {"idx":idx},
	  			dataType: "json",
	  			success: function (data) {
					$("#text"+idx).val(data.content);
				},
	  			error: function () {
					alert("error");
				}	
	  		});
	  		$("#c"+idx).css("display", "table-row");
	  		$("#text"+idx).attr("readonly", true)
  		}else{
  			$("#c"+idx).css("display", "none");
	  		$.ajax({
	  			//url: "boardCount.do", 
	  			url: "board/count/"+idx,
	  			type: "put",
	  			//data: {"idx":idx},
	  			dataType: "json",
	  			success: function (data) {
					$("#cnt"+idx).text(data.count);
				},
	  			error: function () {
					alert("error");
				}	
	  		});
  		}
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
  			//url: "boardInsert.do",
  			url: "board/new",
  			type: "post",
  			data: formData,
  			success: loadList,
  			error: function () {
				alert("error");
			}
  		});
  		
//   		$("#title").val("");
//   		$("#content").val("");
//   		$("#writer").val("");
  		$("#clear").trigger("click");
	}
  	
  	function goDelete(idx) {
  		$.ajax({
  			//url: "boardDelete.do",   //   "boardDelete.do/"+idx
  			url: "board/"+idx,   //   "boardDelete.do/"+idx
  			type: "delete",
  			//type: "get",
  			//data: {"idx":idx},
  			success: loadList, 
  			error:function () {
				alert("error");
			}
  		});
	}
  	
  	function goUpdateForm(idx) {
		$("#text"+idx).attr("readonly", false);
		
		var title = $("#t"+idx).text();
		var newInput = "<input id='nt"+idx+"' type='text' class='form-control' value='"+title+"'/></td>"
		$("#t"+idx).html(newInput);
		
		var newButton 	  = "<button class='btn btn-primary btn-sm' onclick='goUpdate("+idx+")'>수정</button>"
		var newListButton = "<button class='btn btn-info btn-sm' onclick='loadList()'>목록</button>"
		$("#ub"+idx).html(newButton);
		$("#listB"+idx).html(newListButton);
	}

  	function goUpdate(idx) {
  		var title   = $("#nt"+idx).val();
  		var content = $("#text"+idx).val();
  		
  		$.ajax({
  			//url: "boardUpdate.do",   //   "boardDelete.do/"+idx
  			url: "board/update",   //   "boardDelete.do/"+idx
  			type: "put",
  			contentType: "application/json;charset=utf-8",
  			data: JSON.stringify({"idx":idx, "title":title, "content":content}),
  			success: loadList, 
  			error:function () {	
				alert("error");
			}
  		});
	}
  </script>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp"/> 
  <h2>Spring MVC02</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    <div class="panel-body" id="view" >Panel Content</div>
    <div class="panel-body" id="insertForm" style="display: none;">
		<form id="frm">
			<input type="hidden" name="memID" id="memID" value="${dto.memID}">
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
					<td><input type="text" id="writer" name="writer" class="form-control" value="${dto.memName}" readonly="readonly"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
						<button type="reset" class="btn btn-warning btn-sm" id="clear">취소</button>
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
