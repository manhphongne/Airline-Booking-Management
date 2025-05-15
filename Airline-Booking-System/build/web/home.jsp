<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

        <script src="JS/home.js"></script>
        <link rel="stylesheet" href="CSS/home.css">
    </head>
    <body>

        <header class="main-header d-flex align-items-center justify-content-between mb-4 flex-wrap">
            <div class="logo-brand d-flex align-items-center gap-2">
                <img style="width: 90px; height: auto;" src="${pageContext.request.contextPath}/Image/logo.png" alt="Logo">
                <a href="home.jsp" class="brand-title">AirTicket</a>
            </div>
            <nav class="main-nav d-flex align-items-center flex-wrap">
                <a href="#">Khuyến mãi</a>
                <a href="#" class="active">Tìm chuyến bay</a>
                <a href="#">Đặt chỗ của tôi</a>
            </nav>
            <div class="d-flex align-items-center gap-2 mt-2 mt-md-0 account-group">
                <div class="dropdown">
                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                            aria-expanded="false" style="padding: 7px 20px; margin: 0 10px;">
                        Tiền tệ
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#"><b>VND</b> - Việt Nam đồng</a></li>
                        <li><a class="dropdown-item" href="#"><b>USD</b> - Đô La Mỹ</a></li>
                    </ul>
                </div>
                <% 
                    boolean isLoggedIn = false;
                    if (request.getSession(false) != null && request.getSession(false).getAttribute("loggedIn") != null) {
                        isLoggedIn = (Boolean) request.getSession(false).getAttribute("loggedIn");
                    }
                    if (isLoggedIn) { 
                %>
                <div class="dropdown account-btn">
                    <button class="btn btn-outline-primary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                        Tài khoản
                    </button>
                    <ul class="dropdown-menu account-menu">
                        <li><a class="dropdown-item" href="account.jsp">Trang quản lý tài khoản</a></li>
                        <li><a class="dropdown-item" href="orders.jsp">Đơn đặt của tôi</a></li>
                        <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
                    </ul>
                </div>
                <% } else { %>
                <button class="btn btn-outline-primary me-2" type="button" data-bs-toggle="modal"
                        data-bs-target="#loginModal">Đăng nhập</button>
                <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#registerModal" id="registerBtn"
                        style="padding: 8px 22px; color: white">Đăng ký</button>
                <% } %>
            </div>
        </header>

        <style>
            .error{
                color: red;
            }

        </style>

        <%-- register.jsp --%>
        <div class="modal fade register-modal"  id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" >
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center">
                        <h2>Đăng ký</h2>
                        <form method="POST" action="register" id="registerForm">
                            <div class="row mb-4">
                                <div class="col-md-6 ">
                                    <input type="text" id="lastName" class="form-control form-control-lg"
                                           placeholder="Họ" name="lastName" value="${param.lastName}" required/>
                                    <c:if test="${not empty errors.firstName}">
                                        <p class="error">${errors.firstName}</p>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <input type="text" id="firstName" class="form-control form-control-lg"
                                           placeholder="Tên" name="firstName" value="${param.firstName}" required/>
                                </div>
                            </div>
                            <div class="form-outline mb-4 mt-4">
                                <input type="email" id="email" class="form-control form-control-lg"
                                       placeholder="Vui lòng nhập email" name="email" value="${param.email}" required/>
                                <c:if test="${not empty errors.email}">
                                    <p class="error">${errors.email}</p>
                                </c:if>
                            </div>
                            <div class="form-outline mb-4">
                                <input type="password" id="password" class="form-control form-control-lg"
                                       placeholder="Vui lòng nhập mật khẩu" name="password" required onkeyup="checkPassword()"/>
                                <c:if test="${not empty errors.password}">
                                    <p class="error">${errors.password}</p>
                                </c:if>
                            </div>
                            <div class="form-outline mb-4">
                                <input type="password" id="rePassword" class="form-control form-control-lg"
                                       placeholder="Xác nhận mật khẩu" name="confirmPass" required onkeyup="checkPassword()"/>
                                <p class="error" id="errorPassword"></p>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block mb-3">Đăng ký</button>
                            <div class="register-divider"></div>
                            <p class="google-note">Nếu bạn đã có tài khoản Google</p>
                            <a href="#" class="btn-google">
                                <img src="Image/images.jpg" alt="Google" class="google-icon">
                                Đăng ký với Google
                            </a>

                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function checkPassword() {
                var password = document.getElementById("password").value;
                var rePassword = document.getElementById("rePassword").value;
                var errorText = document.getElementById("errorPassword");

                if (!password || !rePassword) {
                    errorText.innerHTML = ""; // Không hiển thị lỗi nếu chưa nhập đủ
                    return;
                }

                if (password !== rePassword) {
                    errorText.innerHTML = "Mật khẩu không khớp!";
                    errorText.style.color = "red";
                } else {
                    errorText.innerHTML = "";
                }
            }
        </script>


        <!-- Mở modal nếu có lỗi -->
        <c:if test="${not empty errors}">
            <script>
                const modal = new bootstrap.Modal(document.getElementById('registerModal'));
                modal.show();
            </script>
        </c:if>


        <!-- Login section modal -->
        <div class="modal fade login-modal" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center">
                        <h2>Đăng nhập</h2>
                        <form method="POST" action="Login">
                            <div class="form-outline mb-4 mt-2">
                                <input type="email" placeholder="Email" id="typeEmailX-2"
                                       class="form-control form-control-lg" name="email" />
                            </div>
                            <div class="form-outline mb-4">
                                <input type="password" placeholder="Password" id="typePasswordX-2"
                                       class="form-control form-control-lg" name="password"/>
                            </div>
                            <button class="btn btn-primary btn-lg btn-block" type="submit">Login</button>
                            <div class="register-divider"></div>
                            <p class="google-note mb-1">Hoặc</p>
                            <a href="#" class="btn-google">
                                <img src="Image/images.jpg" alt="Google" class="google-icon">
                                Đăng nhập với Google
                            </a>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <jsp:include page="booking.jsp"></jsp:include>
        
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>