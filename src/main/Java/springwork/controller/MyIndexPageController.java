package springwork.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import springwork.service.EmailServiceImpl;
import springwork.entity.User;
import springwork.service.CVService;
import springwork.service.UserService;

import javax.servlet.http.HttpSession;
import java.util.Map;


@Controller
public class MyIndexPageController {
    @Autowired
    private UserService userService;
    @Autowired
    private EmailServiceImpl emailService;
    @Autowired
    private CVService cvService;
    @GetMapping("/")
    public String showMyIndexPage() {

        return "index";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam Map<String, Object> params, Model model){
        if (userService.checkUser(params)) {
            userService.registerUser(params);
            model.addAttribute("message", "Đăng ký thành công");
            model.addAttribute("messageType", "success");
        } else {
            model.addAttribute("message", "Đăng ký thất bại!");
            model.addAttribute("messageType", "error");
        }

        return "redirect:/";
    }


    /*
    *@param String email : The email which user inputted
    * @param String password :The password which user inputted
    * @param  HttpSession httpSession : the session which store data including logo, User, login
    * @param Model model : the model stores full name
     */

    @PostMapping("/login")
    public String showLoginForm(@RequestParam("email") String email, @RequestParam("password") String password,
                                HttpSession httpSession, Model model) {
        //byte[]dataLogo ="".getBytes();
        User user = userService.getUserByLogin(email, password);
        if (user != null) {
            if(user.getRole().getId()==2){
               byte[]dataLogo=  userService.getAlogoCompanyByAdminUserId(user.getId());
                httpSession.setAttribute("dataLogo",dataLogo);
            }
            else {
                //Add CV when user is a candidate
                byte[]dataCV = cvService.getDataCv(user.getId());
                httpSession.setAttribute("dataCV",dataCV);
            }
            // add Attribute "loggedIn" into session. The user already logged in
            httpSession.setAttribute("loggedIn", true);
            // add user Object into session
            httpSession.setAttribute("user", user);

            model.addAttribute("userFullName", user.getFullName());
        }

        return "redirect:/Home/intro";
    }





}
