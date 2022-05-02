<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>

<%
   Product product2 = (Product) session.getAttribute("dto");
   String id = product2.getProductId();
   ProductRepository dao = ProductRepository.getInstance();
   //listofproducts 
   ArrayList<Product> goodsList = dao.getAllProducts();
   // dto
   Product goods = new Product();
   // 상품검색
   for (int i = 0; i < goodsList.size(); i++) {
      goods = goodsList.get(i);
      //상품확인
      if (goods.getProductId().equals(id)) {          
         break;
      }
   }
   
   ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
   //세션 속성 유효성검사 후 세션 속성 생성
   if (list == null) { 
      list = new ArrayList<Product>();
      session.setAttribute("cartlist", list);
   }

   int cnt = 0;
   Product goodsQnt = new Product();
   //장바구니(list)의 상품 갯수 만큼 반복
   for (int i = 0; i < list.size(); i++) {
      goodsQnt = list.get(i);//
      //기존 상품 있는지 검사 후 객수만 증가
      if (goodsQnt.getProductId().equals(id)) {
         cnt++;
         int orderQuantity = goodsQnt.getQuantity() + 1;
         goodsQnt.setQuantity(orderQuantity);
      }
   }
   // 장바구니(list)에 상품을 1로 추가
   if (cnt == 0) { 
      goods.setQuantity(1);
      list.add(goods);
   }

   response.sendRedirect("product.jsp?id=" + id);
%>