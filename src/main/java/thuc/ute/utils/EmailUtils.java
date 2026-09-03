package thuc.ute.utils;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtils {

    private static final String FROM_EMAIL = "trt571983@gmail.com";
    private static final String APP_PASSWORD = "lvfa fpuc kbnt zyuy";

    private EmailUtils() {
    }

    public static void sendOtp(String toEmail, String otp)
            throws MessagingException {

        Properties props = new Properties();

        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");


        Session session = Session.getInstance(
                props,
                new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(
                                FROM_EMAIL,
                                APP_PASSWORD
                        );
                    }
                }
        );

        Message message = new MimeMessage(session);

        message.setFrom(
                new InternetAddress(FROM_EMAIL)
        );

        message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(toEmail)
        );

        message.setSubject(
                "Mã OTP kích hoạt tài khoản"
        );

        message.setText(
                "Mã OTP của bạn là: " + otp
                        + "\nMã OTP có hiệu lực trong 5 phút."
        );

        Transport.send(message);
    }
}