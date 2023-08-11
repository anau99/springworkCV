package springwork.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;
import springwork.entity.Company;
import springwork.entity.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;

@Repository
public class UserDaoImpl implements UserDao{
    @Autowired
    private SessionFactory sessionFactory;
   @Autowired
    private CompanyDao companyDao;
    /* check if the user exists in the DB or not
    /@params map<String, String> params : The input contains username, email,.. to check to DB
     */
    @Override
    public boolean checkUser(@RequestParam Map<String, Object> params){
        Session curentSession = this.sessionFactory.getCurrentSession();
        if(!params.get("password").toString().equals(params.get("rePassword").toString()))
            return false;
        String email = params.get("email").toString();
        Query theQuery =  curentSession.createQuery("from User where email = : email", User.class);
        theQuery.setParameter("email",email);
        return theQuery.getResultList().isEmpty();
    }

    /* Saving User to DB
    /@params User user : New user
     */
    @Override
    public void registerUser(User user){
        Session currentSession = this.sessionFactory.getCurrentSession();
        currentSession.save(user);
    }
    /* to be get a user by email and id

     */
    @Override
    public User getUserByLogin(String email,String password){
        Session curentSession = this.sessionFactory.getCurrentSession();
        Query theQuery =  curentSession.createQuery("from User where email = : email", User.class);
        theQuery.setParameter("email",email);
        List<User>users = theQuery.getResultList();
        if(users.size()==1){
            //Checking password
            PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            if(passwordEncoder.matches(password, users.get(0).getPassword()))
                return users.get(0);

        }
        return null;
    }

    @Override
    public boolean uploadImage(int idUser,byte[] imageData){
        Session currentSession = this.sessionFactory.getCurrentSession();
        String sqlQuery = "UPDATE user SET image = :imageData WHERE id = :idUser";
        Query query = currentSession.createSQLQuery(sqlQuery);
        query.setParameter("imageData", imageData);
        query.setParameter("idUser", idUser);
        int result = query.executeUpdate();
        return result > 0;
    }

    @Override
    public boolean updateProfilePersonal(@RequestParam Map<String, Object> params, int userId){
        Session currentSession = this.sessionFactory.getCurrentSession();
        String email =  params.get("email").toString().trim();
        String fullName = params.get("fullName").toString().trim();
        String address  = params.get("address").toString().trim();
        String phoneNumber = params.get("phoneNumber").toString().trim();
        String description = params.get("description").toString().trim();
        int idUser = userId;
        Query query = currentSession.createSQLQuery(
                "UPDATE user SET email = :email,"
                + "full_name = :fullName,"
                + "address= :address,"
                + "phone_number= :phoneNumber,"
                +  "description= :description"
                +" WHERE id = :idUser");
        query.setParameter("email",email);
        query.setParameter("fullName",fullName);
        query.setParameter("address",address);
        query.setParameter("phoneNumber",phoneNumber);
        query.setParameter("description",description);
        query.setParameter("idUser",idUser);
        return query.executeUpdate() >0;

    }

    @Override
    public void uploadLogo(int idUser,byte[] imageData){

        //Checking the idUser is existed into Company Data ?
       // int findIdCompany = 0;
        int idCompany = companyDao.isExistedIdAdmin(idUser);
       if(idCompany>0){
            //Update logo
           Session currentSession = this.sessionFactory.getCurrentSession();
           Query theQuery = currentSession.createSQLQuery("UPDATE company Set logo = :imageData Where id = :idCompany");
           theQuery.setParameter("imageData",imageData);
           theQuery.setParameter("idCompany",idCompany);
           theQuery.executeUpdate();
       }
       else {
           //Insert a new company
           Session currentSession = this.sessionFactory.getCurrentSession();
           Company company = new Company();
           User user = new User();
           user.setId(idUser);
           company.setUser(user);
           company.setLogo(imageData);
           currentSession.save(company);

       }


    }


    @Override
    public void updateCompanyOfAdmin(int idUser, @RequestParam Map<String, Object> params) {
        String email = params.get("email").toString().trim();
        String nameCompany = params.get("nameCompany").toString().trim();
        String address = params.get("address").toString().trim();
        String phoneNumber = params.get("phoneNumber").toString().trim();
        String description = params.get("description").toString().trim();

        // Check company
        int idCompany = companyDao.isExistedIdAdmin(idUser);

        Session currentSession = this.sessionFactory.getCurrentSession();

        if (idCompany > 0) {
            // If idCompany > 0, it means the company already exists, perform an update of its properties
            String sql = "UPDATE company SET email = :email, name_company = :nameCompany, address = :address, phone_number = :phoneNumber, description = :description, user_id = :idUser WHERE id = :idCompany";
            Query query = currentSession.createSQLQuery(sql);
            query.setParameter("email", email);
            query.setParameter("nameCompany", nameCompany);
            query.setParameter("address", address);
            query.setParameter("phoneNumber", phoneNumber);
            query.setParameter("description", description);
            query.setParameter("idCompany", idCompany);
            query.setParameter("idUser",idUser);
            query.executeUpdate();
        } else {
            //  If idCompany <= 0, it means the company does not exist yet, perform an insert to add the new company.
            String sql = "INSERT INTO company (email, name_company, address, phone_number, description,user_id) VALUES (:email, :nameCompany, :address, :phoneNumber, :description)";
            Query query = currentSession.createSQLQuery(sql);
            query.setParameter("email", email);
            query.setParameter("nameCompany", nameCompany);
            query.setParameter("address", address);
            query.setParameter("phoneNumber", phoneNumber);
            query.setParameter("description", description);
            query.setParameter("idUser",idUser);
            query.executeUpdate();
        }
    }

    @Override
    public byte[]getAlogoCompanyByAdminUserId( int userId){
        Session currentSession = sessionFactory.getCurrentSession();
        Query query = currentSession.createSQLQuery("select logo from company where user_id = :userId");

        query.setParameter("userId",userId);

        byte[] logoData =(byte[]) query.uniqueResult();
        return logoData;

    }

    @Override
    public boolean isEmailExisted(String inputEmail){
        Session currentSession = sessionFactory.getCurrentSession();
        Query theQuery =  currentSession.createQuery("from User where email = : inputEmail", User.class);
        theQuery.setParameter("inputEmail",inputEmail);
        return !theQuery.getResultList().isEmpty();//Return true when inputEmail is existed
    }




}
