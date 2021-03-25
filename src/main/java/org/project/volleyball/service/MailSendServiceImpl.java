package org.project.volleyball.service;

import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

@Service
public class MailSendServiceImpl implements MailSendService{
	@Autowired
    private JavaMailSenderImpl mailSender;
	
	private int size;

    //인증키 생성
    private String getKey(int size) {
        this.size = size;
        return getAuthCode();
    }

    //인증코드 난수 발생
    private String getAuthCode() {
        Random random = new Random();
        StringBuffer buffer = new StringBuffer();
        int num = 0;

        while(buffer.length() < size) {
            num = random.nextInt(10);
            buffer.append(num);
        }

        return buffer.toString();
    }

    //인증메일 보내기
    @Override
    public String sendAuthMail(String nickname,String userid) {
        //6자리 난수 인증번호 생성
        String authKey = getKey(6);

        //인증메일 보내기
        MimeMessage mail = mailSender.createMimeMessage();
        String mailContent = "<h1>[VB포럼 이메일 인증]</h1><br><p>"+nickname+"님 반갑습니다. 아래 링크를 클릭하여 이메일 인증을 완료해주세요.</p>"
                            //+ "<a href='http://localhost:8081/board/member/signUpConfirm?userid=" 
                            + "<a href='http://118.67.132.215:8080/volleyball/member/signUpConfirm?userid=" 
                            + userid + "&authKey=" + authKey + "' target='_blenk'>이메일 인증 확인(click)</a>";

        try {
            mail.setSubject("회원가입 이메일 인증 ", "utf-8");
            mail.setText(mailContent, "utf-8", "html");
            mail.addRecipient(Message.RecipientType.TO, new InternetAddress(userid));
            mailSender.send(mail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

          return authKey;
    }

}
