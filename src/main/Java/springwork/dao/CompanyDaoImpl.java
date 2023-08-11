package springwork.dao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import springwork.entity.Company;
import springwork.entity.Recruitment;
import springwork.entity.User;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.*;
import java.util.stream.Collectors;

@Repository
public class CompanyDaoImpl implements CompanyDao {
    @Autowired
    private SessionFactory sessionFactory;

    @Autowired
    private RecruitmentDao recruitmentDao;

    @Override
    public HashMap<Company,Integer> getTopCompanies(){
        Session currentSession = this.sessionFactory.getCurrentSession();
        //List<Company> ans = new ArrayList<>();
        HashMap<Company,Integer> ans = new HashMap<>();

        String hql = "SELECT com.id, com.nameCompany, com.logo, COUNT(foll.id) as CNT" +
                " FROM Company com JOIN FollowCompany foll" +
                " ON com.id = foll.company.id" +
                " GROUP BY com.id, com.nameCompany, com.logo ORDER BY CNT DESC";

        Query query = currentSession.createQuery(hql);
        query.setMaxResults(5);
        // get a result List
        List<Object[]> resultList = query.getResultList();

        //Converting to ans, the max size of ans as 5
        for (Object[] result : resultList) {
            Company company = new Company();
            company.setId (Integer.parseInt(result[0].toString()));
            String companyName = (String) result[1];
            company.setNameCompany((String) result[1]);
            company.setLogo((byte[]) result[2]);
            int count = Integer.parseInt(result[3].toString());
            ans.put(company,count);

        }
        return ans;

    }
    @Override
    public int isExistedIdAdmin(int idUser){
        Session currentSession  = this.sessionFactory.getCurrentSession();
        Query query = currentSession.createSQLQuery("SELECT id FROM company WHERE user_id = :idUser");
        query.setParameter("idUser",idUser);
        return query.uniqueResult()!=null ? ((int) query.uniqueResult()): 0;

    }
//    public byte[]getAlogoCompanyByAdminUserId( int userId){
//        Session currentSession = sessionFactory.getCurrentSession();
//        Query query =   currentSession.createQuery("Select logo from Company Where id = :userId ");
//        query.setParameter("userId",userId);
//        return query.uniqueResult().toString().getBytes();
//    }

    @Override
    public void insertNewCompanyByIdUser(int idUser){
        Session currentSession  = this.sessionFactory.getCurrentSession();
        Company company = new Company();
        User user = new User();
        user.setId(idUser);
        company.setUser(user);
        currentSession.save(company);
    }

    @Override
    public int getMaxIdCompany(){
        Session currentSession = this.sessionFactory.getCurrentSession();
        Query theQuery = currentSession.createSQLQuery("SELECT MAX(id) FROM company");

        Object result = theQuery.uniqueResult();
        if (result != null) {
            return (int) result;
        }

        return 0;

    }

    @Override
    public Company getACompanyByCompanyId(int companyId){
        Session currentSession = this.sessionFactory.getCurrentSession();
        Query theQuery = currentSession.createQuery("From Company c Where c.id = :companyId",Company.class);
        theQuery.setParameter("companyId",companyId);
        return (Company) theQuery.uniqueResult();

    }
    @Override
    public  HashMap<Company,Integer> getCompanyResult(List<Recruitment> recruitmentList){
        Session currentSession = this.sessionFactory.getCurrentSession();
        HashMap<Company,Integer> hashMapResult = new HashMap<>();
        HashMap<Integer,Integer> cnt = new HashMap<>();
        Query theQuery = currentSession.createQuery("from Company",Company.class);
        List<Company>companyList = theQuery.getResultList();
        for (Recruitment recruitment: recruitmentList){
            if(cnt.containsKey(recruitment.getCompany().getId()))
                cnt.put(recruitment.getCompany().getId(),cnt.get(recruitment.getCompany().getId())+1);
            else
                cnt.put(recruitment.getCompany().getId(),1);
        }
        //Processing result
        for(Company company : companyList){
            if(cnt.containsKey(company.getId())){
                hashMapResult.put(company,cnt.get(company.getId()));
            }
        }
        return hashMapResult;

    }

    /*
    *@Param HashSet<Integer> hashSetJobIdsFollowed : Recruitment ids that User followed
    * @Param HashSet<Integer> hashSetCompaniesIdFollowed: Companies ids that user followed
    * Output : return a listCompanies that user followed for both recruitment and companies
     */
    @Override
    public List<Company> listCompanyFollowedByUser(HashSet<Integer> hashSetJobIdsFollowed, HashSet<Integer> hashSetCompaniesIdFollowed){
        List<Company>ans = new ArrayList<>();
        Session currentSession = this.sessionFactory.getCurrentSession();
        List<Company>companyList =(List<Company>) currentSession.createQuery("From Company").getResultList();
        for (Company company : companyList){
            if(hashSetCompaniesIdFollowed.contains(company.getId()))
                ans.add(company);
        }
        //Getting a list of id companies that the user followed some jobs
        List<Recruitment>recruitmentList = recruitmentDao.getAllRecruitments();
        for (Recruitment recruitment : recruitmentList){
            if(hashSetJobIdsFollowed.contains(recruitment.getId()))
                ans.add(recruitment.getCompany());
        }
        return ans;

    }
    @Override
    public String getACompanyNameByCompanyId(int companyId){
        Session currentSession = this.sessionFactory.getCurrentSession();
        Query theQuery =  currentSession.createQuery("Select nameCompany From Company Where id = :companyId");
        theQuery.setParameter("companyId",companyId);
        return (String)theQuery.uniqueResult();
    }





}
