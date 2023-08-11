package springwork.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import springwork.dao.CompanyDao;
import springwork.entity.Company;
import springwork.entity.Recruitment;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

@Service
public class CompanyServiceImpl implements CompanyService{
    @Autowired
    private CompanyDao companyDao;

    @Override
    @Transactional
    public HashMap<Company,Integer> getTopCompanies(){
        return companyDao.getTopCompanies();
    }

    @Override
    @Transactional
    public Company getACompanyByCompanyId(int companyId){
        return companyDao.getACompanyByCompanyId(companyId);
    }

    @Override
    @Transactional
    public  HashMap<Company,Integer> getCompanyResult(List<Recruitment> recruitmentList){
        return companyDao.getCompanyResult(recruitmentList);
    }

    @Override
    @Transactional
    public List<Company> getListCompaniesFollowed(HashSet<Integer> hashSetIdSaveJobs, HashSet<Integer> hashSetIdCompaniesFollowed){
        return  companyDao.listCompanyFollowedByUser(hashSetIdSaveJobs,hashSetIdCompaniesFollowed);
    }

    @Override
    @Transactional
    public String getACompanyNameByCompanyId(int companyId){
        return companyDao.getACompanyNameByCompanyId(companyId);
    }

}
