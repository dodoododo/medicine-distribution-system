<%@ include file="header.jsp" %>

<main class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header text-center">
                    <h4><i class="fas fa-user-md icon-med"></i> Thông tin cá nhân</h4>
                </div>
                <div class="card-body">
                    <div class="text-center mb-4">
                        <img src="https://via.placeholder.com/150?text=Avatar" alt="Avatar" class="rounded-circle">
                    </div>
                    <form action="/UpdateProfileServlet" method="POST"> <!-- Giả sử servlet update -->
                        <div class="mb-3">
                            <label for="name" class="form-label">Tên</label>
                            <input type="text" class="form-control" id="name" name="name" value="Tên người dùng" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="email@example.com" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="0123456789" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ nhận hàng</label>
                            <textarea class="form-control" id="address" name="address" rows="3">Địa chỉ hiện tại</textarea>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Cập nhật</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>