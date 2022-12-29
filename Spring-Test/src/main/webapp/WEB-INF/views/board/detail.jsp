<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" 
rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onsubmit=getCommentList(${bvo.bno})>
<jsp:include page="../layout/header.jsp"></jsp:include>
	<form method="post">
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label"></label> 
			<input type="text" class="form-control" id="exampleFormControlInput1" name="bno" value=${bvo.bno } readonly="readonly">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label"></label> <input
				type="text" class="form-control" id="exampleFormControlInput1"
				name="title" value=${bvo.title } readonly="readonly">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label"></label> <input
				type="text" class="form-control" id="exampleFormControlInput1"
				name="writer" value=${bvo.writer } readonly="readonly"
				placeholder="">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label"></label> <input
				type="text" class="form-control" id="exampleFormControlInput1"
				name="writer" value=${bvo.registerDate } readonly="readonly"
				placeholder="">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label"></label>
			<input class="form-control" id="exampleFormControlTextarea1"
				rows="10" name="content" value=${bvo.content } readonly="readonly">
		</div>
		<!-- 파일 표현라인 -->
		<div class="mb-3">
			<ul class="">
			<!-- c:if 파일이 없으면 첨부파일이 없습니다. 출력 -->
			
				<c:forEach items="${fList}" var="fvo">
					<!-- 파일이 여러개 일 때 반복적으로 li 추가 -->
						<li>
							<c:choose>
								<c:when test="${fvo.file_type > 0}">
									<div>
										<!--D:어쩌구저꺼구fileUpload/2022/12/28/dog.jpg  -->
										<img src="/upload/${fn:replace(fvo.save_dir,'\\','/')}/${fvo.uuid}_th_${fvo.file_name}">
									</div>
								</c:when>
								<c:otherwise>
									<div>
										<!-- 파일모양 아이콘을 넣어서 일반 파일임을 표현하면 됨 -->
									</div>
								</c:otherwise>
							</c:choose>
							<!-- 파일이름, 등록일, 사이즈 -->
							<div class="ms-2 me-auto">
								<div class="fw-bold">${fvo.file_name}</div>
							${fvo.reg_at}
							</div>
							<span class="badge bg-secondary rounded-pill">${fvo.file_size} Byte</span>				
						</li>
				</c:forEach>
			</ul>
		</div>	
		<!-- 버튼 -->
		<c:if test="${ses != null && ses.id == bvo.writer }">
			<a href="/board/modify?bno=${bvo.bno}"><button type="button"
					class="btn btn-outline-secondary">수정</button></a>
			<a href="/board/remove?bno=${bvo.bno}"><button type="button"
					class="btn btn-outline-secondary">삭제</button></a>
		</c:if>
			<a href="/board/list"><button type="button"
					class="btn btn-outline-secondary">뒤로 가기</button> <br></a>
	</form>
	<!-- comment line -->
	<div class="container">
		<div class="input-group my-3">
			<span class="input-group-text" id="cmtWriter">${bvo.writer }</span>
			<input type="text" class="form-control" id="cmtText" placeholder="Test Add Comment ">
			<button class="btn btn-success" id="cmtPostBtn" type="button">Post</button>
		</div>
		<ul class="list-group list-group-flush" id="cmtListArea">
		  <li class="list-group-item d-flex justify-content-between align-items-start">
		    <div class="ms-2 me-auto">
		      <div class="fw-bold">Writer</div>
		      Content for Comment
		    </div>
		    <span class="badge bg-dark rounded-pill">modAt</span>
		  </li>
		</ul>
	</div>
	<script type="text/javascript">
		const bnoVal = '<c:out value="${bvo.bno }" />';
		console.log(bnoVal);
	</script>
	<script type="text/javascript" src="/resources/js/boardComment.js"></script>
	<script type="text/javascript">getCommentList(bnoVal)</script>		
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>