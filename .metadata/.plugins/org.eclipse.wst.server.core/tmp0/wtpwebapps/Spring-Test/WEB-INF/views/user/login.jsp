<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	margin: 0 auto;
	padding: 0;
	justify-content: center;
	align-items: center;
}

.center>form {
	height: 80vh;
	text-align: center;
}

.center {
	height: 80vh;
	display: flex;
	align-items: center;
	justify-content: center;
}
</style>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="center">
		<form action="/member/login" method="post">
			<input type="text" name="id" placeholder="ID"><br>
			<input type="text" name="pw" placeholder="password"><br>
			<br>
			<button type="submit" class="btn btn-outline-secondary">로그인</button>
		</form>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	
	<script type="text/javascript">	
		const msg = '<c:out value="${msg}"/>';
		console.log(msg);
		if (msg === "0") {
			alert("로그인 실패");
		}
	</script>
</body>
</html>
