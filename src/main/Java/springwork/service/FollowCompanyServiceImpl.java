package springwork.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import springwork.dao.FollowCompanyDao;

import java.util.HashSet;

@Service
public class FollowCompanyServiceImpl implements FollowCompanyService{
    @Autowired
    private FollowCompanyDao followCompanyDao;
    @Override
    @Transactional
    public HashSet<Integer> finIDCompaniesFollowedByUser(int userId){
       return followCompanyDao.finIDCompaniesFollowedByUser(userId);
    }

    @Override
    @Transactional
    public void insertAFollowCompany(int companiesID,int idUser){
        followCompanyDao.insertAFollowCompany(companiesID,idUser);
    }

    @Override
    @Transactional
    public void deleteAFollowCompany(int companiesID,int idUser){
        followCompanyDao.deleteAFollowCompany(companiesID,idUser);
    }
}
