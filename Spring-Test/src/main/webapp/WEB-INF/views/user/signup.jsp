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
	height: 100vh;
	margin: 0 auto;
	padding: 0;
	justify-content: center;
	align-items: center;
}

form {
	text-align: center;
	height: 300px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
		<form action="/member/signup" method="post">
			<input type="text" name="id" placeholder="ID"><br>
			<input type="text" name="pw" placeholder="password"><br>
			<input type="text" name="age" placeholder="age"><br> 
			<input type="text" name="name" placeholder="name"><br>  
			<input type="email" name="email" placeholder="email"><br> 
			<input type="text" name="home" placeholder="home"><br>
			<br>
			<button type="submit" class="btn btn-outline-secondary">가입</button>
		</form>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	
	<script type="text/javascript">
		const msg = '<c:out value="${msg}"/>';
		if(msg==='0'){
			console.log(msg);
			alert("이미 가입된 회원입니다.");
		}else{
			alert("회원가입 완료!");
		}
	</script>	
</body>
</html>