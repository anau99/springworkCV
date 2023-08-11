package springwork.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import springwork.entity.Recruitment;
import springwork.entity.SaveJob;
import springwork.entity.User;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

@Repository
public class SaveJobDaoImpl implements SaveJobDao {
    @Autowired
    private SessionFactory sessionFactory;

    @Autowired
    private RecruitmentDao recruitmentDao;
    @Override
    public HashSet<Integer> findIDRecruitmentFollowedByUser(int userId){
        HashSet<Integer>hashSet = new HashSet<>();
        Session currentSession = sessionFactory.getCurrentSession();
        List<SaveJob> saveJobs =  currentSession.createQuery("from SaveJob",SaveJob.class).getResultList();
       for(SaveJob saveJob : saveJobs){
           if(saveJob.getUser().getId()==userId)
               hashSet.add(saveJob.getRecruitment().getId());
       }

       return hashSet;
    }

    @Override
    public void insertASaveJob(int recruitmentId,int idUser){
        Session currentSession = sessionFactory.getCurrentSession();
        SaveJob saveJob= new SaveJob();
        Recruitment recruitment = new Recruitment();
        User user = new User();
        recruitment.setId(recruitmentId);
        user.setId(idUser);
        saveJob.setRecruitment(recruitment);
        saveJob.setUser(user);
        currentSession.save(saveJob);

    }
    @Override
    public void deleteASaveJob(int recruitmentId,int idUser){
        Session currentSession = sessionFactory.getCurrentSession();
        String sql = "DELETE FROM save_job WHERE recruitment_id = :recruitmentId AND user_id = :userId";
        Query query = currentSession.createSQLQuery(sql);
        query.setParameter("recruitmentId", recruitmentId);
        query.setParameter("userId", idUser);
        query.executeUpdate();
    }

    @Override
    public List<Recruitment>getAListRecruitmentFollowedById(HashSet<Integer> hashSetIdRecruitments){
      //  Session currentSession = sessionFactory.getCurrentSession();
        List<Recruitment>ans = new ArrayList<>();
        List<Recruitment>recruitmentList = recruitmentDao.getAllRecruitments();
        for (Recruitment recruitment : recruitmentList){
            if(hashSetIdRecruitments.contains(recruitment.getId()))
                ans.add(recruitment);
        }
        return ans;
    }

}
