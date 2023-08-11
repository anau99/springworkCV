package springwork.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;
import springwork.entity.User;

import java.util.Map;


public interface UserDao {
    public boolean checkUser(@RequestParam Map<String, Object> params);
    public void registerUser(User user);

    public User getUserByLogin(String email,String password);

    public boolean uploadImage(int idUser,byte[] imageData);

    public boolean updateProfilePersonal(@RequestParam Map<String, Object> params, int userId);
    public void uploadLogo(int idUser,byte[] imageData);
    public void updateCompanyOfAdmin(int idUser,@RequestParam Map<String, Object> params);
    public byte[]getAlogoCompanyByAdminUserId( int userId);
    public boolean isEmailExisted(String inputEmail);



}
