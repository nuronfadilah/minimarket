<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Dashboard MiniMarket</title>
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="#">MiniMarket</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav gap-2">
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
    <div class="text-center mb-5">
        <h1 class="dashboard-title">Selamat Datang, <%= username %>!</h1>
        <p class="text-muted">Kelola data barang dengan cepat, efisien, dan mudah.</p>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card card-hover">
                <div class="card-body text-center">
                    <h5 class="card-title">Barang Masuk</h5>
                    <p class="card-text">Tambah dan pantau barang yang masuk.</p>
                    <a href="barangMasuk.jsp" class="btn btn-primary">Akses</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-hover">
                <div class="card-body text-center">
                    <h5 class="card-title">Barang Keluar</h5>
                    <p class="card-text">Kelola barang yang keluar dari stok.</p>
                    <a href="barangKeluar.jsp" class="btn btn-warning">Akses</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-hover">
                <div class="card-body text-center">
                    <h5 class="card-title">Stok Barang</h5>
                    <p class="card-text">Cek jumlah stok barang saat ini.</p>
                    <a href="stokBarang.jsp" class="btn btn-success">Akses</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-hover">
                <div class="card-body text-center">
                    <h5 class="card-title">Riwayat Masuk</h5>
                    <p class="card-text">Lihat riwayat barang masuk sebelumnya.</p>
                    <a href="riwayatBarangMasuk.jsp" class="btn btn-info">Akses</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-hover">
                <div class="card-body text-center">
                    <h5 class="card-title">Laporan</h5>
                    <p class="card-text">Laporan transaksi dan rekap data.</p>
                    <a href="laporan.jsp" class="btn btn-dark">Akses</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
