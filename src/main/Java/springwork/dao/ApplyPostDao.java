package springwork.dao;

import springwork.entity.Recruitment;

import java.util.List;

public interface ApplyPostDao {
    public boolean isApplied(int idRecruitment,int idUser);
    public void insertAnApplyPost(int idRecruitment,int idUser,String text,String fileName);
    public List<Recruitment> getListRecruitmentAppliedByUser(int userId);
}
