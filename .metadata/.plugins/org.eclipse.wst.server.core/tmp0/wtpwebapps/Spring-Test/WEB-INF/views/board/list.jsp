<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
	<form>
			<table class="table table-hover">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<c:forEach items="${list}" var="bvo">
					<tr>
						<td>${bvo.bno}</td>
						<td>
							<a href="/board/detail?bno=${bvo.bno }">${bvo.title} </a>
						</td>
						<td>${bvo.writer}</td>
						<td>${bvo.registerDate}</td>
						<td>${bvo.read_count}</td>
					</tr>
				</c:forEach>
			</table>
			<div>
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<c:if test="${pgh.prev }">
							<li class="page-item">
								<a class="page-link" aria-label="Previous"
									href="/board/list?pageNo=${pgh.startPage-1 }&qty=${pgh.pgvo.qty }">
										<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>
						<c:forEach begin="${pgh.startPage}" end="${pgh.endPage}" var="i">
							<li class="page-item">
								<a class="page-link" href="/board/list?pageNo=${i}&qty=${pgh.pgvo.qty}">
								${i }
								</a>
							</li>
						</c:forEach>
						<c:if test="${pgh.next }">
							<li class="page-item">
								<a class="page-link" aria-label="Next"
									href="/board/list?pageNo=${pgh.endPage+1 }&qty=${pgh.pgvo.qty }">
										<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:if>
					</ul>
				</nav>
					
			<!-- search -->
			 <div class="col-sm-12 col-md-6">
				<form action="/board/list" method="get">
					<div class="input-group mb-3">
					<!-- 값을 별도 저장 -->
					<c:set value="${pgh.pgvo.type }" var="typed"/>
			  			<select class="form-select" name="type">
			    			<option ${typed == null ? 'selected':'' }>Choose...</option>
			    			<option value="t" ${typed eq 't' ? 'selected':'' }>Title</option>
			    			<option value="c" ${typed eq 'c' ? 'selected':'' }>Content</option>
			    			<option value="w" ${typed eq 'w' ? 'selected':'' }>Writer</option>
			  			</select>
			  			<input class="form-control" type="text" name="keyword" placeholder="Search" value="${pgh.pgvo.keyword }">
			  			<input type="hidden" name="pageNo" value="1">
			  			<input type="hidden" name="qty" value="${pgh.pgvo.qty }">
			  			<button type="submit" class="btn btn-success position-relative">
				  			Search
				  			<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
					    		${pgh.totalCount }
					    		<span class="visually-hidden">unread messages</span>
				    		</span>
			  			</button>
					</div>
				</form>
			</div>
		</div>
	</form>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>