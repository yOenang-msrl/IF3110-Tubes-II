<%@page import="java.util.ArrayList"%>
<%@page import="kelas.*"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><% out.println("Kategori: " + request.getAttribute("kategori")); %></title>
</head>
<body>
	<%@ include file="template/template.jsp" %> 
	<br/><br/><br/>
	<% 
		out.println("<h1>Kategori: " + request.getAttribute("kategori") + "</h1>");
	
		ArrayList<Barang> barangs = (ArrayList<Barang>) request.getAttribute("barangs");
		int awal = (request.getParameter("start") == null ? 0 : Integer.parseInt(request.getParameter("start")));
		int no = 0;
		for(Barang b: barangs){
			if(no < awal){
				no++;
				continue;
			}
			%>
			<div class="list_barang">
				<div class="gambar">
					<img src="res/<%= b.getGambar() %>" width="150px" height="150px">
				</div>
				<div class="list_desc">
					<strong>Nama:</strong> <a href="detail?gid=<%= b.getId_inven() %>"><%= b.getNama() %></a><br/>
					<strong>Harga:</strong> <%= b.getHarga() %><br/><br/>
					<form>
						<input type='text' id='quant<%= no %>' value='0' size=7 >
						<img class="cart_button" src="res/addtocart.png" width=125 onclick="validate(<%= b.getId_inven() %>, <%= no %>)">
					</form>
					
					<div id='notif<%=no%>'></div>
				</div>
			</div>
			<%
			if(no - awal == 9){
				break;
			}
			no++;
		}
		%>
		<div class="pagination"> Halaman: 
		<%
		for(int i=0;i<Math.ceil(barangs.size()/10f);i++){
			if(i * 10 == awal){
				out.println("[" + (i+1) + "]");
			} else {
				%>	
				<a href="showList?cat=<%= request.getParameter("cat") %>&start=<%= i*10 %>"><%= (i+1) %></a>
				<%
			}
		}
		%>
		</div>
		<%
	%>
</body>
	<script src="transaction.js"></script>
</html>