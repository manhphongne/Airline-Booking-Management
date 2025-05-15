

package dao;

import model.UserEntity;

public interface UserDAO extends BaseDAO<UserEntity>{
    /**
     * find a user by email
     * @param email
     * @return a userEntity obejct
     */
    UserEntity findByEmail(String email);
    
    UserEntity findByEmailAndPassword(String email, String password);
}
