package service;

import model.UserEntity;

public interface UserService {

    /**
     * register new user
     *
     * @return id of new user
     */
    public long register(UserEntity user);

    /**
     * get user entity by id
     *
     * @param id
     * @return user entity
     */
    public UserEntity getUserByID(long id);

    boolean isEmailExist(String email);

    public UserEntity getUserbyEmail(String email);

    public boolean login(UserEntity u);

}
