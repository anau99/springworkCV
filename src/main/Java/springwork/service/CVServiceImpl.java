package springwork.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import springwork.dao.CVDao;

@Service
public class CVServiceImpl implements CVService {
    @Autowired
    CVDao cvDao;
    @Override
    @Transactional
    public int checkUserIsExistedInCv( int idUser){
        return cvDao.checkUserIsExistedInCv(idUser);

    }

    @Override
    @Transactional
    public void updateCV(String fileName,byte[]dataCV,int idCv){
        cvDao.updateCV(fileName,dataCV,idCv);
    }

    @Override
    @Transactional
    public void inSertCv(String fileName,byte[]dataCV,int idUser){
        cvDao.inSertCv(fileName,dataCV,idUser);
    }

    @Override
    @Transactional
    public byte[] getDataCv(int idUser){
        return cvDao.getDataCv(idUser);
    }

    @Override
    @Transactional
    public String getNameCv(int idCv){
        return cvDao.getNameCv(idCv);
    }
}
