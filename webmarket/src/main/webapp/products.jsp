<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "dto.Product" %>
<%@ page import = "dao.ProductRepository" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/bootstrap/bootstrap.min.css"/>
<meta charset="UTF-8">
<title>상품목록</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	<%
		ProductRepository dao = ProductRepository.getInstance();
		ArrayList<Product> listOfproducts = dao.getAllProducts();
	%>
	<div class="container">
		<div class="row" align="center">
			<%
				for(int i = 0; i < listOfproducts.size(); i++){
					Product product = listOfproducts.get(i);
			%>
			<div class="col-md-4">
				<img src="./resources/image/<%=product.getFilename() %>" style="width:100%">
				<h3><%= product.getpName()%></h3>
				<p><%=product.getDescription() %>
				<p><%=product.getUnitPrice() %>원
				<p> <a href="./product.jsp?id=<%=product.getProductId() %>"
				class="btn btn-secondary" role="button"> 상세 정보 &raquo;></a>
			</div>
			<%
				}
			%>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>