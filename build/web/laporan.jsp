<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Laporan MiniMarket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

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

<div class="container mt-5">
  <h2 class="text-center mb-4">Laporan MiniMarket</h2>

  <%-- Laporan Barang Masuk per Bulan --%>
  <h4 class="mt-4">Laporan Barang Masuk (Per Bulan)</h4>
  <div class="table-responsive">
    <table class="table table-bordered table-striped">
      <thead class="table-dark">
        <tr>
          <th>Bulan</th>
          <th>Total Jumlah</th>
          <th>Total Harga</th>
        </tr>
      </thead>
      <tbody>
      <%
        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");
          Statement stmt = conn.createStatement();
          String sql = "SELECT DATE_FORMAT(tanggal, '%Y-%m') AS bulan, SUM(jumlah) AS total_jumlah, SUM(jumlah * harga) AS total_harga FROM barang_masuk GROUP BY bulan ORDER BY bulan DESC";
          ResultSet rs = stmt.executeQuery(sql);

          while (rs.next()) {
      %>
        <tr>
          <td><%= rs.getString("bulan") %></td>
          <td><%= rs.getInt("total_jumlah") %></td>
          <td><%= java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("id", "ID")).format(rs.getDouble("total_harga")) %></td>
        </tr>
      <%
          }
          rs.close();
          stmt.close();
          conn.close();
        } catch (Exception e) {
          out.println("<tr><td colspan='3' class='text-danger text-center'>Gagal mengambil data barang masuk.</td></tr>");
        }
      %>
      </tbody>
    </table>
  </div>

  <%-- Laporan Stok Barang Sekarang --%>
  <h4 class="mt-5">Stok Barang Sekarang</h4>
  <div class="table-responsive">
    <table class="table table-bordered table-striped">
      <thead class="table-dark">
        <tr>
          <th>Barcode</th>
          <th>Nama</th>
          <th>Kategori</th>
          <th>Satuan</th>
          <th>Harga</th>
          <th>Stok</th>
        </tr>
      </thead>
      <tbody>
      <%
        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");
          Statement stmt = conn.createStatement();
          String sql = "SELECT barcode, nama, kategori, satuan, harga, SUM(jumlah) AS stok FROM barang_masuk GROUP BY barcode";
          ResultSet rs = stmt.executeQuery(sql);

          while (rs.next()) {
      %>
        <tr>
          <td><%= rs.getString("barcode") %></td>
          <td><%= rs.getString("nama") %></td>
          <td><%= rs.getString("kategori") %></td>
          <td><%= rs.getString("satuan") %></td>
          <td><%= java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("id", "ID")).format(rs.getDouble("harga")) %></td>
          <td><%= rs.getInt("stok") %></td>
        </tr>
      <%
          }
          rs.close();
          stmt.close();
          conn.close();
        } catch (Exception e) {
          out.println("<tr><td colspan='6' class='text-danger text-center'>Gagal mengambil data stok barang.</td></tr>");
        }
      %>
      </tbody>
    </table>
  </div>

  <%-- Laporan Barang Keluar Harian --%>
  <h4 class="mt-5">Laporan Barang Keluar (Per Hari)</h4>
  <div class="table-responsive">
    <table class="table table-bordered table-striped">
      <thead class="table-dark">
        <tr>
          <th>Tanggal</th>
          <th>Total Jumlah</th>
          <th>Total Harga</th>
        </tr>
      </thead>
      <tbody>
      <%
        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");
          Statement stmt = conn.createStatement();
          String sql = "SELECT DATE(tanggal_keluar) AS tanggal, SUM(jumlah) AS total_jumlah, SUM(jumlah * harga) AS total_harga FROM barang_keluar GROUP BY tanggal ORDER BY tanggal DESC";
          ResultSet rs = stmt.executeQuery(sql);

          while (rs.next()) {
      %>
        <tr>
          <td><%= rs.getString("tanggal") %></td>
          <td><%= rs.getInt("total_jumlah") %></td>
          <td><%= java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("id", "ID")).format(rs.getDouble("total_harga")) %></td>
        </tr>
      <%
          }
          rs.close();
          stmt.close();
          conn.close();
        } catch (Exception e) {
          out.println("<tr><td colspan='3' class='text-danger text-center'>Gagal mengambil data barang keluar.</td></tr>");
        }
      %>
      </tbody>
    </table>
  </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
