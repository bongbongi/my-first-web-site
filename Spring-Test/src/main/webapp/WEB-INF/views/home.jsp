<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<style>
h1, p {
	text-align: center;
}
h1{
}
.home{
	height: 80vh;
}
</style>
<jsp:include page="./layout/header.jsp"></jsp:include>
<div class="home">
	<h1>Hello world!</h1>
	<P>My Spring Project!!</P>
</div>
<jsp:include page="./layout/footer.jsp"></jsp:include>
<script type="text/javascript">
	const msg = '<c:out value="${msg}"/>';
	if (msg === '0') {
		console.log(msg);
		alert("로그아웃!");
	}
</script>
