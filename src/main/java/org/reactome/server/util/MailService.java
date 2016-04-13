package org.reactome.server.util;


import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Mail Service
 * Created by gsviteri on 15/10/2015.
 */
@Service
public class MailService {

    private static final Logger logger = LoggerFactory.getLogger(MailService.class);

    @Autowired
    private JavaMailSender mailSender;

    public void send(final String toAddress, final String fromAddress, final String subject, final String msgBody, final Boolean sendEmailCopy, final String fromName) throws Exception {
        try {
            MimeMessagePreparator preparator = new MimeMessagePreparator() {

                public void prepare(MimeMessage mimeMessage) throws Exception {

                    mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
                    InternetAddress from = new InternetAddress(fromAddress);
                    if (StringUtils.isNotBlank(fromName)) {
                        from = new InternetAddress(fromAddress, fromName);
                    }

                    if (sendEmailCopy) {
                        mimeMessage.setRecipient(Message.RecipientType.BCC, new InternetAddress(fromAddress));
                    }
                    mimeMessage.setFrom(from);
                    mimeMessage.setSubject(subject);
                    mimeMessage.setText(msgBody);
                }
            };

            mailSender.send(preparator);
        } catch (Exception e) {
            logger.error("[MAILSRVErr] The email could not be sent [To: " + toAddress + " From: " + fromAddress + " Subject: " + subject);
            throw new Exception("Mail has not been sent");
        }
    }

}
