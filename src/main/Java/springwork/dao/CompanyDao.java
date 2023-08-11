package springwork.dao;

import springwork.entity.Company;
import springwork.entity.Recruitment;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

public interface CompanyDao {
    public HashMap<Company,Integer> getTopCompanies();
    public int isExistedIdAdmin(int idUser);

   // public byte[]getAlogoCompanyByAdminUserId( int userId);
    public void insertNewCompanyByIdUser(int idUser);

    public int getMaxIdCompany();
    public Company getACompanyByCompanyId(int companyId);
    public  HashMap<Company,Integer> getCompanyResult(List<Recruitment> recruitmentList);
    public List<Company> listCompanyFollowedByUser(HashSet<Integer> hashSetJobsFollowed, HashSet<Integer> hashSetCompaniesFollowed);
    public String getACompanyNameByCompanyId(int companyId);

}
