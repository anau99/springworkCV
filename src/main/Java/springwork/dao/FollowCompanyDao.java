package springwork.dao;

import java.util.HashSet;

public interface FollowCompanyDao {
    public HashSet<Integer> finIDCompaniesFollowedByUser(int userId);
    public void insertAFollowCompany(int companiesID,int idUser);
    public void deleteAFollowCompany(int companiesID,int idUser);

}
