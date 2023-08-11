package springwork.service;

import springwork.entity.Company;
import springwork.entity.Recruitment;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

public interface CompanyService {
    public HashMap<Company,Integer> getTopCompanies();
    public Company getACompanyByCompanyId(int companyId);
    public  HashMap<Company,Integer> getCompanyResult(List<Recruitment> recruitmentList);
    public List<Company> getListCompaniesFollowed(HashSet<Integer> hashSetIdSaveJobs,HashSet<Integer> hashSetIdCompaniesFollowed);
    public String getACompanyNameByCompanyId(int companyId);
}
