<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
		
		ProductRepository dao = ProductRepository.getInstance();
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
		
		dao.addProduct(newProduct);
		response.sendRedirect("products.jsp");
	%>
</body>
</html>