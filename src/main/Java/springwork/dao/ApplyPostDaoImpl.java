package springwork.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import springwork.entity.ApplyPost;
import springwork.entity.Recruitment;
import springwork.entity.User;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

@Repository
public class ApplyPostDaoImpl implements ApplyPostDao {
    @Autowired
    private SessionFactory sessionFactory;
    @Autowired
    private RecruitmentDao recruitmentDao;

    @Override
    public boolean isApplied(int idRecruitment,int idUser){
        Session currentSession = sessionFactory.getCurrentSession();
        Query theQuery =  currentSession.createQuery("from ApplyPost ap " +
                "where ap.recruitment.id = :idRecruitment AND ap.user.id = :idUser");
        theQuery.setParameter("idRecruitment",idRecruitment);
        theQuery.setParameter("idUser",idUser);
      //  List<ApplyPost> applyPosts = theQuery.getResultList();
         ApplyPost applyPost =(ApplyPost) theQuery.uniqueResult();
        return applyPost!=null;// it means the user applied to the recruitment then return true
    }

    @Override
    public void insertAnApplyPost(int idRecruitment,int idUser,String text,String fileName){
        Session currentSession = sessionFactory.getCurrentSession();
        ApplyPost applyPost = new ApplyPost();
        Recruitment recruitment = new Recruitment();
        recruitment.setId(idRecruitment);
        applyPost.setRecruitment(recruitment);
        User user = new User();
        user.setId(idUser);
        applyPost.setUser(user);
        applyPost.setText(text);
        applyPost.setNameCv(fileName);
        Date currentDate = new Date();
        SimpleDateFormat originalDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        applyPost.setCreatedAt(originalDateFormat.format(currentDate));
        currentSession.save(applyPost);
    }

    @Override
    public List<Recruitment> getListRecruitmentAppliedByUser(int userId){
        List<Recruitment>ans = new ArrayList<>();
        Session currentSession = sessionFactory.getCurrentSession();
        Query theQuery = currentSession.createSQLQuery("Select recruitment_id From applypost where user_id = :userId");
        theQuery.setParameter("userId",userId);
        List<Integer> listIdRecruitmentApplied =(List<Integer>) theQuery.getResultList();
        HashSet<Integer> hashSet = new HashSet<>(listIdRecruitmentApplied);
        List<Recruitment> recruitmentList = recruitmentDao.getAllRecruitments();
        for(Recruitment recruitment : recruitmentList){
            if(hashSet.contains(recruitment.getId()))
                ans.add(recruitment);
        }
        return ans;


    }

}

