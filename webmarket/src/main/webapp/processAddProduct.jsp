<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%-- <%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		// 이미지업로드
		String filename = "";
		String realFolder = request.getRealPath("resources/image");
		int maxSize = 5 * 1024 * 1024;
		String encType = "utf-8";
		
		
		MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		String productId = multi.getParameter("productId");
		String name = multi.getParameter("name");
		String unitPrice = multi.getParameter("unitPrice");
		String description = multi.getParameter("description");
		String manufacturer = multi.getParameter("manufacturer");
		String category = multi.getParameter("category");
		String unitsInStock = multi.getParameter("unitsInStock");
		String condition = multi.getParameter("condition");
		// 이미지업로드
		
		int price;
		if(unitPrice.isEmpty()){
			price = 0;
		}
		else{
			price = Integer.valueOf(unitPrice); 
		}
		
		long stock;
		if(unitsInStock.isEmpty()){
			stock = 0;
		}
		else{
			stock = Long.valueOf(unitsInStock);
		}
		// 이미지업로드
		Enumeration files = multi.getFileNames();
		String fname = (String) files.nextElement();
		String fileName = multi.getFilesystemName(fname);
		// 이미지업로드
		
		PreparedStatement pstmt = null;
		
		String sql = "insert into product values(?,?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		pstmt.setString(2, name);
		pstmt.setInt(3, price);
		pstmt.setString(4, description);
		pstmt.setString(5, category);
		pstmt.setString(6, manufacturer);
		pstmt.setLong(7, stock);
		pstmt.setString(8, condition);
		pstmt.setString(9, fileName);
		pstmt.executeUpdate();
		
		if(pstmt != null)
			pstmt.close();
		if(conn != null)
			conn.close();
		/* ProductRepository dao = ProductRepository.getInstance();
		Product newProduct = new Product();
		newProduct.setProductId(productId);
		newProduct.setpName(name);
		newProduct.setUnitPrice(price);
		newProduct.setDescription(description);
		newProduct.setManufacturer(manufacturer);
		newProduct.setCategory(category);
		newProduct.setUnitsInStock(stock);
		newProduct.setCondition(condition);
		newProduct.setFilename(fileName);
		
		dao.addProduct(newProduct); */
		response.sendRedirect("products.jsp");
	%>
</body>
</html>