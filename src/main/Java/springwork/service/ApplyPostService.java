package springwork.service;

public interface ApplyPostService {
    public boolean isApplied(int idRecruitment,int idUser);
    public void insertAnApplyPost(int idRecruitment,int idUser,String text,String fileName);
}
