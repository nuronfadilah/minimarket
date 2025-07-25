<%@page import="java.sql.*"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Stok Barang</title>
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

<!-- Content -->
<div class="container mt-5">
    <h2 class="mb-4 text-center">Stok Barang</h2>
    <div class="table-responsive bg-white p-4 shadow rounded">
        <table class="table table-bordered table-hover">
            <thead class="table-dark text-center">
                <tr>
                    <th>No</th>
                    <th>Barcode</th>
                    <th>Nama Barang</th>
                    <th>Kategori</th>
                    <th>Stok</th>
                    <th>Satuan</th>
                    <th>Harga</th>
                </tr>
            </thead>
            <tbody>
            <%
                int no = 1;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");
                    Statement stmt = conn.createStatement();

                    String sql = "SELECT barcode, nama, kategori, satuan, harga, SUM(jumlah) AS stok " +
                                 "FROM barang_masuk GROUP BY barcode ORDER BY nama ASC";
                    ResultSet rs = stmt.executeQuery(sql);

                    NumberFormat rupiahFormat = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
                    rupiahFormat.setMaximumFractionDigits(0);

                    while(rs.next()) {
            %>
                <tr>
                    <td><%= no++ %></td>
                    <td><%= rs.getString("barcode") %></td>
                    <td><%= rs.getString("nama") %></td>
                    <td><%= rs.getString("kategori") %></td>
                    <td class="text-center"><%= rs.getInt("stok") %></td>
                    <td><%= rs.getString("satuan") %></td>
                    <td><%= rupiahFormat.format(rs.getDouble("harga")) %></td>
                </tr>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='7' class='text-center text-danger'>Gagal memuat data: " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
