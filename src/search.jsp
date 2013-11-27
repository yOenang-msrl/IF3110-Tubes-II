<%-- 
    Document   : barang
    Created on : Nov 26, 2013, 10:57:32 AM
    Author     : Aidil Syaputra
--%>

<%@page import="sun.security.x509.OIDMap"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            Connection koneksi = null;
            String kata = request.getParameter("kata");
            String pilihan = request.getParameter("pilihan");
            ResultSet hasil1;
            int pages;
        %>
        <%
            try {
                String connectionURL = "jdbc:mysql://localhost:3306/ruserba"; //isi dengan server dan nama database
                Class.forName("com.mysql.jdbc.Driver").newInstance();                
                koneksi = DriverManager.getConnection(connectionURL, "root", ""); //username dan password database
            }
            catch(Exception ex){
                out.println("Unable to connect to database."+ex);
            }
            Statement stm1 = koneksi.createStatement();  
            if(pilihan.equals("kategori")){                                 
                hasil1 = stm1.executeQuery("SELECT * FROM barang LEFT JOIN kategori ON barang.id_kategori=kategori.id_kategori WHERE nama_kategori LIKE '%"+kata+"%'");
            } else if(pilihan.equals("nama")){                 
                hasil1 = stm1.executeQuery("SELECT * FROM barang LEFT JOIN kategori ON barang.id_kategori=kategori.id_kategori WHERE nama_barang LIKE '%"+kata+"%'");  
            } else {
                hasil1 = stm1.executeQuery("SELECT * FROM barang LEFT JOIN kategori ON barang.id_kategori=kategori.id_kategori WHERE harga_barang LIKE '%"+kata+"%'");
            }
            hasil1.last();
            int banyakBarang = hasil1.getRow();
            hasil1.beforeFirst();
            if(request.getParameter("page")==null){
                pages=1;
            } else {
                pages = Integer.valueOf(request.getParameter("page"));
            }
            int limit = 10;
            int mulai_dari = limit * (pages - 1);
            if(pilihan.equals("kategori")){                                 
                hasil1 = stm1.executeQuery("SELECT * FROM barang LEFT JOIN kategori ON barang.id_kategori=kategori.id_kategori WHERE nama_kategori LIKE '%"+kata+"%' LIMIT "+mulai_dari+", "+limit);
            } else if(pilihan.equals("nama")){                 
                hasil1 = stm1.executeQuery("SELECT * FROM barang LEFT JOIN kategori ON barang.id_kategori=kategori.id_kategori WHERE nama_barang LIKE '%"+kata+"%' LIMIT "+mulai_dari+", "+limit);  
            } else {
                hasil1 = stm1.executeQuery("SELECT * FROM barang LEFT JOIN kategori ON barang.id_kategori=kategori.id_kategori WHERE harga_barang LIKE '%"+kata+"%' LIMIT "+mulai_dari+", "+limit);
            }
        %>
        <link rel="stylesheet" type="text/css" media="all" href="css/main.css"/>
        <script type="text/javascript" src="js/sort.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            <%
                out.println("Hasil Pencarian "+request.getParameter("kata")+" Berdasarkan "+request.getParameter("pilihan"));
            %>
        </title>
    </head>
    <body>
        <div id='wrapper'>
            <div id='header'>
                <%@include file="header.jsp" %>
            </div>
            <div class='divider'></div>
            <div id="content">
                <h3 class="judul_halaman">
                    <%
                    out.println("Hasil Pencarian "+request.getParameter("kata")+" Berdasarkan "+request.getParameter("pilihan")+" Halaman "+pages);
                    %>
                </h3>
                <%
                while(hasil1.next()){
                    %>
                    <div class="halaman_category_container">
                       <div class="barang_container">
                           <div class="barang">
                                <% 
                                out.print("<a href='detilbarang.jsp?id="+hasil1.getString("id_barang")+"'>");
                                out.print("<img src='assets/barang/"+hasil1.getString("gambar")+"' height=100%/>");
                                out.print("</a>");
                                %>
                           </div>
                           <div class="barang">
                               Nama :
                                <span class="barang_nama">
                                    <%
                                     out.print("<a href='detilbarang.jsp?id="+hasil1.getString("id_barang")+"'>");
                                     out.print(hasil1.getString("nama_barang"));
                                     out.print("</a>");
                                     %>
                                </span>
                                <br/>
                                Kategori :
                                <span class="barang_nama">
                                    <%
                                     out.print("<a href='barang.jsp?kategori="+hasil1.getString("id_kategori")+"'>");
                                     out.print(hasil1.getString("nama_kategori"));
                                     out.print("</a>");
                                     %>
                                </span>
                                <br/>
                                <span class="barang_tersedia"></span>
                                Harga :
                                <span class="barang_harga">
                                     <% 
                                     out.print("Rp "+hasil1.getString("harga_barang")+",00");
                                     %>
                                </span>
                                <br/>
                                <br/>
                                <br/>
                                <%
                                out.print("Jumlah : ");
                                out.print("<input type='number' class='inputjumlah' name='jumlah' value=1 min=1 max=10/>");
                                %>
                                <br/>
                                <%
                                out.print("<a class='button beli' name='"+hasil1.getString("id_barang")+"' href='javascript:void(0)'><div>Pesan Barang</div></a>");
                                %>  
                           </div>
                       </div>
                    </div>
                    <hr>
                <% 
                }
                int banyakHalaman = (int) Math.ceil(banyakBarang / limit);
                if (banyakHalaman > 1) {
                    out.print("<div class='paginasi'>");
                    out.print("Halaman : "); 
                        for(int i = 1; i <= banyakHalaman; i++){
                                if(pages != i){
                                        out.print("<a href='search.jsp?kata"+request.getParameter("kata")+"&pilihan="+request.getParameter("pilihan")+"&page="+i+"'>["+i+"]</a>");
                                } else {
                                        out.print("["+i+"]");
                                }
                        }
                     out.print("</div>");
                }
                %>
            </div>
            <div class='divider'></div>
            <div id='footer'>
                <%@include file="footer.jsp"%>
            </div>
            <br /><br /><br /><br /><br /><br />
        </div>
    </body>
</html>
