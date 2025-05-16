<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Airline Booking</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
        }
        .sidebar {
            height: 100vh;
            position: fixed;
            width: 250px;
            background-color: #343a40;
            padding-top: 20px;
        }
        .sidebar a {
            color: #ffffff;
            padding: 15px;
            display: block;
            text-decoration: none;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #007bff;
            color: white;
            border-radius: 10px 10px 0 0;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .chart-container {
            position: relative;
            height: 350px;
            padding: 15px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }
        .chart-container canvas {
            transition: all 0.3s ease;
        }
        .chart-container:hover canvas {
            transform: scale(1.02);
        }
        .search-filter {
            max-width: 300px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h3 class="text-white text-center">Admin Panel</h3>
        <a href="#dashboard">Dashboard</a>
        <a href="#users">Quản lý người dùng</a>
        <a href="#coupons">Quản lý mã giảm giá</a>
        <a href="#bookings">Quản lý đặt vé</a>
        <a href="#flights">Quản lý chuyến bay</a>
        <a href="#seats">Quản lý ghế</a>
        <a href="#payments">Quản lý thanh toán</a>
        <a href="#exchange-rates">Quản lý tỷ giá</a>
        <a href="#airlines">Quản lý hãng hàng không</a>
        <a href="#airports">Quản lý sân bay</a>
        <a href="#reports">Báo cáo & Thống kê</a>
        <a href="#activity">Nhật ký hoạt động</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <!-- Dashboard Overview -->
        <section id="dashboard">
            <h2>Dashboard</h2>
            <div class="row">
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Tổng người dùng</h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Tổng đặt vé</h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Tổng chuyến bay</h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Thanh toán hoàn tất</h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- User Management -->
        <section id="users" class="mt-5">
            <h2>Quản lý người dùng</h2>
            <div class="mb-3">
                <input type="text" class="form-control search-filter d-inline" placeholder="Tìm kiếm người dùng..." id="userSearch">
            </div>
            <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addUserModal">Thêm người dùng</button>
            <div class="card">
                <div class="card-header">Danh sách người dùng</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Đăng nhập cuối</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        
                    </table>
                </div>
            </div>
        </section>

        <!-- Coupon Management -->
        <section id="coupons" class="mt-5">
            <h2>Quản lý mã giảm giá</h2>
            <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addCouponModal">Thêm mã giảm giá</button>
            <div class="card">
                <div class="card-header">Danh sách mã giảm giá</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Mã</th>
                                <th>Mô tả</th>
                                <th>Giảm giá</th>
                                <th>Trạng thái</th>
                                <th>Sử dụng</th>
                                <th>Hết hạn</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        
                    </table>
                </div>
            </div>
        </section>

        <!-- Booking Management -->
        <section id="bookings" class="mt-5">
            <h2>Quản lý đặt vé</h2>
            <div class="mb-3">
                <input type="text" class="form-control search-filter d-inline" placeholder="Tìm kiếm đặt vé..." id="bookingSearch">
                <select class="form-select search-filter d-inline">
                    <option value="">Lọc theo trạng thái</option>
                    <option>Pending</option>
                    <option>Confirmed</option>
                    <option>Cancelled</option>
                </select>
            </div>
            <div class="card">
                <div class="card-header">Danh sách đặt vé</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Mã đặt vé</th>
                                <th>Khách hàng</th>
                                <th>Mã giảm giá</th>
                                <th>Tổng tiền</th>
                                <th>Loại tiền</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        
                    </table>
                </div>
            </div>
        </section>

        <!-- Flight Management -->
        <section id="flights" class="mt-5">
            <h2>Quản lý chuyến bay</h2>
            <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addFlightModal">Thêm chuyến bay</button>
            <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#importFlightsModal">Nhập từ file Excel</button>
            <div class="card">
                <div class="card-header">Danh sách chuyến bay</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Mã chuyến</th>
                                <th>Hãng</th>
                                <th>Điểm đi</th>
                                <th>Điểm đến</th>
                                <th>Thời gian đi</th>
                                <th>Giá phổ thông</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Seat Management -->
        <section id="seats" class="mt-5">
            <h2>Quản lý ghế</h2>
            <div class="card">
                <div class="card-header">Danh sách ghế</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Chuyến bay</th>
                                <th>Số ghế</th>
                                <th>Hạng ghế</th>
                                <th>Trạng thái</th>
                                <th>Hành khách</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Payment Management -->
        <section id="payments" class="mt-5">
            <h2>Quản lý thanh toán</h2>
            <div class="card">
                <div class="card-header">Danh sách thanh toán</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Mã thanh toán</th>
                                <th>Mã đặt vé</th>
                                <th>Số tiền</th>
                                <th>Phương thức</th>
                                <th>Trạng thái</th>
                                <th>Thời gian</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Exchange Rate Management -->
        <section id="exchange-rates" class="mt-5">
            <h2>Quản lý tỷ giá hối đoái</h2>
            <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addExchangeRateModal">Thêm tỷ giá</button>
            <div class="card">
                <div class="card-header">Danh sách tỷ giá</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Từ</th>
                                <th>Đến</th>
                                <th>Tỷ giá</th>
                                <th>Cập nhật</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Airline Management -->
        <section id="airlines" class="mt-5">
            <h2>Quản lý hãng hàng không</h2>
            <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addAirlineModal">Thêm hãng</button>
            <div class="card">
                <div class="card-header">Danh sách hãng hàng không</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Mã hãng</th>
                                <th>Tên hãng</th>
                                <th>Liên hệ</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="airline" items="${airlines}">
                                <tr>
                                    
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Airport Management -->
        <section id="airports" class="mt-5">
            <h2>Quản lý sân bay</h2>
            <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addAirportModal">Thêm sân bay</button>
            <div class="card">
                <div class="card-header">Danh sách sân bay</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Mã sân bay</th>
                                <th>Tên sân bay</th>
                                <th>Vị trí</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Activity Log -->
        <section id="activity" class="mt-5">
            <h2>Nhật ký hoạt động</h2>
            <p class="text-muted">Phân tích tần suất hành động của khách hàng (đặt vé, hủy vé, sử dụng mã giảm giá).</p>
            <div class="mb-3">
                <input type="text" class="form-control search-filter d-inline" placeholder="Tìm kiếm log..." id="logSearch">
                <select class="form-select search-filter d-inline" id="logActionFilter">
                    <option value="">Lọc theo hành động</option>
                    <option value="create_booking">Tạo đặt vé</option>
                    <option value="cancel_booking">Hủy đặt vé</option>
                    <option value="apply_coupon">Sử dụng mã giảm giá</option>
                </select>
                <select class="form-select search-filter d-inline" id="logEntityFilter">
                    <option value="">Lọc theo thực thể</option>
                    <option value="Booking">Đặt vé</option>
                    <option value="Coupon">Mã giảm giá</option>
                </select>
            </div>
            <div class="card">
                <div class="card-header">Danh sách log khách hàng</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người thực hiện</th>
                                <th>Hành động</th>
                                <th>Thực thể</th>
                                <th>ID thực thể</th>
                                <th>Mô tả</th>
                                <th>Thời gian</th>
                                <th>IP</th>
                            </tr>
                        </thead>
                        
                    </table>
                </div>
            </div>
            <div class="card mt-4">
                <div class="card-header">Phân tích tần suất hành động của khách hàng</div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="activityChart"></canvas>
                    </div>
                </div>
            </div>
        </section>

        <!-- Reports & Analytics -->
        <section id="reports" class="mt-5">
            <h2>Báo cáo & Thống kê</h2>
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">Doanh thu theo tháng</div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">Tỷ lệ đặt vé</div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="bookingChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mt-4">
                    <div class="card">
                        <div class="card-header">Đặt vé theo điểm đến</div>
                        <div class="card-body]">
                            <div class="chart-container">
                                <canvas id="destinationChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mt-4">
                    <div class="card">
                        <div class="card-header">Tỷ lệ sử dụng mã giảm giá</div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="couponChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Modal for Adding User -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUserModalLabel">Thêm người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/addUser" method="post">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Vai trò</label>
                            <select class="form-select" name="role" required>
                                <option value="customer">Khách hàng</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Họ</label>
                            <input type="text" class="form-control" name="lastName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tên</label>
                            <input type="text" class="form-control" name="firstName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ngày sinh</label>
                            <input type="date" class="form-control" name="dob">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giới tính</label>
                            <select class="form-select" name="gender">
                                <option value="male">Nam</option>
                                <option value="female">Nữ</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" name="phone">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Quốc tịch</label>
                            <input type="text" class="form-control" name="nationality">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Editing User -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">Sửa người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/editUser" method="post">
                        <input type="hidden" name="id" id="editUserId">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" id="editUserEmail" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Vai trò</label>
                            <select class="form-select" name="role" id="editUserRole" required>
                                <option value="customer">Khách hàng</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Họ</label>
                            <input type="text" class="form-control" name="lastName" id="editUserLastName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tên</label>
                            <input type="text" class="form-control" name="firstName" id="editUserFirstName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ngày sinh</label>
                            <input type="date" class="form-control" name="dob" id="editUserDob">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giới tính</label>
                            <select class="form-select" name="gender" id="editUserGender">
                                <option value="male">Nam</option>
                                <option value="female">Nữ</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" name="phone" id="editUserPhone">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Quốc tịch</label>
                            <input type="text" class="form-control" name="nationality" id="editUserNationality">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Adding Coupon -->
    <div class="modal fade" id="addCouponModal" tabindex="-1" aria-labelledby="addCouponModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addCouponModalLabel">Thêm mã giảm giá</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/addCoupon" method="post">
                        <div class="mb-3">
                            <label class="form-label">Mã giảm giá</label>
                            <input type="text" class="form-control" name="code" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số tiền giảm</label>
                            <input type="number" step="0.01" class="form-control" name="discountAmount">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phần trăm giảm</label>
                            <input type="number" step="0.01" class="form-control" name="discountPercent">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số lần sử dụng tối đa</label>
                            <input type="number" class="form-control" name="maxUses">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ngày bắt đầu</label>
                            <input type="datetime-local" class="form-control" name="startDate">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ngày hết hạn</label>
                            <input type="datetime-local" class="form-control" name="expiryDate">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Trạng thái</label>
                            <select class="form-select" name="status">
                                <option value="active">Active</option>
                                <option value="expired">Expired</option>
                                <option value="cancelled">Cancelled</option>
                            </select>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Adding Flight -->
    <div class="modal fade" id="addFlightModal" tabindex="-1" aria-labelledby="addFlightModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addFlightModalLabel">Thêm chuyến bay</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/addFlight" method="post">
                        <div class="mb-3">
                            <label class="form-label">Hãng hàng không</label>
                            <select class="form-select" name="airlineCode">
                                
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Sân bay đi</label>
                            <select class="form-select" name="departureAirportCode">
                                
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Sân bay đến</label>
                            <select class="form-select" name="arrivalAirportCode">
                                
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Thời gian đi</label>
                            <input type="datetime-local" class="form-control" name="departureTime">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Thời gian đến</label>
                            <input type="datetime-local" class="form-control" name="arrivalTime">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giá phổ thông</label>
                            <input type="number" step="0.01" class="form-control" name="economyPrice">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giá thương gia</label>
                            <input type="number" step="0.01" class="form-control" name="businessPrice">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tỷ giá</label>
                            <select class="form-select" name="currencyPair">
                                
                            </select>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Importing Flights -->
    <div class="modal fade" id="importFlightsModal" tabindex="-1" aria-labelledby="importFlightsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="importFlightsModalLabel">Nhập chuyến bay từ file Excel</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="importFlightsForm" action="${pageContext.request.contextPath}/admin/importFlights" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label">Chọn file Excel</label>
                            <input type="file" class="form-control" id="flightExcelFile" name="excelFile" accept=".xlsx,.xls" required>
                        </div>
                        <div class="mb-3">
                            <p class="text-muted">File Excel cần có sheet "Flights" với các cột: airline_code, flight_number, departure_airport_code, arrival_airport_code, departure_time, arrival_time, economy_price, business_price, currency_from, currency_to</p>
                            <a href="${pageContext.request.contextPath}/sample_flights.xlsx" download>Tải mẫu Excel</a>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-success">Tải lên</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Adding Exchange Rate -->
    <div class="modal fade" id="addExchangeRateModal" tabindex="-1" aria-labelledby="addExchangeRateModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addExchangeRateModalLabel">Thêm tỷ giá</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/addExchangeRate" method="post">
                        <div class="mb-3">
                            <label class="form-label">Từ tiền tệ</label>
                            <select class="form-select" name="fromCurrency">
                                <option>USD</option>
                                <option>VND</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Đến tiền tệ</label>
                            <select class="form-select" name="toCurrency">
                                <option>VND</option>
                                <option>USD</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tỷ giá</label>
                            <input type="number" step="0.0001" class="form-control" name="rate">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Adding Airline -->
    <div class="modal fade" id="addAirlineModal" tabindex="-1" aria-labelledby="addAirlineModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addAirlineModalLabel">Thêm hãng hàng không</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/addAirline" method="post">
                        <div class="mb-3">
                            <label class="form-label">Tên hãng</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mã hãng</label>
                            <input type="text" class="form-control" name="code" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số liên hệ</label>
                            <input type="text" class="form-control" name="contact">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Adding Airport -->
    <div class="modal fade" id="addAirportModal" tabindex="-1" aria-labelledby="addAirportModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addAirportModalLabel">Thêm sân bay</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/addAirport" method="post">
                        <div class="mb-3">
                            <label class="form-label">Mã sân bay</label>
                            <input type="text" class="form-control" name="code" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tên sân bay</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Vị trí</label>
                            <input type="text" class="form-control" name="location">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Chart.js Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toast Notification
        function showToast(message, type = 'success') {
            const toast = document.createElement('div');
            toast.className = 'position-fixed bottom-0 end-0 p-3';
            toast.style.zIndex = '11';
            toast.innerHTML = `
                <div class="toast align-items-center text-white bg-${type} border-0" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">${message}</div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            `;
            document.body.appendChild(toast);
            new bootstrap.Toast(toast.querySelector('.toast')).show();
        }

        // Load User Data for Edit Modal
        function loadUserData(userId) {
            fetch(`${pageContext.request.contextPath}/admin/getUser?id=${userId}`)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('editUserId').value = data.id;
                    document.getElementById('editUserEmail').value = data.email;
                    document.getElementById('editUserRole').value = data.role;
                    document.getElementById('editUserLastName').value = data.lastName;
                    document.getElementById('editUserFirstName').value = data.firstName;
                    document.getElementById('editUserDob').value = data.dob;
                    document.getElementById('editUserGender').value = data.gender;
                    document.getElementById('editUserPhone').value = data.phone;
                    document.getElementById('editUserNationality').value = data.nationality;
                })
                .catch(error => showToast('Lỗi khi tải dữ liệu người dùng', 'danger'));
        }

        // Placeholder functions for CRUD operations
        function deleteUser(id) { /* Implement DELETE request */ }
        function editCoupon(code) { /* Implement GET and populate modal */ }
        function deleteCoupon(code) { /* Implement DELETE request */ }
        function viewBooking(id) { /* Implement GET request */ }
        function editBooking(id) { /* Implement GET and populate modal */ }
        function cancelBooking(id) { /* Implement POST request */ }
        function editFlight(id) { /* Implement GET and populate modal */ }
        function deleteFlight(id) { /* Implement DELETE request */ }
        function editSeat(id) { /* Implement GET and populate modal */ }
        function viewPayment(id) { /* Implement GET request */ }
        function editRate(id) { /* Implement GET and populate modal */ }
        function deleteRate(id) { /* Implement DELETE request */ }
        function editAirline(code) { /* Implement GET and populate modal */ }
        function deleteAirline(code) { /* Implement DELETE request */ }
        function editAirport(code) { /* Implement GET and populate modal */ }
        function deleteAirport(code) { /* Implement DELETE request */ }

        // Revenue Chart
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: [<c:forEach var="month" items="${revenueData.labels}">'${month}',</c:forEach>],
                datasets: [{
                    label: 'Doanh thu (VND)',
                    data: [<c:forEach var="amount" items="${revenueData.values}">${amount},</c:forEach>],
                    borderColor: '#007bff',
                    backgroundColor: 'rgba(0, 123, 255, 0.1)',
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#ffffff',
                    pointBorderColor: '#007bff',
                    pointBorderWidth: 2,
                    pointRadius: 5,
                    pointHoverRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { labels: { font: { size: 14, weight: 'bold' } } },
                    tooltip: { backgroundColor: '#343a40', titleFont: { size: 14 }, bodyFont: { size: 12 }, padding: 10, cornerRadius: 5 }
                },
                scales: {
                    x: { grid: { display: false }, title: { display: true, text: 'Tháng', font: { size: 14, weight: 'bold' } } },
                    y: { grid: { color: '#e9ecef' }, title: { display: true, text: 'Doanh thu (VND)', font: { size: 14, weight: 'bold' } }, beginAtZero: true }
                },
                animation: { duration: 1500, easing: 'easeInOutQuart' }
            }
        });

        // Booking Chart
        const bookingCtx = document.getElementById('bookingChart').getContext('2d');
        new Chart(bookingCtx, {
            type: 'doughnut',
            data: {
                labels: ['Đã xác nhận', 'Đã hủy', 'Đang chờ'],
                datasets: [{
                    data: [<c:forEach var="value" items="${bookingData.values}">${value},</c:forEach>],
                    backgroundColor: ['#28a745', '#dc3545', '#ffc107'],
                    borderColor: ['#ffffff', '#ffffff', '#ffffff'],
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom', labels: { font: { size: 14, weight: 'bold' }, padding: 20 } },
                    tooltip: { backgroundColor: '#343a40', titleFont: { size: 14 }, bodyFont: { size: 12 }, padding: 10, cornerRadius: 5 }
                },
                animation: { animateScale: true, animateRotate: true, duration: 1500, easing: 'easeInOutQuart' },
                cutout: '60%'
            }
        });

        // Destination Chart
        const destinationCtx = document.getElementById('destinationChart').getContext('2d');
        new Chart(destinationCtx, {
            type: 'bar',
            data: {
                labels: [<c:forEach var="dest" items="${destinationData.labels}">'${dest}',</c:forEach>],
                datasets: [{
                    label: 'Số lượng đặt vé',
                    data: [<c:forEach var="count" items="${destinationData.values}">${count},</c:forEach>],
                    backgroundColor: '#17a2b8',
                    borderColor: '#ffffff',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { labels: { font: { size: 14, weight: 'bold' } } },
                    tooltip: { backgroundColor: '#343a40', padding: 10 }
                },
                scales: {
                    y: { beginAtZero: true, title: { display: true, text: 'Số lượng' } },
                    x: { title: { display: true, text: 'Điểm đến' } }
                },
                animation: { duration: 1500, easing: 'easeInOutQuart' }
            }
        });

        // Coupon Usage Chart
        const couponCtx = document.getElementById('couponChart').getContext('2d');
        new Chart(couponCtx, {
            type: 'bar',
            data: {
                labels: [<c:forEach var="code" items="${couponData.labels}">'${code}',</c:forEach>],
                datasets: [{
                    label: 'Số lần sử dụng',
                    data: [<c:forEach var="count" items="${couponData.values}">${count},</c:forEach>],
                    backgroundColor: '#6610f2',
                    borderColor: '#ffffff',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { labels: { font: { size: 14, weight: 'bold' } } },
                    tooltip: { backgroundColor: '#343a40', padding: 10 }
                },
                scales: {
                    y: { beginAtZero: true, title: { display: true, text: 'Số lần sử dụng' } },
                    x: { title: { display: true, text: 'Mã giảm giá' } }
                },
                animation: { duration: 1500, easing: 'easeInOutQuart' }
            }
        });

        // Activity Chart
        const activityCtx = document.getElementById('activityChart').getContext('2d');
        new Chart(activityCtx, {
            type: 'bar',
            data: {
                labels: [<c:forEach var="date" items="${activityData.labels}">'${date}',</c:forEach>],
                datasets: [
                    { label: 'Tạo đặt vé', data: [<c:forEach var="count" items="${activityData.createBooking}">${count},</c:forEach>], backgroundColor: '#007bff' },
                    { label: 'Hủy đặt vé', data: [<c:forEach var="count" items="${activityData.cancelBooking}">${count},</c:forEach>], backgroundColor: '#dc3545' },
                    { label: 'Sử dụng mã giảm giá', data: [<c:forEach var="count" items="${activityData.applyCoupon}">${count},</c:forEach>], backgroundColor: '#28a745' }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { labels: { font: { size: 14, weight: 'bold' } } },
                    tooltip: { backgroundColor: '#343a40', padding: 10 }
                },
                scales: {
                    y: { beginAtZero: true, title: { display: true, text: 'Số lần' } },
                    x: { title: { display: true, text: 'Ngày' } }
                },
                animation: { duration: 1500, easing: 'easeInOutQuart' }
            }
        });

        // Search and Filter for Activity Log
        function filterLogs() {
            const searchTerm = document.getElementById('logSearch').value.toLowerCase();
            const actionFilter = document.getElementById('logActionFilter').value;
            const entityFilter = document.getElementById('logEntityFilter').value;
            const rows = document.querySelectorAll('#activity tbody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                const action = row.cells[2].textContent.toLowerCase();
                const entity = row.cells[3].textContent.toLowerCase();
                const matchesSearch = text.includes(searchTerm);
                const matchesAction = !actionFilter || action.includes(actionFilter.toLowerCase());
                const matchesEntity = !entityFilter || entity.includes(entityFilter.toLowerCase());
                row.style.display = matchesSearch && matchesAction && matchesEntity ? '' : 'none';
            });
        }

        document.getElementById('logSearch').addEventListener('input', filterLogs);
        document.getElementById('logActionFilter').addEventListener('change', filterLogs);
        document.getElementById('logEntityFilter').addEventListener('change', filterLogs);

        // Search for Users
        document.getElementById('userSearch').addEventListener('input', function (e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#users tbody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });

        // Search for Bookings
        document.getElementById('bookingSearch').addEventListener('input', function (e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#bookings tbody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>