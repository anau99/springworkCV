package springwork.dao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CVDaoImpl implements CVDao {
    @Autowired
    private SessionFactory sessionFactory;
    @Override
    public int checkUserIsExistedInCv( int idUser){
        Session session = this.sessionFactory.getCurrentSession();
        Query theQuery =  session.createSQLQuery("Select id from CV where user_id = :idUser");
        theQuery.setParameter("idUser",idUser);
        if(theQuery.uniqueResult()==null) return 0;
        return  (int)theQuery.uniqueResult();
    }
    @Override
    public void updateCV(String fileName,byte[]dataCV,int idCv){
        try {
            Session session = this.sessionFactory.getCurrentSession();
            String sql = "UPDATE cv SET file_name = :fileName, data = :dataCV WHERE id = :idCv";
            Query theQuery = session.createSQLQuery(sql);
            theQuery.setParameter("fileName", fileName);
            theQuery.setParameter("dataCV", dataCV);
            theQuery.setParameter("idCv", idCv);
            theQuery.executeUpdate();

        } catch (Exception e) {
            e.getMessage();
        }
    }

    @Override
    public void inSertCv(String fileName,byte[]dataCV,int idUser){
        try {
            Session session = this.sessionFactory.getCurrentSession();
            String sql = "INSERT INTO cv(file_name,user_id,data) values(:fileName, :idUser, :dataCV)";
            Query theQuery = session.createSQLQuery(sql);
            theQuery.setParameter("fileName", fileName);
            theQuery.setParameter("dataCV", dataCV);
            theQuery.setParameter("idUser", idUser);
            theQuery.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public byte[] getDataCv(int idUser){
        //Get id of cv
        int idCv = checkUserIsExistedInCv(idUser);
        byte[]ans = null;
        Session session = this.sessionFactory.getCurrentSession();
        if(idCv>0){
            Query theQuery = session.createSQLQuery("Select data from cv where id = :idCv ");
            theQuery.setParameter("idCv",idCv);
          //  theQuery.executeUpdate();
            ans= (byte[])theQuery.uniqueResult();
        }

        return ans;
    }

    @Override
    public String getNameCv(int idCv){
        Session session = this.sessionFactory.getCurrentSession();
        Query theQuery = session.createSQLQuery("Select file_name from cv where id = :idCv");
        theQuery.setParameter("idCv",idCv);
        return (String) theQuery.uniqueResult();
    }
}
