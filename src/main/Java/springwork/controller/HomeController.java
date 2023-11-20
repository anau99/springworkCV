package springwork.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import springwork.entity.*;
import springwork.service.*;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

@Controller
@RequestMapping("/Home")
public class HomeController {
    @Autowired
    private RecruitmentService recruitmentService;
    @Autowired
    private CompanyService companyService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private SaveJobService saveJobService;
    @Autowired
    private FollowCompanyService followCompanyService;

    /*Output : List recruitment, top companies, top categories, HashSet id recruitment
    *
     */
    @GetMapping("/intro")

    public String showHome(Model theModel, HttpSession httpSession){
        //Storing the number of candidates, companies, addresses
        //Top 5 recruitment
        User user = (User) httpSession.getAttribute("user");
       /* if(user==null)
            return "redirect:/";*/
        if(user!=null && user.getRole().getId()==1){
            //we will search for all jobs that the user followed then save to map data structure
            HashSet<Integer> hashSetIdSaveJobs = saveJobService.findIDRecruitmentFollowedByUser(user.getId());
            httpSession.setAttribute("hashSetIdSaveJobs",hashSetIdSaveJobs);
            //Finding all companies that the user followed
            HashSet<Integer> hashSetIdCompaniesFollowed = followCompanyService.finIDCompaniesFollowedByUser(user.getId());
            httpSession.setAttribute("hashSetIdCompaniesFollowed",hashSetIdCompaniesFollowed);
        }
        List<Recruitment> listTopFive =  recruitmentService.getTopRecruitmentList();
        theModel.addAttribute("recruitments",listTopFive);
      //Companies are interested
        HashMap<Company,Integer> topCompanyFive = companyService.getTopCompanies();
        theModel.addAttribute("companies",topCompanyFive);
        //Get top categories
        List<Category> categoryList = categoryService.getListcategory();
        theModel.addAttribute("categories",categoryList);
        //The number of addresses (unique)
        int numberOfAddresses = recruitmentService.getNumberOfAddress(listTopFive);
        theModel.addAttribute("numberOfAddresses",numberOfAddresses);
        //the number of recruitments
        int numberOfRecruitment = listTopFive.size();
        theModel.addAttribute("numberOfRecruitment",numberOfRecruitment);
        // the number of companies (unique)
        int numberOfCompanies = recruitmentService.getNumberOfCompanies(listTopFive);
        theModel.addAttribute("numberOfCompanies",numberOfCompanies);

        return "home";
    }

    @GetMapping("/logout")
    public String logout( HttpSession httpSession) {
        //Delete session
        httpSession.invalidate();
        return "redirect:/";
    }

    @PostMapping("/search")
    public String showResult(@RequestParam("keySearch") String keySearch,Model theModel){
        //keySearch : company name or recruitment title or address
        List<Recruitment>recruitmentList = recruitmentService.searchResult(keySearch);
        if(recruitmentList.size()==0 || recruitmentList.isEmpty())
            return "redirect:/Home/intro";
        theModel.addAttribute("recruitments",recruitmentList);
        //The number of addresses (unique)
        int numberOfAddresses = recruitmentService.getNumberOfAddress(recruitmentList);
        theModel.addAttribute("numberOfAddresses",numberOfAddresses);
        //the number of recruitments
        int numberOfRecruitment = recruitmentList.size();
        theModel.addAttribute("numberOfRecruitment",numberOfRecruitment);
        // the number of companies (unique)
        int numberOfCompanies = recruitmentService.getNumberOfCompanies(recruitmentList);
        theModel.addAttribute("numberOfCompanies",numberOfCompanies);
        //get list Company
        HashMap<Company,Integer> getCompanyResult = companyService.getCompanyResult(recruitmentList);
        theModel.addAttribute("companies",getCompanyResult);
        return "home";
    }

    @GetMapping("/detail-company/{companyId}")
    public String detailCompany(@PathVariable int companyId,HttpSession httpSession,Model theModel){

       Company company =  companyService.getACompanyByCompanyId(companyId);
       theModel.addAttribute("company",company);

        return "detail-company";
    }







}
