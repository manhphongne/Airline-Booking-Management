<%-- 
    Document   : login
    Created on : May 14, 2025, 5:19:09 AM
    Author     : manhphong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
            <!-- Login section modal -->
        <div class="modal fade login-modal" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center">
                        <h2>Đăng nhập</h2>
                        <form method="POST" action="Login">
                            <div class="form-outline mb-4">
                                <input type="email" placeholder="Email" id="typeEmailX-2"
                                       class="form-control form-control-lg" name="email" />
                            </div>
                            <div class="form-outline mb-4">
                                <input type="password" placeholder="Password" id="typePasswordX-2"
                                       class="form-control form-control-lg" name="password"/>
                            </div>
                            <button class="btn btn-primary btn-lg btn-block" type="submit">Login</button>
                            <p class="mt-4">hoặc đăng nhập bằng:</p>
                            <a href="#" class="btn-google">
                                <i class="fab fa-google"></i> Google
                            </a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
            
    </body>
</html>
