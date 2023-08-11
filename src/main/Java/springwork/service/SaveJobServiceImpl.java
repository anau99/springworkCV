package springwork.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import springwork.dao.RecruitmentDao;
import springwork.dao.SaveJobDao;

import java.util.HashSet;

@Service
public class SaveJobServiceImpl implements  SaveJobService{
    @Autowired
    private SaveJobDao saveJobDao;
    @Override
    @Transactional
    public HashSet<Integer> findIDRecruitmentFollowedByUser(int userId){
        return saveJobDao.findIDRecruitmentFollowedByUser(userId);
    }

    @Override
    @Transactional
    public void insertASaveJob(int recruitmentId,int idUser){
        saveJobDao.insertASaveJob(recruitmentId,idUser);
    }

    @Override
    @Transactional
    public void deleteASaveJob(int recruitmentId,int idUser){
        saveJobDao.deleteASaveJob(recruitmentId,idUser);
    }

}
