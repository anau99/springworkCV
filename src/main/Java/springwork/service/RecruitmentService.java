package springwork.service;

import org.springframework.web.bind.annotation.RequestParam;
import springwork.entity.Recruitment;

import java.text.ParseException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

public interface RecruitmentService {
    public List<Recruitment> getTopRecruitmentList();
    public List<Recruitment> getListRecruitmentByUser(int userId, StringBuilder nameCompany);
    public void creatARecruitment( int userId,@RequestParam Map<String, Object> params) throws ParseException;
    public Recruitment getARecruitmentByidRec(int idRec);
    public void updateARecruitment(Map<String,Object> params, int idRec) throws ParseException;
    public void deleteApost(int idRec);
    public int getNumberOfAddress(List<Recruitment> recruitmentList);
    public int getNumberOfCompanies(List<Recruitment> recruitmentList);
    public List<Recruitment> searchResult(String key);
    public List<Recruitment> getAListSaveJobsOrApplied(int idUser, HashSet<Integer> hashSetIdRecruitments);
    public List<Recruitment> getRecruitmentListByIdCompany(int companyId);
}
