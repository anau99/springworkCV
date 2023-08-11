package springwork.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import springwork.entity.Category;

import java.util.List;

@Repository
public class CategoryDaoImpl implements CategoryDao{
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<Category> getListcategory(){
        Session currentSession = this.sessionFactory.getCurrentSession();
        return currentSession.createQuery("from Category Order By numberChoose DESC",Category.class).getResultList();
    }

}
