package springwork.service;

import org.springframework.web.bind.annotation.RequestParam;
import springwork.entity.User;

import javax.servlet.http.HttpSession;
import java.util.Map;

public interface UserService {
    public void registerUser(@RequestParam Map<String, Object> params);
    public boolean checkUser (@RequestParam Map<String, Object> params);
    public User getUserByLogin(String email,String password);
    public boolean uploadImage(int idUser,byte[] imageData);
    public boolean updateProfilePersonal(@RequestParam Map<String, Object> params, int userId);
    public void uploadLogo(int idUser,byte[] imageData);
    public void updateCompanyOfAdmin(int idUser,@RequestParam Map<String, Object> params);
    public byte[]getAlogoCompanyByAdminUserId( int userId);
    public boolean isEmailExisted(String inputEmail);
    public void saveProfileToSessionHttp(HttpSession httpSession,@RequestParam Map<String, Object> params,int userId);
}
