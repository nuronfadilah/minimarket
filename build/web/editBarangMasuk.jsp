<%-- 
    Document   : editBarangMasuk
    Created on : Apr 18, 2025, 10:21:09 AM
    Author     : MyBook14F
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Barang Masuk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="dashboard.jsp">MiniMarket</a>
            <div class="collapse navbar-collapse justify-content-end">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link active" href="dashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="barangMasuk.jsp">Barang Masuk</a></li>
                <li class="nav-item"><a class="nav-link" href="riwayatBarangMasuk.jsp">Riwayat Masuk</a></li>
                <li class="nav-item"><a class="nav-link" href="barangKeluar.jsp">Barang Keluar</a></li>
                <li class="nav-item"><a class="nav-link" href="stokBarang.jsp">Stok Barang</a></li>
                <li class="nav-item"><a class="nav-link" href="laporan.jsp">Laporan</a></li>
                <li class="nav-item"><a class="nav-link text-danger" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Form Edit Barang Masuk -->
    <div class="container mt-5">
        <h2 class="mb-4 text-center">Edit Barang Masuk</h2>
        <form action="UpdateBarangMasukServlet" method="post" class="bg-white p-4 shadow rounded">
            <%
                String id = request.getParameter("id");
                if (id != null) {
                    try {
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");
                        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM barang_masuk WHERE id = ?");
                        stmt.setString(1, id);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
            %>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="tanggal" class="form-label">Tanggal Masuk</label>
                    <input type="date" class="form-control" name="tanggal" value="<%= rs.getString("tanggal") %>" required>
                </div>
                <div class="col-md-6">
                    <label for="barcode" class="form-label">Barcode</label>
                    <input type="text" class="form-control" name="barcode" value="<%= rs.getString("barcode") %>" required>
                </div>
                <div class="col-md-6">
                    <label for="nama" class="form-label">Nama Barang</label>
                    <input type="text" class="form-control" name="nama" value="<%= rs.getString("nama") %>" required>
                </div>
                <div class="col-md-6">
                    <label for="kategori" class="form-label">Kategori</label>
                    <input type="text" class="form-control" name="kategori" value="<%= rs.getString("kategori") %>">
                </div>
                <div class="col-md-6">
                    <label for="jumlah" class="form-label">Jumlah</label>
                    <input type="number" class="form-control" name="jumlah" value="<%= rs.getInt("jumlah") %>" required>
                </div>
                <div class="col-md-6">
                    <label for="satuan" class="form-label">Satuan</label>
                    <select class="form-select" name="satuan" required>
                        <option value="pcs" <%= rs.getString("satuan").equals("pcs") ? "selected" : "" %>>Pcs</option>
                        <option value="box" <%= rs.getString("satuan").equals("box") ? "selected" : "" %>>Box</option>
                        <option value="botol" <%= rs.getString("satuan").equals("botol") ? "selected" : "" %>>Botol</option>
                        <option value="pack" <%= rs.getString("satuan").equals("pack") ? "selected" : "" %>>Pack</option>
                    </select>
                </div>
                <div class="col-md-6">
                     <label for="harga" class="form-label">Harga Beli (opsional)</label>
                   <input type="number" class="form-control" name="harga" value="<%= rs.getDouble("harga") %>" id="harga" required>
                   <small id="formatRupiah" class="text-muted"></small>
                </div>
                <div class="col-md-6">
                    <label for="supplier" class="form-label">Supplier</label>
                    <input type="text" class="form-control" name="supplier" value="<%= rs.getString("supplier") %>">
                </div>
                <div class="col-12">
                    <label for="keterangan" class="form-label">Keterangan</label>
                    <textarea class="form-control" name="keterangan" rows="2"><%= rs.getString("keterangan") %></textarea>
                </div>
            </div>
            <input type="hidden" name="id" value="<%= rs.getString("id") %>">
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-success px-5">Update</button>
            </div>
            <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
        </form>
    </div>
        <script>
  const hargaInput = document.getElementById("harga");
  const formatDisplay = document.getElementById("formatRupiah");

  hargaInput.addEventListener("input", function() {
    let value = this.value.replace(/[^\d]/g, '');
    if (value) {
      let floatVal = parseFloat(value);
      let format = new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
      }).format(floatVal);
      formatDisplay.textContent = format;
    } else {
      formatDisplay.textContent = "";
    }
  });
</script>
</body>
</html>

