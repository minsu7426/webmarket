<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%-- <%@ page import = "dto.Product" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "dao.ProductRepository" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/bootstrap/bootstrap.min.css"/>
<title>상품목록</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
<%-- 	<%
		ProductRepository dao = ProductRepository.getInstance();
		ArrayList<Product> listOfproducts = dao.getAllProducts();
	%> --%>
	<div class="container">
		<div class="row" align="center">
			<%@ include file="dbconn.jsp" %>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "select * from product";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()){
				/* for(int i = 0; i < listOfproducts.size(); i++){
					Product product = listOfproducts.get(i); */
			%>
			<div class="col-md-4">
				<img src="./resources/image/<%=rs.getString("p_fileName")/* product.getFilename() */ %>" style="width:100%">
				<h3><%= rs.getString("p_name")/* product.getpName() */%></h3>
				<p><%= rs.getString("p_description")/* product.getDescription() */ %>
				<p><%= rs.getString("p_UnitPrice")/* product.getUnitPrice() */ %>원
				<p> <a href="./product.jsp?id=<%= rs.getString("p_id")/* product.getProductId() */ %>"
				class="btn btn-secondary" role="button"> 상세 정보 &raquo;></a>
			</div>
			<%
				}
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			%>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>