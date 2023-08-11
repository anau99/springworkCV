package springwork.service;

import org.springframework.stereotype.Service;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

@Service
public class EmailServiceImpl implements EmailService{

    @Override
    public boolean sendConfirmationEmail(String toEmail, String subject, String text) {
        //  SMTP of Email server
        String host = "smtp.gmail.com"; //SMTP của gmail
        String port = "587";
        String username = "anahfx21237@funix.edu.vn";
        // Đây là mật khẩu ứng dụng được tạo bằng tài khoản google không phải là mật khẩu của tài khoản gg
        //Hướng dẫn sử dụng : https://support.google.com/accounts/answer/185833?visit_id=638270648550657134-1353955964&p=InvalidSecondFactor&rd=1
        String password = "cajhgirhajvlpjcj";
        //  JavaMail
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        //  Session
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            //  MimeMessage Object
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(text);
            // Send email
            Transport.send(message);
            System.out.println("Email sent successfully.");
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}

