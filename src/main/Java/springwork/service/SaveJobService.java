package springwork.service;

import java.util.HashSet;

public interface SaveJobService {
    public HashSet<Integer>findIDRecruitmentFollowedByUser(int userId);
    public void insertASaveJob(int recruitmentId,int idUser);
    public void deleteASaveJob(int recruitmentId,int idUser);

}
