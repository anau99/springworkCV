package springwork.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import springwork.dao.RecruitmentDao;
import springwork.entity.Category;
import springwork.entity.Recruitment;

import javax.persistence.criteria.CriteriaBuilder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class RecruitmentServiceImpl implements RecruitmentService {
    @Autowired
    private RecruitmentDao recruitmentDao;
    @Override
    @Transactional
    public List<Recruitment> getTopRecruitmentList(){
        return recruitmentDao.getTopRecruitmentList();
    }

    @Override
    @Transactional
    public List<Recruitment> getListRecruitmentByUser(int userId, StringBuilder nameCompany){
        return recruitmentDao.getListRecruitmentByUser(userId, nameCompany);
    }

    @Override
    @Transactional
    public void creatARecruitment( int userId,@RequestParam Map<String, Object> params) throws ParseException {
        Recruitment recruitment = new Recruitment();
        recruitment.setTitle(params.get("title").toString().trim());
        recruitment.setDescription(params.get("description").toString().trim());
        recruitment.setExperience(params.get("experience").toString().trim());
        recruitment.setQuantity(Integer.parseInt(params.get("quantity").toString()));
        recruitment.setAddress(params.get("address").toString().trim());
        // Set CurrentDate
        Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        String formattedDate = dateFormat.format(currentDate);
        recruitment.setCreatedAt(formattedDate);
        SimpleDateFormat originalDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date deadlineDate = originalDateFormat.parse(params.get("deadline").toString());

        String endDate = dateFormat.format(deadlineDate);
        recruitment.setDeadline(endDate); //Format "dd-MM-yyyy"

        recruitment.setSalary(Integer.parseInt(params.get("salary").toString()));
        recruitment.setType(params.get("type").toString());
        Category category = new Category();
        category.setId(Integer.parseInt(params.get("category_id").toString()));
        recruitment.setCategory(category);
        recruitmentDao.creatARecruitment(userId,recruitment);

    }

    @Override
    @Transactional
    public Recruitment getARecruitmentByidRec(int idRec){
        return recruitmentDao.getARecruitmentByidRec(idRec);
    }
    @Override
    @Transactional
    public void updateARecruitment(Map<String,Object> params, int idRec) throws ParseException {
        recruitmentDao.updateARecruitment(params,idRec);
    }

    @Override
    @Transactional
    public void deleteApost(int idRec){
        recruitmentDao.deleteApost(idRec);
    }

    @Override
   // @Transactional
    /*To retrieve output data, we do not need to access the database because it was already implemented in the previous step
    *@param List<Recruitment>recruitmentList : Used to obtain the output as the number of addresses
     */
    public  int getNumberOfAddress(List<Recruitment>recruitmentList){
        HashSet<String>hashSet = new HashSet<>();
        for(Recruitment recruitment : recruitmentList){
            hashSet.add(recruitment.getAddress());
        }
        return hashSet.size();
    }
    /*To retrieve output data, we do not need to access the database because it was already implemented in the previous step
     *@param List<Recruitment>recruitmentList : Used to obtain the output as the number of companies
     */
    @Override
    public int getNumberOfCompanies(List<Recruitment> recruitmentList){
        HashSet<Integer>hashSet = new HashSet<>();
        for(Recruitment recruitment : recruitmentList){
            hashSet.add(recruitment.getCompany().getId());
        }
        return hashSet.size();
    }

    @Override
    @Transactional
    public List<Recruitment> searchResult(String key){
        return recruitmentDao.searchResult(key);
    }

    @Override
    @Transactional
    public List<Recruitment> getAListSaveJobsOrApplied(int idUser, HashSet<Integer> hashSetIdRecruitments){
        return recruitmentDao.getAListSaveJobsOrApplied(idUser,hashSetIdRecruitments);
    }

    @Override
    @Transactional
    public List<Recruitment> getRecruitmentListByIdCompany(int companyId){
        return recruitmentDao.getRecruitmentListByIdCompany(companyId);
    }

}
