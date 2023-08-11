package springwork.service;

public interface EmailService {
    public boolean sendConfirmationEmail(String toEmail, String subject, String text);
}
