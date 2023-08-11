package springwork.dao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import springwork.entity.*;

import javax.persistence.Query;
import java.util.HashSet;
import java.util.List;

@Repository
public class FollowCompanyDaoImpl implements FollowCompanyDao{
    @Autowired
    private   SessionFactory sessionFactory;

    @Override
    public HashSet<Integer> finIDCompaniesFollowedByUser(int userId){
        HashSet<Integer>hashSet = new HashSet<>();
        Session currentSession = sessionFactory.getCurrentSession();
        List<FollowCompany> followCompanies =  currentSession.createQuery("from FollowCompany",FollowCompany.class).getResultList();
        for(FollowCompany followCompany : followCompanies){
            if(followCompany.getUser().getId()==userId)
                //getting ID Company
                hashSet.add(followCompany.getCompany().getId());
        }
        return hashSet;
    }

    @Override
    public void insertAFollowCompany(int companiesID,int idUser){
        Session currentSession = sessionFactory.getCurrentSession();
        FollowCompany followCompany= new FollowCompany();
        Company company = new Company();
        User user = new User();
        company.setId(companiesID);
        user.setId(idUser);
        followCompany.setUser(user);
        followCompany.setCompany(company);
        currentSession.save(followCompany);
    }

    @Override
    public void deleteAFollowCompany(int companiesID,int idUser){
        Session currentSession = sessionFactory.getCurrentSession();
        String sql = "DELETE FROM follow_company WHERE company_id = :companiesID AND user_id = :idUser";
        Query query = currentSession.createSQLQuery(sql);
        query.setParameter("companiesID", companiesID);
        query.setParameter("idUser", idUser);
        query.executeUpdate();
    }

}
