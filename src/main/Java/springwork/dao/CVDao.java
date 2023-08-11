package springwork.dao;

public interface CVDao {
    public int checkUserIsExistedInCv( int idUser);
    public void updateCV(String fileName,byte[]dataCV,int idCv);
    public void inSertCv(String fileName,byte[]dataCV,int idUser);
    public byte[] getDataCv(int idUser);
    public String getNameCv(int idCv);
}
