package service;

import dto.UserRegisterRequest;
import java.util.Optional;
import model.UserEntity;

public interface UserService {

    /**
     * register new user
     *
     * @return id of new user
     */
    public long register(UserRegisterRequest user);

    /**
     * get user entity by id
     *
     * @param id
     * @return user entity
     */
    public UserEntity getUserByID(long id);

    boolean isEmailExist(String email);

    public Optional<UserEntity> getUserbyEmail(String email);

    public boolean login(UserEntity u);

}
