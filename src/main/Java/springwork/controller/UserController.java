package springwork.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import springwork.datastructures.Validator;
import springwork.entity.Company;
import springwork.entity.Recruitment;
import springwork.entity.User;
import springwork.service.*;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;


@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    CVService cvService;
    @Autowired
    ApplyPostService applyPostService;
    @Autowired
    EmailService emailService;

    @Autowired
    SaveJobService saveJobService;

    @Autowired
    FollowCompanyService followCompanyService;

    @Autowired
    RecruitmentService recruitmentService;

    @Autowired
    CompanyService companyService;

    @GetMapping("/information")
    public String updateProfileUser (HttpSession httpSession){
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        return "profile";
    }

    /*
     @param :@RequestParam("file") MultipartFile file : getting a file which user sent (admin and user)
     */
    @PostMapping("/uploadImage")
    public String uploadImage(@RequestParam("file") MultipartFile file, HttpSession httpSession) {
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";

        User user = (User)httpSession.getAttribute("user");
        int idUser= user.getId();
        try {
            byte[]imageData = file.getBytes();
            user.setImage(imageData);
            //The httpSession stores image data into the session while the user is logging in.
            httpSession.setAttribute("user",user);
            boolean isOk =  userService.uploadImage(idUser,imageData);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return "profile"; //
    }

    /****************************************************ADMIN*************************************************/

    /* (Update personal information)
    *@params @RequestParam Map<String, Object> params: to be got information by Admin
    * @HttpSession httpSession : the session contains data until the user logged in
     */
    @PostMapping("/updateProfilePersonalAdmin")
    public String updateProfilePersonalAdmin(@RequestParam Map<String, Object> params, HttpSession httpSession, Model theModel) {
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        if (theModel.containsAttribute("messageError")) {
            String message = " ";
            theModel.addAttribute("messageError",message);
        }

        User user =(User) httpSession.getAttribute("user");
        int idUser = user.getId();

        //checking the email
        boolean isOk = false;
        if(!user.getEmail().equals(params.get("email").toString())) {
            //checking the email
            isOk = userService.isEmailExisted(params.get("email").toString());
        }

        if(!isOk){
            userService.saveProfileToSessionHttp(httpSession,params,idUser);
            userService.updateProfilePersonal(params,idUser);
        }
        else{
            String message = "Email này đã được sử dụng.";
            theModel.addAttribute("messageError", message);
        }
        return "profile";
    }
    /*Only for Admin (uploading company logo)
    *@param :@RequestParam("file") MultipartFile file : getting a file which admin sent
     */
    @PostMapping("/uploadImage2")
    public String uploadLogo(@RequestParam("file") MultipartFile file, HttpSession httpSession) {
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User)httpSession.getAttribute("user");
        int idUser= user.getId();
        if(user.getRole().getId()!=2)
            return "access-denied";//Memo
        try {
            byte[]dataLogo = file.getBytes();
            //The httpSession stores logo data into the session while the user is logging in.
            httpSession.setAttribute("dataLogo",dataLogo);
            userService.uploadLogo(idUser,dataLogo);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return "profile"; //
    }

    /*Only for Admin (uploading company information)
     *@param :@RequestParam Map<String, Object> params,: getting input data
     * @HttpSession httpSession : getting a httpsession at current time
     */
    @PostMapping("/updateCompany")
    public  String updateCompany(@RequestParam Map<String, Object> params, HttpSession httpSession){
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";

        User user = (User)httpSession.getAttribute("user");
        int idUser = user.getId();
        if(user.getRole().getId()!=2)
            return "access-denied";//Memo
       // byte[]dataLogo =(byte[]) httpSession.getAttribute("dataLogo");
        userService.updateCompanyOfAdmin(idUser,params);
        return "profile";
    }

     /*Only for Admin */
    /*@params  String paramsEmail : The email address will be sent by the email which register
    *@params Model theModel : The model store status of sending email
    *@HttpSession httpSession : httpSession will be check role of user.
     */
    @PostMapping("/Confirm-Account")
    public String sendEmail(@RequestParam("email") String paramsEmail, Model theModel,HttpSession httpSession){
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";

        User user = (User)httpSession.getAttribute("user");
        int idUser = user.getId();
        if(user.getRole().getId()!=2)
            return "access-denied";//Memo
        StringBuilder sb = new StringBuilder();
        sb.append("Đã xác thực thành công: ");
        sb.append("http://localhost:8080/ASM2/user/Confirm-Account");
        boolean isConfirmed = emailService.sendConfirmationEmail(paramsEmail,"WELCOME",sb.toString());
        theModel.addAttribute("isConfirmed",isConfirmed);

        return "profile";
    }




    /*******************************************************User*************************************************/

    @PostMapping("/updateProfileUser")
    public String updateProfileUser(@RequestParam Map<String, Object> params, HttpSession httpSession, Model theModel) {
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        if (theModel.containsAttribute("messageError")) {
            String message = " ";
            theModel.addAttribute("messageError",message);
        }

        User user =(User) httpSession.getAttribute("user");
        int idUser = user.getId();

        //checking the email
        boolean isOk = false;
        if(!user.getEmail().equals(params.get("email").toString())) {
            //checking the email
            isOk = userService.isEmailExisted(params.get("email").toString());
        }

        if(!isOk){
            userService.saveProfileToSessionHttp(httpSession,params,idUser);
            userService.updateProfilePersonal(params,idUser);

        }
        else{
            String message = "Email này đã được sử dụng.";
            theModel.addAttribute("messageError", message);
        }
        return "profile";
    }
    /*
    * @Param MultipartFile file : data of cv
    * @Param HttpSession httpSession : getting a httpsession at current time
     */
    @PostMapping("/uploadCV")
    public String uploadCV(@RequestParam("file") MultipartFile file, HttpSession httpSession) {
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User)httpSession.getAttribute("user");
        int idUser= user.getId();
        if(user.getRole().getId()!=1)
            return "access-denied";//Memo
        try {
            byte[]dataCV = file.getBytes();
            String fileName = file.getOriginalFilename();
            //Checking the idUSer is Existed in cv or not?
            int idCv = cvService.checkUserIsExistedInCv(idUser);
            if(idCv > 0){
                //Update the Cv
                cvService.updateCV(fileName,dataCV,idCv);
            }
            else{
                //Insert the Cv
                cvService.inSertCv(fileName,dataCV,idUser);
            }

           // if(user.getRole().getId()==1)
            httpSession.setAttribute("dataCV",dataCV);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return "profile"; //
    }

    @PostMapping("/applyJob")
    public String applyJob(HttpSession httpSession,@RequestParam Map<String, Object> params,
                           @RequestParam("file") MultipartFile file, Model model) throws IOException {
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User)httpSession.getAttribute("user");
        int idUser= user.getId();
        if(user.getRole().getId()!=1)
            return "access-denied";//Memo

        int idRecruitment = Integer.parseInt(params.get("idRecruitment").toString());
        String memo = "";
        //Checking apply
        boolean isOk = applyPostService.isApplied(idRecruitment,idUser);
        if(isOk){
            memo = "Bạn đã apply vị trí này rồi";
        }
        else {
            int idCv = cvService.checkUserIsExistedInCv(idUser);
            //Insert an apply Post
            //Case 1 : Using an CV which updated
            if(file.isEmpty()){
                String text = params.get("presentation").toString().trim();
                //Checking the user has created a CV in DB or not
                if(idCv > 0){
                    String nameCv = cvService.getNameCv(idCv);
                    applyPostService.insertAnApplyPost(idRecruitment,idUser,text,nameCv);
                    memo = "Đã ứng tuyển thành công";
                }
                else {
                    memo ="Bạn chưa có CV trên hệ thống";
                }
            }
            else {
                Validator validator = new Validator();
                if(!validator.isPDF(file.getBytes()) || !validator.isSizeLessThanFiveMB(file)){
                    memo = "Định dạng phải là PDF và có kích thước không quá 5MB";
                    model.addAttribute("memo", memo);
                    //return  "redirect:/Home/intro";
                }
                else {
                    //Case 2: update Cv and apply
                    byte[]dataCV = file.getBytes();
                    String fileName = file.getOriginalFilename();
                    //update new cv in session http
                    httpSession.setAttribute("dataCV",dataCV);
                    cvService.updateCV(fileName,dataCV,idCv);
                    String presentTwo = params.get("present").toString().trim();
                    applyPostService.insertAnApplyPost(idRecruitment,idUser,presentTwo,fileName);
                    memo = "Đã ứng tuyển thành công";
                }

            }
        }
        model.addAttribute("memo", memo);
        //Redirecting to save-jobs when user have accessed on save-jobs page
        if(params.containsKey("list-save-jobs")){
            return "redirect:/user/save-jobs";
        }
        //Redirecting to post-company when user have accessed on post-company page
        else if(params.containsKey("posts-company")){
            return "redirect:/user/list-post-company/"+ params.get("idCompany").toString();
        }


        return  "redirect:/Home/intro";

    }

    /**
     * Handles the user's follow or unfollow actions for certain recruitments and performs saving or deleting in the database.
     *
     * @param httpSession The current session at the given time.
     * @param params A map containing the recruitment ID.
     * @param theModel The model used to store a memo which show to user
     * @return A redirection to the introductory page after processing.
     * Implements the saving or deleting of recruitment status in the 'save_job' table of the database.
     */
    @PostMapping("/followJob")
    public String followJob(HttpSession httpSession,@RequestParam Map<String, Object> params, Model theModel){
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User)httpSession.getAttribute("user");
        int idUser= user.getId();
        if(user.getRole().getId()!=1)
            return "access-denied";//Memo
       //Using memo to report
        String memo = "";
       int recruitmentId =Integer.parseInt(params.get("recruitmentID").toString());
        HashSet<Integer> hashSetIdSaveJobs =(HashSet<Integer>) httpSession.getAttribute("hashSetIdSaveJobs");
       if(!hashSetIdSaveJobs.contains(recruitmentId)){
           hashSetIdSaveJobs.add(recruitmentId);
           //Insert DB
           saveJobService.insertASaveJob(recruitmentId,idUser);
           memo="Đã lưu thành công";
       }
       else {
           hashSetIdSaveJobs.remove(recruitmentId);
           //Delete DB
           saveJobService.deleteASaveJob(recruitmentId,idUser);
           memo="Đã bỏ theo dõi JOB thành công";
       }
        //Set hashSetIdSaveJobs
        httpSession.setAttribute("hashSetIdSaveJobs",hashSetIdSaveJobs);
        theModel.addAttribute("memo", memo);
        return  "redirect:/Home/intro";
    }


    /**
     * Handles the user's follow or unfollow actions for certain companies and performs saving or deleting in the database.
     *
     * @param httpSession The current session at the given time.
     * @param params A map containing the company ID.
     * @param theModel The model used to store a memo which show to user
     * @return A redirection to the introductory page after processing.
     * Implements the saving or deleting of company status in the 'follow_company' table of the database.
     */
    @PostMapping("/followCompany")
    public String followCompany(HttpSession httpSession,@RequestParam Map<String, Object> params, Model theModel){
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User)httpSession.getAttribute("user");
        int idUser= user.getId();
        if(user.getRole().getId()!=1)
            return "access-denied";//Memo
        //Using memo to report
        String memo = "";
        int companiesID =Integer.parseInt(params.get("companyID").toString());
        HashSet<Integer> hashSetIdCompaniesFollowed =(HashSet<Integer>) httpSession.getAttribute("hashSetIdCompaniesFollowed");
        if(!hashSetIdCompaniesFollowed.contains(companiesID)){
            hashSetIdCompaniesFollowed.add(companiesID);
            //Insert DB

            followCompanyService.insertAFollowCompany(companiesID,idUser);
            memo="Đã lưu thành công";
        }
        else {
            hashSetIdCompaniesFollowed.remove(companiesID);
            //Delete DB
            //saveJobService.deleteASaveJob(companiesID,idUser);
            followCompanyService.deleteAFollowCompany(companiesID,idUser);
            memo="Đã bỏ theo dõi Công ty thành công";
        }

        httpSession.setAttribute("hashSetIdCompaniesFollowed",hashSetIdCompaniesFollowed);
        theModel.addAttribute("memo", memo);
       // theModel.addAttribute("companyID",companiesID);
        return  "redirect:/Home/detail-company/"+companiesID;
    }

    @GetMapping("/save-jobs")
    public String saveJob(HttpSession httpSession, Model theModel ){
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User)httpSession.getAttribute("user");
        int idUser= user.getId();
        if(user.getRole().getId()!=1)
            return "access-denied";//Memo
        HashSet<Integer> hashSetIdSaveJobs =(HashSet<Integer>) httpSession.getAttribute("hashSetIdSaveJobs");
        List<Recruitment> recruitments = recruitmentService.getAListSaveJobsOrApplied(idUser,hashSetIdSaveJobs);
        theModel.addAttribute("recruitments",recruitments);

        return "list-save-job";
    }

    @GetMapping("/follow-companies")
    public String saveFollowedCompanies(HttpSession httpSession, Model theModel ){
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User)httpSession.getAttribute("user");
        int idUser= user.getId();
        if(user.getRole().getId()!=1)
            return "access-denied";//Memo

        HashSet<Integer> hashSetIdSaveJobs =(HashSet<Integer>)httpSession.getAttribute("hashSetIdSaveJobs");
        HashSet<Integer> hashSetIdCompaniesFollowed = (HashSet<Integer>)httpSession.getAttribute("hashSetIdCompaniesFollowed");
        List<Company>companies = companyService.getListCompaniesFollowed(hashSetIdSaveJobs,hashSetIdCompaniesFollowed);
        theModel.addAttribute("companies",companies);

        return "list-follow-company";
    }

    @GetMapping("/list-post-company/{companyId}")
    public String listPostCompany(@PathVariable int companyId, HttpSession httpSession, Model theModel){
        if(httpSession.getAttribute("loggedIn")==null
                || !(Boolean) httpSession.getAttribute("loggedIn")
                || httpSession.getAttribute("user")==null)
            return "redirect:/";
        User user = (User)httpSession.getAttribute("user");
        int idUser= user.getId();
        if(user.getRole().getId()!=1)
            return "access-denied";//Memo

        List<Recruitment>recruitments = recruitmentService.getRecruitmentListByIdCompany(companyId);
        theModel.addAttribute("recruitments",recruitments);

        String companyName = companyService.getACompanyNameByCompanyId(companyId);
        theModel.addAttribute("companyName",companyName);
        int idCompany = companyId;
        theModel.addAttribute("idCompany",idCompany);

        return "post-company";
    }







}
