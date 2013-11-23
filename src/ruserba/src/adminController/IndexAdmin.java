package adminController;

import java.io.IOException;
import java.sql.ResultSet;

import javaModel.Barang;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databaseLib.DatabaseAdapter;

/**
 * Servlet implementation class IndexAdmin
 */
@WebServlet({ "/admin/index", "/admin", "/admin/"})
public class IndexAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DatabaseAdapter DBA;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexAdmin() {
        super();
        DBA = new DatabaseAdapter();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		boolean isLogin;
		if (session.getAttribute("isLogin")!=null)
			isLogin = (boolean)session.getAttribute("isLogin");
		else
			isLogin = false;
		
		if (isLogin)
		{
			String kateg = request.getParameter("kateg");
			if (kateg != null)
			{
				Barang B = new Barang(DBA);
				String Query = "select barang.id, barang.nama, barang.harga, " +
						"barang.gambar, barang.stok, kategori.nama_kategori, kategori.gambar from barang" +
						" join kategori on barang.id_kategori = kategori.id and kategori.id="+kateg; //jangan lupa diubah ke per kategori
				B.executeQuery(Query);
				request.setAttribute("barang", B);
			}
			
			DBA.executeQuery("select * from kategori");
			ResultSet RS = DBA.getQueryResult();
			
			request.setAttribute("listKategori",RS);
			request.getRequestDispatcher("/view/adminIndex.jsp").forward(request, response);
		}
		else response.sendRedirect("/ruserba/admin/login");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
