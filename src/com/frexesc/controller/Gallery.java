package com.frexesc.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.frexesc.model.BarangBean;

/**
 * 
 * Servlet implementation class Gallery
 * 
 */
@WebServlet("/barang/index")
public class Gallery extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Gallery() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DbConnection dbConnection = new DbConnection();
		Connection connection = dbConnection.mySqlConnection();

		int sort = 0;
		int jenisSort = 0;
		int page = 0;

		if (request.getParameter("sort") != null) {
			sort = Integer.valueOf(request.getParameter("sort"), 0);
		}

		if (request.getParameter("jenisSort") != null) {
			jenisSort = Integer.valueOf(request.getParameter("jenisSort"), 0);
		}

		if (request.getParameter("page") != null) {
			page = Integer.valueOf(request.getParameter("page"), 0);
		}

		try {
			String partial1 = "";
			String partial2 = "";

			if (sort != 0) {
				if (sort == 1)
					partial1 = " ORDER BY barang.nama_barang ";
				else if (sort == 2)
					partial1 = " ORDER BY kategori.nama ";
				else if (sort == 3)
					partial1 = " ORDER BY barang.harga_barang ";
			}

			if (jenisSort != 0) {
				if (jenisSort == 1) {
					partial2 = " ASC ";
				} else if (jenisSort == 2) {
					partial2 = " DESC ";
				}
			}

			if (page != 0) {
				page = page * 10;
			}

			String query = "SELECT kategori.nama, barang.gambar, barang.id, barang.id_kategori, barang.nama_barang, barang.harga_barang, barang.jumlah_barang, barang.keterangan FROM barang JOIN kategori ON barang.id_kategori=kategori.id "
					+ partial1 + partial2 + "LIMIT " + page + ",10"; // Select
																		// all
																		// items
																		// based
																		// on
																		// selection
			ResultSet rs = connection.createStatement().executeQuery(query);

			ArrayList<BarangBean> allResults = new ArrayList<BarangBean>();

			while (rs.next()) {
				BarangBean barang = new BarangBean(Integer.valueOf(rs
						.getString("id")), Integer.valueOf(rs
						.getString("id_kategori")),
						rs.getString("nama_barang"), rs.getString("gambar"),
						Integer.valueOf(rs.getString("harga_barang")),
						rs.getString("keterangan"), Integer.valueOf(rs
								.getString("jumlah_barang")));
				allResults.add(barang);
			}

			request.setAttribute("items", allResults);

			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher("/barang/index.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
