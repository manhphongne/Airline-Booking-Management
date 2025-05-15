package dao;

import enums.Gender;
import enums.Role;
import controller.usercontroller.UserRegister;
import database.DBContext;
import java.util.List;
import model.UserEntity;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.function.Supplier;
import java.util.logging.Logger;

public class UserDAOImpl implements UserDAO {

    private DBContext dbContext;
    private static final Logger logger = Logger.getLogger(UserRegister.class.getName());

    public UserDAOImpl() {
        this.dbContext = new DBContext();
    }

    @Override
    /**
     * Step 1: create a connection to database Step 2: Create a
     * PreparedStatement Step 3: Excute PreparedStatement Step 4: Close
     * connection
     */
    public UserEntity findByID(Long id) {
        UserEntity user = null;
        String sql = "select * from [User] where user_id = ?";
        try (Connection conn = dbContext.getConn(); PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setLong(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new UserEntity(
                        rs.getLong("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        Role.valueOf(rs.getString("role")),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getTimestamp("date_of_birth").toLocalDateTime().toLocalDate(),
                        Gender.valueOf(rs.getString("gender")),
                        rs.getString("phone"),
                        rs.getString("nationality"),
                        rs.getTimestamp("create_at").toLocalDateTime(),
                        rs.getTimestamp("update_at").toLocalDateTime(),
                        rs.getTimestamp("last_login").toLocalDateTime());
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public boolean insert(UserEntity u) {

        // Step 1: create a connection to database
        Connection conn = dbContext.getConn();
        try {
            // Step 2: create statement object
            String sql = "INSERT INTO [User] (email, password, role, first_name, "
                    + "last_name, create_at, update_at, last_login) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, u.getEmail());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getRole().toString());
            ps.setString(4, u.getFirstName());
            ps.setString(5, u.getLastName());
            ps.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now()));
            ps.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));
            ps.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));

            // Step 3: execute SQL statement
            if (ps.executeUpdate() == 1) { // executeUpdate tra ve so luong hang bi anh huong
                logger.info("Luu thanh cong:" + u.toString());
                return true;
            }
            // Step 4: close connection
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public UserEntity findByEmail(String email) {
        //step 1: get connection
        //step 2: create preparedStatement object
        //step 3: excute SQL
        //step 4: close connection
        UserEntity u = null;
        try {
            Connection conn = dbContext.getConn();
            String sql = "select * from [User] where email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                long user_id = rs.getLong("user_id");
                if (rs.wasNull()) {
                    return null;
                }

                LocalDate dob = rs.getTimestamp("date_of_birth") != null
                        ? rs.getTimestamp("date_of_birth").toLocalDateTime().toLocalDate()
                        : null;

                Gender gender = rs.getString("gender") != null
                        ? Gender.valueOf(rs.getString("gender"))
                        : null;

                String phone = rs.getString("phone");
                String nationality = rs.getString("nationality");

                u = new UserEntity(
                        rs.getLong("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        Role.valueOf(rs.getString("role")),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        dob,
                        gender,
                        phone,
                        nationality,
                        rs.getTimestamp("create_at").toLocalDateTime(),
                        rs.getTimestamp("update_at").toLocalDateTime(),
                        rs.getTimestamp("last_login").toLocalDateTime());

            }

            logger.info("\nTìm kiếm thành công bằng email:" + u.toString());
            rs.close();
            conn.close();

        } catch (SQLException e) {
            logger.info((Supplier<String>) e);
        }
        return u;
    }

    public boolean isEmailExist(String email) {
        boolean isExist = false;
        String sql = "select * from [User] where email = ?";
        try (Connection conn = dbContext.getConn(); PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                isExist = true;
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isExist;
    }

    @Override
    public void update(UserEntity entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void deleteByID(long id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<UserEntity> selectByCondition() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public UserEntity findByEmailAndPassword(String email, String password) {

        /**
         * Step 1: create a connection to database Step 2: Create a
         * PreparedStatement Step 3: Excute PreparedStatement Step 4: Close
         * connection
         */
        UserEntity userEntity = null;
        String sql = "Select * from [User] where email = ? and password = ?";

        try (Connection conn = dbContext.getConn(); PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                userEntity = new UserEntity();
                userEntity.setEmail(rs.getString("email"));
                userEntity.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return userEntity;
    }
}
