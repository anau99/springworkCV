package springwork.dao;

import springwork.entity.Recruitment;

import java.text.ParseException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;


public interface RecruitmentDao {
    public List<Recruitment> getTopRecruitmentList();
    public List<Recruitment> getListRecruitmentByUser(int userId, StringBuilder nameCompany);
   public  void  creatARecruitment(int userId,Recruitment recruitment);
    public Recruitment getARecruitmentByidRec(int idRec);
    public void updateARecruitment(Map<String,Object> params, int idRec) throws ParseException;
    public void deleteApost(int idRec);
    public List<Recruitment> searchResult(String key);
    public List<Recruitment> getAListSaveJobsOrApplied(int idUser, HashSet<Integer> hashSetIdRecruitment);
    public List<Recruitment> getAllRecruitments();
    public List<Recruitment> getRecruitmentListByIdCompany(int companyId);


}
