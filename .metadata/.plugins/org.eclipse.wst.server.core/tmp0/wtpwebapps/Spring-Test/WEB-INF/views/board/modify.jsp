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
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<form action="/board/modify" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label"></label> <input
				type="text" class="form-control" id="exampleFormControlInput1"
				name="bno" value=${bvo.bno } readonly="readonly">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label"></label> <input
				type="text" class="form-control" id="exampleFormControlInput1"
				name="title" value=${bvo.title } >
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
				name="registerDate" value=${bvo.registerDate } readonly="readonly"
				placeholder="">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label"></label>
			<input class="form-control" id="exampleFormControlTextarea1"
				rows="10" name="content" value=${bvo.content } >
		</div>
		 <div class="col-12 d-grid">
			<input class="form-control" type="file" style="display: none;"
					 id="files" name="files" multiple>
			<button type="button" id="trigger" class="btn btn-outline-primary btn-block d-block">Files Upload</button>
		</div>	
		<br>	
		<div class="col-12" id="fileZone">
		
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
							<button type="button" data-uuid=${fvo.uuid} class="btn btn-sm btn-danger py-0 file-x">X</button>
							
						</li>
				</c:forEach>
			</ul>
		</div>
		
		
		<a href="/board/modify?bno=${ bvo.bno}"><button type="submit"
				class="btn btn-outline-secondary" id="regBtn">수정완료</button></a>
		<a href="/board/list"><button type="button"
				class="btn btn-outline-secondary">뒤로 가기</button> <br></a>
	<script src="/resources/js/boardRegister.js"></script>	
	<script type="text/javascript">
		const uuid = '<c:out value="${fvo.uuid }" />';
		console.log(uuid);
	</script>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	</form>
</body>
</html>