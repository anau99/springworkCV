package springwork.service;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.HashSet;

public interface FollowCompanyService {
   public HashSet<Integer> finIDCompaniesFollowedByUser(int userId);
   public void insertAFollowCompany(int companiesID,int idUser);
   public void deleteAFollowCompany(int companiesID,int idUser);
}
