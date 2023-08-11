package springwork.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import springwork.dao.UserDao;

import springwork.entity.Role;
import springwork.entity.User;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserDao userDao;

    @Override
    @Transactional
    public boolean checkUser (@RequestParam Map<String, Object> params){
        return userDao.checkUser(params);
    }
    @Override
    @Transactional
    public void registerUser(@RequestParam Map<String, Object> params) {
        User user = new User();
        user.setEmail(params.get("email").toString().trim());
        user.setFullName(params.get("fullName").toString().trim());
        Role role = new Role();
        role.setId(Integer.parseInt(params.get("role_id").toString()));
        user.setRole(role);
        String password = params.get("password").toString().trim();
        // Convert Password
        String encodedPassword = passwordEncoder.encode(password);
        user.setPassword(encodedPassword);
        userDao.registerUser(user);

        // Lưu thông tin người dùng vào CSDL
        //userRepository.save(user);

        // Gửi email xác nhận đến địa chỉ email của người dùng
        //String subject = "Xác nhận đăng ký tài khoản";
        //String text = "Xin chào " + user.getFullName() + ",\n\nCảm ơn bạn đã đăng ký tài khoản. Vui lòng xác nhận đăng ký bằng cách nhấn vào liên kết sau: http://your-website/confirm-registration?token=" + generateToken(user.getEmail());
        //emailService.sendConfirmationEmail(user.getEmail(), subject, text);
    }

    // Hàm generateToken để tạo mã token dùng cho việc xác nhận đăng ký
    // Có thể sử dụng UUID hoặc JWT để tạo token
//    private String generateToken(String email) {
//        // Implement your token generation logic here
//        return "";
//    }

    @Override
    @Transactional
    public User getUserByLogin(String email,String password){
       return userDao.getUserByLogin(email,password);
    }

    @Override
    @Transactional
    public boolean uploadImage(int idUser,byte[] imageData){
        return userDao.uploadImage(idUser,imageData);
    }

    @Override
    @Transactional
    public boolean updateProfilePersonal(@RequestParam Map<String, Object> params, int userId){

        return userDao.updateProfilePersonal( params,userId);
    }

    @Override
    @Transactional
    public void uploadLogo(int idUser,byte[] imageData){
         userDao.uploadLogo(idUser,imageData);
    }

    @Override
    @Transactional
    public void updateCompanyOfAdmin(int idUser,@RequestParam Map<String, Object> params){
         userDao.updateCompanyOfAdmin(idUser,params);
    }

    @Override
    @Transactional
    public byte[]getAlogoCompanyByAdminUserId( int userId){
        return userDao.getAlogoCompanyByAdminUserId(userId);
    }

    @Override
    @Transactional
    public boolean isEmailExisted(String inputEmail){
        return userDao.isEmailExisted(inputEmail);
    }

    /*Store personal information to httpSession
    * @HttpSession httpSession : the current session
    * @param Map<String, Object> params) : The information personal which we got
     */
    @Override
    public void saveProfileToSessionHttp(HttpSession httpSession, @RequestParam Map<String, Object> params, int userId){
        User user = (User) httpSession.getAttribute("user");
        user.setEmail(params.get("email").toString().trim());
        user.setFullName(params.get("fullName").toString().trim());
        user.setAddress(params.get("fullName").toString().trim());
        user.setPhoneNumber(params.get("phoneNumber").toString().trim());
        user.setDescription(params.get("description").toString().trim());
        httpSession.setAttribute("user",user);
    }





}
