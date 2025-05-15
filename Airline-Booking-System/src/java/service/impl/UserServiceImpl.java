package service.impl;

import enums.Role;
import controller.usercontroller.UserRegister;
import dao.UserDAOImpl;
import java.time.LocalDateTime;
import java.util.logging.Logger;
import model.UserEntity;
import service.UserService;
import util.PasswordEncryption;
import validator.ValidatorUtils;

public class UserServiceImpl implements UserService {

    private UserDAOImpl userDAO;
    private static final Logger logger = Logger.getLogger(UserRegister.class.getName());

    public UserServiceImpl() {
        this.userDAO = new UserDAOImpl();
    }

    @Override
    public long register(UserEntity userEntity) {
        // check email exist

        logger.info("after check exist: " + userEntity.getEmail());

        if (isEmailExist(userEntity.getEmail())) {
            return -1;
        }
        logger.info("before check exist: " + userEntity.getEmail());

        //userEntity.setPassword(PasswordEncryption.doSha256(userEntity.getPassword()));
        userEntity.setRole(Role.CUSTOMER);
        userEntity.setCreateAt(LocalDateTime.now());
        userEntity.setUpdatedAt(LocalDateTime.now());
        userEntity.setLastLogin(LocalDateTime.now());

        userDAO.insert(userEntity);

        return userEntity.getUserId();
    }

    @Override
    public boolean isEmailExist(String email) {
        return userDAO.isEmailExist(email);
    }

    
    @Override
    public UserEntity getUserByID(long id) {
        return null;

    }

    @Override
    public UserEntity getUserbyEmail(String email) {
        return userDAO.findByEmail(email);
    }

    @Override
    public boolean login(UserEntity u) {

        boolean login = false;

//        UserEntity user = userDAO.findByEmailAndPassword(u.getEmail(), PasswordEncryption.doSha256(u.getPassword()));
        UserEntity user = userDAO.findByEmailAndPassword(u.getEmail(), u.getPassword());
        if (user != null) {
            login = true;
        }

        return login;
    }


}
