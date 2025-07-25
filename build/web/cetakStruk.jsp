<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Struk Pembelian</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .struk-wrapper {
            max-width: 400px;
            margin: 40px auto;
            padding: 30px;
            border: 1px dashed #333;
            background: #fff;
            font-family: monospace;
        }
        .text-center {
            text-align: center;
        }
        .struk-footer {
            margin-top: 20px;
            text-align: center;
            font-size: 12px;
        }
    </style>
</head>
<body class="bg-light">

<div class="struk-wrapper">
    <div class="text-center">
        <h5>MINIMARKET</h5>
        <p>Jl. Kulalet No. 123<br>Baleendah, Bandung, Indonesia</p>
        <hr>
        <h6>Struk Belannja</h6>
    </div>

<%
    String id = request.getParameter("id");
    if (id != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minimarket", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM barang_keluar WHERE id = ?");
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
%>
    <p><strong>Barcode:</strong> <%= rs.getString("barcode") %></p>
    <p><strong>Nama Barang:</strong> <%= rs.getString("nama") %></p>
    <p><strong>Jumlah:</strong> <%= rs.getInt("jumlah") %></p>
    <p><strong>Tanggal:</strong> <%= rs.getString("tanggal") %></p>

    <hr>
    <div class="struk-footer">
        <p>Terima kasih telah berbelanja!</p>
        <p><em><%= new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date()) %></em></p>
    </div>

    <script>
        window.onload = function() {
            window.print();
        };
    </script>

<%
            } else {
%>
    <p class="text-danger text-center">Data tidak ditemukan!</p>
<%
            }

            rs.close();
            conn.close();
        } catch (Exception e) {
%>
    <p class="text-danger text-center">Terjadi kesalahan: <%= e.getMessage() %></p>
<%
        }
    } else {
%>
    <p class="text-danger text-center">ID tidak ditemukan!</p>
<%
    }
%>

</div>
</body>
</html>
