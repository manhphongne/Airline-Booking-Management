package controller.usercontroller;

import dto.UserRegisterRequest;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import model.UserEntity;
import java.util.logging.Logger;
import service.UserService;
import service.impl.UserServiceImpl;
import validator.ValidatorUtils;

/**
 *
 * @author manhphong
 */
@WebServlet(name = "UserResgister", urlPatterns = {"/register"})
public class UserRegister extends HttpServlet {

    private static final Logger logger = Logger.getLogger(UserRegister.class.getName());
    private final UserService userService;

    public UserRegister() {
        this.userService = new UserServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String lastName = req.getParameter("lastName");
        String firstName = req.getParameter("firstName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String cornfirmPass = req.getParameter("cornfirmPass");

        //a list about infor of error
        Map<String, String> errors = new HashMap<>();

        if (ValidatorUtils.isStringEmpty(lastName) || ValidatorUtils.isStringEmpty(firstName)) {
            errors.put("firstName", "Vui lòng không để trống.");
        }

        if (!email.matches("^[A-Za-z0-9+_.-]{1,64}@[A-Za-z0-9.-]{1,255}\\.[A-Za-z]{2,6}$")) {
            errors.put("email", "Email không hợp lệ.");
        }

        if (password.length() < 6 || password.length() > 50) {
            errors.put("password", "Mật khẩu phải từ 6-50 ký tự.");
        }

        if (!checkPasswordAndRePassword(password, cornfirmPass)) {
            errors.put("rePassword", "Mật khẩu xác nhận không khớp.");
        }

        String url = "";
        // register successfull
        if (errors.isEmpty()) {
            
            UserEntity u = new UserEntity();
            
            UserRegisterRequest userRequest = new UserRegisterRequest(email, password, firstName, lastName);
            
            u.setEmail(email);
            u.setPassword(password);
            u.setFirstName(firstName);
            u.setLastName(lastName);

            
            
            try {
                long result = userService.register(u);
                if(result!=-1){
                    
                }
            } catch (Exception e) {
            }

            url = "home.jsp";
            req.getRequestDispatcher(url).forward(req, resp);

            logger.info("email: " + email + " registed successfull, id: " + u.getUserId());

        } else {
            req.setAttribute("errors", errors);
            logger.info("email: " + email + " can not register");
            url = "home.jsp";
            req.getRequestDispatcher(url).forward(req, resp);
        }
    }

    /**
     * check password
     *
     * @param pass
     * @param confPass
     * @return true if password and confirm password is same
     */
    public boolean checkPasswordAndRePassword(String pass, String confPass) {
        return pass.equals(confPass);
    }
}
