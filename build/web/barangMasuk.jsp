<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Barang Masuk</title>
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

    <!-- Form Barang Masuk -->
    <div class="container mt-5">
        <% if (request.getParameter("mismatch") != null) { %>
    <div style="color: red;">Barcode sudah digunakan oleh nama barang lain. Cek kembali input Anda.</div>
<% } %>
<% if (request.getParameter("success") != null) { %>
    <div style="color: green;">Barang berhasil disimpan!</div>
<% } %>
<% if (request.getParameter("error") != null) { %>
    <div style="color: red;">Gagal menyimpan data. Cek koneksi/database.</div>
<% } %>


        <h2 class="mb-4 text-center">Form Barang Masuk</h2>
        <form action="BarangMasukServlet" method="post" class="bg-white p-4 shadow rounded">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="tanggal" class="form-label">Tanggal Masuk</label>
                    <input type="date" class="form-control" name="tanggal" required>
                </div>
                <div class="col-md-6">
                    <label for="barcode" class="form-label">Scan / Input Barcode</label>
                    <input type="text" class="form-control" name="barcode" placeholder="Contoh: 8999999012301" required>
                </div>
                <div class="col-md-6">
                    <label for="nama" class="form-label">Nama Barang</label>
                    <input type="text" class="form-control" name="nama" required>
                </div>
                <div class="col-md-6">
                    <label for="kategori" class="form-label">Kategori</label>
                    <input type="text" class="form-control" name="kategori">
                </div>
                <div class="col-md-6">
                    <label for="jumlah" class="form-label">Jumlah</label>
                    <input type="number" class="form-control" name="jumlah" required>
                </div>
                <div class="col-md-6">
                    <label for="satuan" class="form-label">Satuan</label>
                    <select class="form-select" name="satuan" required>
                        <option value="pcs">Pcs</option>
                        <option value="box">Box</option>
                        <option value="botol">Botol</option>
                        <option value="pack">Pack</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="harga" class="form-label">Harga Beli (opsional)</label>
                    <input type="number" class="form-control" name="harga" id="harga" required>
                    <small id="formatRupiah" class="text-muted"></small>
                </div>
                <div class="col-md-6">
                    <label for="supplier" class="form-label">Supplier</label>
                    <input type="text" class="form-control" name="supplier">
                </div>
                <div class="col-12">
                    <label for="keterangan" class="form-label">Keterangan</label>
                    <textarea class="form-control" name="keterangan" rows="2"></textarea>
                </div>
            </div>
            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-success px-5">Simpan</button>
            </div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
