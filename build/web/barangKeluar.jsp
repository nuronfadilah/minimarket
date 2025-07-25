<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Barang Keluar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/barangKeluar.css" rel="stylesheet">
</head>
<body>
<% 
    request.setCharacterEncoding("UTF-8");
    String message = null;

    // Fungsi hapus langsung di sini
    if (request.getParameter("hapusId") != null) {
        int hapusId = Integer.parseInt(request.getParameter("hapusId"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");

            PreparedStatement ps = conn.prepareStatement("DELETE FROM barang_keluar WHERE id = ?");
            ps.setInt(1, hapusId);
            ps.executeUpdate();

            message = "Data berhasil dihapus.";
            conn.close();
        } catch (Exception e) {
            message = "Gagal menghapus data: " + e.getMessage();
        }
    }

    // Fungsi tambah
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String barcode = request.getParameter("barcode");
        int jumlahKeluar = Integer.parseInt(request.getParameter("jumlah"));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String tanggal = sdf.format(new Date());

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");

            PreparedStatement cek = conn.prepareStatement(
                "SELECT nama, SUM(jumlah) AS stok FROM barang_masuk WHERE barcode = ? GROUP BY barcode");
            cek.setString(1, barcode);
            ResultSet rs = cek.executeQuery();

            if (rs.next()) {
                int stok = rs.getInt("stok");
                String nama = rs.getString("nama");

                if (stok >= jumlahKeluar) {
                    PreparedStatement insert = conn.prepareStatement(
                        "INSERT INTO barang_keluar (barcode, nama, jumlah, tanggal) VALUES (?, ?, ?, ?)");
                    insert.setString(1, barcode);
                    insert.setString(2, nama);
                    insert.setInt(3, jumlahKeluar);
                    insert.setString(4, tanggal);
                    insert.executeUpdate();

                    PreparedStatement update = conn.prepareStatement(
                        "UPDATE barang_masuk SET jumlah = jumlah - ? WHERE barcode = ? LIMIT 1");
                    update.setInt(1, jumlahKeluar);
                    update.setString(2, barcode);
                    update.executeUpdate();

                    message = "Barang berhasil dikeluarkan.";
                } else {
                    message = "Stok tidak mencukupi!";
                }
            } else {
                message = "Barcode tidak ditemukan!";
            }

            conn.close();
        } catch (Exception e) {
            message = "Terjadi kesalahan: " + e.getMessage();
        }
    }
%>

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
    <h2 class="text-center">Barang Keluar</h2>

    <% if (message != null) { %>
        <div class="alert alert-info text-center"><%= message %></div>
    <% } %>

    <form method="post" class="bg-white p-4 shadow rounded mt-4">
        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label">Barcode</label>
                <input type="text" class="form-control" name="barcode" required>
            </div>
            <div class="col-md-6">
                <label class="form-label">Jumlah Keluar</label>
                <input type="number" class="form-control" name="jumlah" required>
            </div>
        </div>
        <div class="mt-4 text-center">
            <button type="submit" class="btn btn-primary px-5">Simpan</button>
        </div>
    </form>
</div>

<div class="container mt-5 mb-5">
    <h3 class="text-center mb-3">Riwayat Barang Keluar</h3>
    <div class="table-responsive bg-white p-4 shadow rounded">
        <table class="table table-bordered table-hover">
            <thead class="table-dark text-center">
                <tr>
                    <th>No</th>
                    <th>Barcode</th>
                    <th>Nama Barang</th>
                    <th>Jumlah</th>
                    <th>Tanggal</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int no = 1;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM barang_keluar ORDER BY tanggal DESC");

                        while (rs.next()) {
                %>
                <tr class="text-center">
                    <td><%= no++ %></td>
                    <td><%= rs.getString("barcode") %></td>
                    <td><%= rs.getString("nama") %></td>
                    <td><%= rs.getString("tanggal") %></td>
                    <td><%= rs.getInt("jumlah") %></td>
                    <td>
                        <a href="barangKeluar.jsp?hapusId=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Yakin ingin menghapus?')">Hapus</a>
                        <a href="cetakStruk.jsp?id=<%= rs.getInt("id") %>" class="btn btn-success btn-sm" target="_blank">Cetak Struk</a>
                    </td>
                </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' class='text-center text-danger'>Gagal memuat data.</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
