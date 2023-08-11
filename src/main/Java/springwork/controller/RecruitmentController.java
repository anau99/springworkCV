package springwork.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import springwork.entity.Category;
import springwork.entity.Recruitment;
import springwork.entity.User;
import springwork.service.CategoryService;
import springwork.service.RecruitmentService;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/recruitment")
public class RecruitmentController {
    @Autowired
    RecruitmentService recruitmentService;
    @Autowired
    CategoryService categoryService;
    /*
    *@param HttpSession httpSession : The current session
     */
    @GetMapping("/post-list")
    public String postList (HttpSession httpSession, Model theModel){
        //No login
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User) httpSession.getAttribute("user");
        if(user.getRole().getId() !=2)
            return "access-denied";// xử lý ở page access denied
        StringBuilder nameCompany = new StringBuilder();
        List<Recruitment> recruitmentList = recruitmentService.getListRecruitmentByUser(user.getId(),nameCompany);
        theModel.addAttribute("nameCompany",nameCompany.toString());
        theModel.addAttribute("recruitments",recruitmentList);

        return "post-list";
    }

    @GetMapping("/post")
    public String visitFormPostPage(HttpSession httpSession,Model theModel){
        //No login
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User) httpSession.getAttribute("user");
        if(user.getRole().getId() !=2)
            return "access-denied";// xử lý ở page access denied
        //Reading all categories
        List<Category> categories = categoryService.getListcategory();
        theModel.addAttribute("categories",categories);


        return "post-job";
    }

    @PostMapping("/postARecruitment")
    public String createARecruitment(HttpSession httpSession,@RequestParam Map<String, Object> params)
            throws ParseException {
        //No login
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User) httpSession.getAttribute("user");
        if(user.getRole().getId() !=2)
            return "access-denied";// xử lý ở page access denied
        int userId = user.getId();
        recruitmentService.creatARecruitment(userId,params);

        return "redirect:/recruitment/post-list";
    }

    /*
    *@param HttpSession httpSession : The current session
    * @RequestParam("id") int idRec : The id of the recruitment which the admin choose
     */
    @GetMapping("/editPost")
    public String editARecruitment(@RequestParam("id") int idRec, HttpSession httpSession,Model theModel){
        //No login
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User) httpSession.getAttribute("user");
        if(user.getRole().getId() !=2)
            return "access-denied";// xử lý ở page access denied

       Recruitment recruitment = recruitmentService.getARecruitmentByidRec(idRec);
        List<Category> categories = categoryService.getListcategory();
       theModel.addAttribute("recruitment",recruitment);
       theModel.addAttribute("categories",categories);

        return "edit-job";
    }

    @PostMapping("/editARecruitment")
    public String editARecruitment(@RequestParam Map<String, Object> params,
                                   HttpSession httpSession) throws ParseException {
        //No login
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User) httpSession.getAttribute("user");
        if(user.getRole().getId() !=2)
            return "access-denied";// xử lý ở page access denied
        int idRec=Integer.parseInt(params.get("id").toString());
        recruitmentService.updateARecruitment(params,idRec);
        return "redirect:/recruitment/post-list";

    }

    @PostMapping("/deleteAPost")
    public String deleteApost(HttpSession httpSession,@RequestParam("id") int idRec ){
        //No login
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User) httpSession.getAttribute("user");
        if(user.getRole().getId() !=2)
            return "access-denied";// xử lý ở page access denied
        recruitmentService.deleteApost(idRec);
        return "redirect:/recruitment/post-list";
    }

}
