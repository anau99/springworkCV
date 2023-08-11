package springwork.dao;

import springwork.entity.Recruitment;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.HashSet;
import java.util.List;

public interface SaveJobDao {
    public HashSet<Integer> findIDRecruitmentFollowedByUser(int userId);
    public void insertASaveJob(int recruitmentId,int idUser);
    public void deleteASaveJob(int recruitmentId,int idUser);
    public List<Recruitment>getAListRecruitmentFollowedById(HashSet<Integer> hashSetIdRecruitments);
}
