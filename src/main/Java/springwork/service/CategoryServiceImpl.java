package springwork.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import springwork.dao.CategoryDao;
import springwork.entity.Category;
import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryDao categoryDao;

    @Override
    @Transactional
    public List<Category> getListcategory(){
      return categoryDao.getListcategory();
    }
}
