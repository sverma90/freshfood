package freshfood.utils;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class MailUtilGmail {

    public static void sendMail(String to, String from,
            String subject, String body, boolean bodyIsHTML)
            throws MessagingException {
    	System.out.println("hi");
        
        // 1 - get a mail session
        Properties props = new Properties();
        System.out.println("starting mail session");
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", 465);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.quitwait", "false");
        System.out.println("getting session");
        Session session = Session.getDefaultInstance(props);
        System.out.println(".......");
        session.setDebug(true);
        System.out.println("got mail session");

        // 2 - create a message
        Message message = new MimeMessage(session);
        message.setSubject(subject);
        if (bodyIsHTML) {
            message.setContent(body, "text/html");
        } else {
            message.setText(body);
        }
        System.out.println("created message");

        // 3 - address the message
        Address fromAddress = new InternetAddress(from);
        Address toAddress = new InternetAddress(to);
        message.setFrom(fromAddress);
        message.setRecipient(Message.RecipientType.TO, toAddress);
        System.out.println("here");

        // 4 - send the message
        Transport transport = session.getTransport();
        System.out.println("got transport");
        transport.connect("smtp.gmail.com", "cshih14@gmail.com", "ctcg htsa beni qmwd");
        System.out.println("connected");
        transport.sendMessage(message, message.getAllRecipients());
        System.out.println("sent");
        transport.close();
    }
}
