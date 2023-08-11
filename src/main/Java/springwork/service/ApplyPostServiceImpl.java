package springwork.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import springwork.dao.ApplyPostDao;

@Service
public class ApplyPostServiceImpl implements  ApplyPostService{
    @Autowired
    private ApplyPostDao applyPostDao;

    @Override
    @Transactional
    public boolean isApplied(int idRecruitment,int idUser){
        return applyPostDao.isApplied(idRecruitment,idUser);
    }

    @Override
    @Transactional
    public void insertAnApplyPost(int idRecruitment,int idUser,String text,String fileName){
        applyPostDao.insertAnApplyPost(idRecruitment,idUser,text,fileName);
    }
}
