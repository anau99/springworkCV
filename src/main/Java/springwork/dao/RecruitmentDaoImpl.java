package springwork.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import springwork.entity.ApplyPost;
import springwork.entity.Category;
import springwork.entity.Company;
import springwork.entity.Recruitment;

import javax.persistence.criteria.CriteriaBuilder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Repository
public class RecruitmentDaoImpl implements RecruitmentDao{
    @Autowired
    private SessionFactory sessionFactory;
    @Autowired
    private CompanyDao companyDao;
    @Autowired
    private SaveJobDao saveJobDao;

    @Autowired
    private ApplyPostDao applyPostDao;

    /*
        Output : List<Recruitment> topList
     */
    @Override
    public List<Recruitment> getTopRecruitmentList(){
        //Get Top 5
        List<Recruitment>result = new ArrayList<>();
        Session currentSession = this.sessionFactory.getCurrentSession();
        Query<Recruitment> theQuery =currentSession.createQuery("from Recruitment",Recruitment.class);
        List<Recruitment> recruitmentList = theQuery.getResultList();
        //Get Data applyPosts
        Query<ApplyPost> applyPostQuery = currentSession.createQuery("from ApplyPost", ApplyPost.class);
        List<ApplyPost> applyPostList = applyPostQuery.getResultList();
        //Initial
        HashMap<Integer,Recruitment> hashMapID = new HashMap<>();
        HashMap<Integer,Integer> hashMapCntID = new HashMap<>();

        //Counting IdRec into applyPostList
        countngIDRec(hashMapCntID,hashMapID,applyPostList,recruitmentList);
        //Sorting DESC
        LinkedHashMap<Integer, Integer> sortedMap = hashMapCntID.entrySet()
                .stream()
                .sorted(Map.Entry.<Integer, Integer>comparingByValue().reversed())
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (oldValue, newValue) -> oldValue, LinkedHashMap::new));

        //get top 5
        getTopFiveRecruitment(result,sortedMap,hashMapID);
        return result;
    }


    /*
     * @param hashMapCntID: HashMap to count the occurrences of each recruitment ID in the recruitmentList.
     * @param hashMapID: HashMap to store the relationship between recruitment ID and the corresponding recruitment object.
     * @param recruitmentList: Input data containing a list of Recruitment objects.
     */
    private void countngIDRec(HashMap<Integer,Integer>hashMapCntID, HashMap<Integer,Recruitment> hashMapID,
                              List<ApplyPost> applyPostList, List<Recruitment>recruitmentList ){
        for (ApplyPost applyPost : applyPostList){
            int ruiCId = applyPost.getRecruitment().getId();
            if(hashMapCntID.containsKey(ruiCId))
                hashMapCntID.put(ruiCId,hashMapCntID.get(ruiCId)+1);
            else
                hashMapCntID.put(ruiCId,1);
        }
        for(Recruitment recruitment : recruitmentList){
            int ruiCId  = recruitment.getId();
            hashMapID.put(ruiCId,recruitment);
        }
    }

    /*
     *@param HashMap<Integer,Integer>hashMapCntID :Input
     * @param HashMap<Integer,Recruitment> hashMapID : Input
     *@ List<Recruitment>result : Output top 5
     */
    private void getTopFiveRecruitment(List<Recruitment>result, LinkedHashMap<Integer, Integer> sortedMap,
                                       HashMap<Integer,Recruitment> hashMapID ){
        int i = 0;
        for (Map.Entry<Integer, Integer> entry : sortedMap.entrySet()) {
            if(i==5)
                break;
            result.add(hashMapID.get(entry.getKey()));
            i++;
        }
    }

    @Override
    public List<Recruitment> getListRecruitmentByUser(int userId, StringBuilder nameCompany){
       int idCompany = companyDao.isExistedIdAdmin(userId);
       Session currentSession = this.sessionFactory.getCurrentSession();
        String hql = "Select rec.id, rec.type, rec.title, rec.address " +
                "from Recruitment rec JOIN Company cmp " +
                "ON rec.company.id = cmp.id Where rec.company.id = :idCompany";
        Query thequery = currentSession.createQuery(hql);
        thequery.setParameter("idCompany",idCompany);
        List<Object[]> resultList = thequery.getResultList();
        List<Recruitment> recruitmentList = new ArrayList<>();
        for (Object[] row : resultList) {
            Recruitment recruitment = new Recruitment();
            recruitment.setId((int) row[0]);
            recruitment.setType((String) row[1]);
            recruitment.setTitle((String) row[2]);
            recruitment.setAddress((String) row[3]);
            recruitmentList.add(recruitment);
        }

        Query query = currentSession.createSQLQuery("Select name_company from company Where id = :idCompany");
        query.setParameter("idCompany",idCompany);
        nameCompany.append((String) query.uniqueResult());

       return recruitmentList;

    }

    @Override
    public void creatARecruitment(int userId,Recruitment recruitment){
        int idCompany = companyDao.isExistedIdAdmin(userId);
        Session currentSession = this.sessionFactory.getCurrentSession();
        Company company = new Company();
        if(idCompany <=0){
            companyDao.insertNewCompanyByIdUser(userId);
             idCompany =  companyDao.getMaxIdCompany();
        }
        company.setId(idCompany);
        recruitment.setCompany(company);
        currentSession.save(recruitment);
    }

    @Override
    public Recruitment getARecruitmentByidRec(int idRec){
        Session currentSession = this.sessionFactory.getCurrentSession();
        Query theQuery = currentSession.createQuery("from Recruitment Where id = :idRec",Recruitment.class);
        theQuery.setParameter("idRec",idRec);
        return (Recruitment)theQuery.uniqueResult();

    }
    @Override
    public void updateARecruitment(Map<String,Object> params, int idRec) throws ParseException {
        Session currentSession = sessionFactory.getCurrentSession();
        String title = params.get("title").toString().trim();
        String description = params.get("description").toString().trim();
        String experience =params.get("experience").toString().trim();
        int quantity = Integer.parseInt(params.get("quantity").toString());
        String address = params.get("address").toString().trim();
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat originalDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String deadline = "";
        Date deadlineDate = originalDateFormat.parse(params.get("deadline").toString());
        deadline = dateFormat.format(deadlineDate);

        int salary = Integer.parseInt(params.get("salary").toString());
        String type  = params.get("type").toString();
        int categoryId = Integer.parseInt(params.get("category_id").toString());
        String hql = "UPDATE Recruitment " +
                "SET title = :title, " +
                "    description = :description, " +
                "    experience = :experience, " +
                "    quantity = :quantity, " +
                "    address = :address, " +
                "    salary = :salary, " +
                "    type = :type, " +
                "    category.id= :categoryId, " +
                "    deadline = :deadline " +
                "WHERE id = :idRec";
        Query query = currentSession.createQuery(hql);
        query.setParameter("title",title);
        query.setParameter("description", description);
        query.setParameter("experience", experience);
        query.setParameter("quantity", quantity);
        query.setParameter("address", address);
        query.setParameter("salary", salary);
        query.setParameter("type", type);
        query.setParameter("categoryId", categoryId);
        query.setParameter("deadline", deadline);
        query.setParameter("idRec", idRec);
        query.executeUpdate();

    }

    @Override
    public void deleteApost(int idRec){
        Session currentSession = sessionFactory.getCurrentSession();;
        Query theQuery = currentSession.createQuery("Delete From Recruitment Where id = :idRec");
        theQuery.setParameter("idRec",idRec);
        theQuery.executeUpdate();
    }

    /*
    *@param String key: key is one of something (name of company, title of recruitment, address)
     */
    @Override
    public List<Recruitment> searchResult(String key){
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Recruitment> theQuery =currentSession.createQuery("from Recruitment",Recruitment.class);
        List<Recruitment> recruitmentList = theQuery.getResultList();
        HashSet<Integer> set = new HashSet<>();
        String k = key.trim().toLowerCase();
        List<Recruitment>ans = new ArrayList<>();
        for (Recruitment recruitment : recruitmentList){
            if(!set.contains(recruitment.getId()) && isValid(recruitment,k)){
                ans.add(recruitment);
                set.add(recruitment.getId());
            }
        }

        return ans;
    }

    public boolean isValid(Recruitment recruitment, String key){
        return recruitment.getTitle().toLowerCase().contains(key)
                || recruitment.getAddress().toLowerCase().contains(key)
                || recruitment.getCompany().getNameCompany().toLowerCase().contains(key);

    }

    @Override
    public List<Recruitment> getAllRecruitments(){
       Session currentSession = sessionFactory.getCurrentSession();
       return  currentSession.createQuery("From Recruitment").getResultList();
    }
    @Override
    public List<Recruitment> getAListSaveJobsOrApplied(int idUser, HashSet<Integer> hashSetIdRecruitments){
        //getting a recruitments list that the user followed
        List<Recruitment>ans= saveJobDao.getAListRecruitmentFollowedById(hashSetIdRecruitments);
        //Getting a recruitments list that applied by user
        List<Recruitment>recruitmentListAppliedByUser = applyPostDao.getListRecruitmentAppliedByUser(idUser);
        //Merge two list
        for(Recruitment recruitment : recruitmentListAppliedByUser){
            if(!hashSetIdRecruitments.contains(recruitment.getId())){
                ans.add(recruitment);
            }
        }

        return ans;

    }

    @Override
    public List<Recruitment> getRecruitmentListByIdCompany(int companyId){
        Session currentSession = sessionFactory.getCurrentSession();
        Query theQuery = currentSession.createQuery("From Recruitment  Where company.id = :companyId");
        theQuery.setParameter("companyId",companyId);
        return theQuery.getResultList();
    }


}
