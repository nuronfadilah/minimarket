<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Riwayat Barang Masuk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="dashboard.jsp">MiniMarket</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
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

<!-- Riwayat Barang Masuk -->
<div class="container mt-5">
    <h2 class="mb-4 text-center">Riwayat Barang Masuk</h2>
    <div class="table-responsive bg-white p-4 shadow rounded">

    <!-- Filter Form -->
    <form method="get" class="mb-4 d-flex gap-2">
        <input type="text" name="keyword" class="form-control w-25" placeholder="Cari nama/barcode..." value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
        <input type="date" name="tanggal" class="form-control w-25" value="<%= request.getParameter("tanggal") != null ? request.getParameter("tanggal") : "" %>">
        <button type="submit" class="btn btn-primary">Cari</button>
        <a href="riwayatBarangMasuk.jsp" class="btn btn-secondary">Reset</a>
    </form>

    <%
        int no = 1;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");
            Statement stmt = conn.createStatement();

            // Peringatan jika ada barcode sama tapi nama beda
            String cekDuplikat = "SELECT barcode FROM barang_masuk GROUP BY barcode HAVING COUNT(DISTINCT nama) > 1";
            ResultSet cek = stmt.executeQuery(cekDuplikat);
            if (cek.next()) {
    %>
                <div class="alert alert-warning">
                    ⚠️ Ditemukan data dengan <strong>barcode sama</strong> namun <strong>nama barang berbeda</strong>. Periksa kembali input barang masuk!
                </div>
    <%
            }
            cek.close();

            String keyword = request.getParameter("keyword");
            String tanggalFilter = request.getParameter("tanggal");
            String sql = "SELECT * FROM barang_masuk WHERE 1=1";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += " AND (nama LIKE '%" + keyword + "%' OR barcode LIKE '%" + keyword + "%')";
            }
            if (tanggalFilter != null && !tanggalFilter.trim().isEmpty()) {
                sql += " AND tanggal = '" + tanggalFilter + "'";
            }

            sql += " ORDER BY tanggal DESC";
            ResultSet rs = stmt.executeQuery(sql);
    %>

        <table class="table table-bordered table-hover">
            <thead class="table-dark text-center">
                <tr>
                    <th>No</th>
                    <th>Tanggal</th>
                    <th>Barcode</th>
                    <th>Nama Barang</th>
                    <th>Kategori</th>
                    <th>Jumlah</th>
                    <th>Satuan</th>
                    <th>Harga</th>
                    <th>Supplier</th>
                    <th>Keterangan</th>
                    <th>Section</th>
                </tr>
            </thead>
            <tbody>
            <%
                while (rs.next()) {
            %>
                <tr>
                    <td><%= no++ %></td>
                    <td><%= rs.getString("tanggal") %></td>
                    <td><%= rs.getString("barcode") %></td>
                    <td><%= rs.getString("nama") %></td>
                    <td><%= rs.getString("kategori") %></td>
                    <td><%= rs.getInt("jumlah") %></td>
                    <td><%= rs.getString("satuan") %></td>
                    <td>
                        <%
                            double harga = rs.getDouble("harga");
                            java.text.NumberFormat formatRupiah = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("id", "ID"));
                            formatRupiah.setMaximumFractionDigits(0);
                            out.print(formatRupiah.format(harga));
                        %>
                    </td>
                    <td><%= rs.getString("supplier") %></td>
                    <td><%= rs.getString("keterangan") %></td>
                    <td>
                        <a href="editBarangMasuk.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="HapusBarangMasukServlet?id=<%= rs.getInt("id") %>" onclick="return confirm('Yakin ingin menghapus data ini?')" class="btn btn-danger btn-sm">Hapus</a>
                    </td>
                </tr>
            <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='11' class='text-center text-danger'>Gagal memuat data.</td></tr>");
                e.printStackTrace();
            }
            %>
            </tbody>
        </table>

    </div>
</div>

</body>
</html>
