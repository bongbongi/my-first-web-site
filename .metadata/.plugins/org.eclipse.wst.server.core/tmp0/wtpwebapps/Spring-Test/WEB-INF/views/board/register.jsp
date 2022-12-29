<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" 
rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div,form>div{
	width: 700px;
	display: flex;
	align-items: center;
	justify-content: center;
}
#trigger{
	width: 700px;
}
</style>
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>

<form action="/board/register" method="post" enctype="multipart/form-data" >
	<div class="mb-3">
	  <label for="exampleFormControlInput1" class="form-label"></label>
	  <input type="text" class="form-control" id="exampleFormControlInput1" name="title" placeholder="TITLE">
	</div>
	<div class="mb-3">
	  <label for="exampleFormControlInput1" class="form-label"></label>
	  <input type="text" class="form-control" id="exampleFormControlInput1" name="writer" value=${ses.id } readonly="readonly" >
	</div>
	<div class="mb-3">
	  <label for="exampleFormControlTextarea1" class="form-label"></label>
	  <textarea class="form-control" id="exampleFormControlTextarea1" rows="10" name="content" placeholder="content"></textarea>
	</div>
	 <div class="col-12 d-grid">
		<input class="form-control" type="file" style="display: none;"
				 id="files" name="files" multiple>
		<button type="button" id="trigger" class="btn btn-outline-primary btn-block d-block">Files Upload</button>
	</div>	
	<br>	
	<div class="col-12" id="fileZone">
	
	</div>
	<button type="submit" class="btn btn-outline-dark" id="regBtn">작성</button>
	<a href="/"><button type="button" class="btn btn-outline-dark">취소</button><br></a>
	
<script src="/resources/js/boardModify.js"></script>
<script src="/resources/js/boardRegister.js"></script>	
</form>

<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>