function searchClick()
{
	var search = document.getElementById("search").value;
	var harga = document.getElementById("harga").value;
	var kategori = document.getElementById("kategori").value;
	var operator = document.getElementById("operator").value;
	init('http://localhost:8080/ruserba/barang','harga','ASC',search,kategori,harga,operator);
}
