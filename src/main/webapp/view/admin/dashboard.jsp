<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.JSONArray" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: Arial;background: #f4f6f9; }
        .card {
            padding: 20px; margin: 20px;  background: white;
            border-radius: 10px; box-shadow: 0 2px 10px #ddd;
        }
        .grid { display: grid; margin: 10px;  grid-template-columns: repeat(3,1fr);}
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border-bottom: 1px solid #ddd; }
    </style>
</head>
<body>

<h1>📊 Admin Dashboard</h1>

<div class="grid">
    <div class="card">
        <h2>👥 Tổng người dùng</h2>
        <h1><%= request.getAttribute("totalUsers") %></h1>
    </div>
    <div class="card">
        <h2>📦 Tổng sản phẩm</h2>
        <h1><%= request.getAttribute("totalProducts") %></h1>
    </div>
    <div class="card">
        <h2>💰 Tổng doanh thu</h2>
        <h1><%= String.format("%,d", ((Number)request.getAttribute("totalRevenue")).longValue()) %> VND</h1>
    </div>
</div>

<%
    Map<String, Integer> revenue = (Map<String, Integer>) request.getAttribute("revenueByDay");
    List<Map<String, Object>> topUsers = (List<Map<String, Object>>) request.getAttribute("topUsers");
    List<Map<String, Object>> topProducts = (List<Map<String, Object>>) request.getAttribute("topProducts");
%>

<div style="display: grid; margin: 10px;  grid-template-columns: repeat(2,1fr);">
    <div class="card">
        <h2>📈 Doanh thu theo ngày</h2>
        <canvas id="lineChart"></canvas>
    </div>
    
    <div class="card">
        <h2>📦 Top sản phẩm tạo nhiều doanh thu nhất</h2>
        <canvas id="productBarChart"></canvas>
    </div>
</div>

<div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin-top:20px;">
    <div class="card">
        <h2>🟣 Phân bổ doanh thu theo top sản phẩm</h2>
        <canvas id="pieChartProduct"></canvas>
    </div>
    <div class="card">
        <h2>🔵 Phân bổ doanh thu theo top khách hàng</h2>
        <canvas id="pieChartCustomer"></canvas>
    </div>
</div>

<!-- Top khách hàng -->
<div class="card">
    <h2>🏆 Top khách hàng tiêu nhiều tiền nhất</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên khách hàng</th>
            <th>Đã tiêu (VND)</th>
        </tr>
        </thead>
        <tbody>
        <% for (Map<String, Object> u : topUsers) { %>
            <tr>
                <td><%= u.get("id") %></td>
                <td><%= u.get("name") %></td>
                <td><%= String.format("%,d", ((Number)u.get("spent")).longValue()) %> VND</td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>

<script>
    // --- Revenue by Day ---
    const revenueLabels = JSON.parse('<%= new JSONArray(revenue.keySet()).toString() %>');
    const revenueData = JSON.parse('<%= new JSONArray(revenue.values()).toString() %>');

    new Chart(document.getElementById("lineChart"), {
        type: "line",
        data: {
            labels: revenueLabels,
            datasets: [{
                label: "Doanh thu",
                data: revenueData,
                borderColor:'blue',
                backgroundColor:'rgba(0,0,255,0.2)',
                fill:true
            }]
        },
        options: {
            scales: {
                x: { title: { display: true, text: 'Ngày' } },
                y: { title: { display: true, text: 'Doanh thu (VND)' } }
            }
        }
    });

    // --- Top Products ---
    const topProductsJSON = JSON.parse('<%= new JSONArray(topProducts).toString() %>');
    const productLabels = topProductsJSON.map(p => p.name);
    const productData = topProductsJSON.map(p => p.revenue);

    new Chart(document.getElementById("productBarChart"), {
        type: "bar",
        data: {
            labels: productLabels,
            datasets: [{ label:"Doanh thu", data: productData, backgroundColor:'orange' }]
        },
        options: {
            scales: {
                y: { title: { display: true, text: 'Doanh thu (VND)' } }
            }
        }
    });

    // --- Pie Charts ---
    const colors = ['red','blue','green','orange','purple','yellow'];

    new Chart(document.getElementById("pieChartDay"), {
        type: 'pie',
        data: { labels: revenueLabels, datasets:[{ data: revenueData, backgroundColor: colors }] }
    });

    new Chart(document.getElementById("pieChartProduct"), {
        type: 'pie',
        data: { labels: productLabels, datasets:[{ data: productData, backgroundColor: colors }] }
    });

    const topUsersLabels = JSON.parse('<%= new JSONArray(topUsers.stream().map(u -> u.get("name")).toList()).toString() %>');
    const topUsersData = JSON.parse('<%= new JSONArray(topUsers.stream().map(u -> u.get("spent")).toList()).toString() %>');

    new Chart(document.getElementById("pieChartCustomer"), {
        type: 'pie',
        data: { labels: topUsersLabels, datasets:[{ data: topUsersData, backgroundColor: colors }] }
    });
</script>

</body>
</html>
