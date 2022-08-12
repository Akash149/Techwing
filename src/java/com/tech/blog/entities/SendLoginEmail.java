
package com.tech.blog.entities;

 import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendLoginEmail {
    
    private String message;
    private String subject = "Login Alert!";
    private String to;
    private String from = "mr.iotdeveloper@gmail.com";
    String host = "smtp.gmail.com";

    public SendLoginEmail(String message, String subject, String to, String from) {
        this.message = message;
        this.subject = subject;
        this.to = to;
        this.from = from;
    }  

    public SendLoginEmail() {
    }
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }
    
    public void SendEmail() {
        
        //Get System properties
        Properties properties = System.getProperties();
        
        //setting important information to properties object
        
        //Host set
        properties.put("mail.smtp.host","smtp.gmail.com");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");
        
        //To get session object....
        Session session = Session.getInstance(properties, new Authenticator() {
            
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                
                return new PasswordAuthentication(from, "lnhjnexdxwyoccna");
            }
        });
        
        //session.setDebug(true);
        
        //compose the message [text, multimedia]
        MimeMessage m = new MimeMessage(session); 
        
        try {
            //from email
            m.setFrom(from);
            
            //adding recipient to message
            m.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
            
            //adding subject
            m.setSubject(subject);
            
            //adding text to message
            m.setText(message);
            
            //Send the message using Transport class
            Transport.send(m);
            
        } catch(Exception e) {
            
            e.printStackTrace();
            
        }
    }
    
    
}
