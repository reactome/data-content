package org.reactome.server.util;


import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;

/**
 * Mail Service
 *
 * @author Guilherme Viteri (gviteri@ebi.ac.uk)
 * @author Antonio Fabregat (fabrgat@ebi.ac.uk)
 */
@SuppressWarnings("Duplicates")
@Service
@PropertySource("classpath:core.properties")
public class MailService {

    private JavaMailSender mailSender;

    @Value("${mail.error.name}")
    private String mailErrorName; // E

    @Value("${mail.error.to}")
    private String mailErrorAddress; // E

    @Value("${mail.search.name}")
    private String searchName; // Results not found report

    @Value("${mail.search.address}")
    private String searchAddress; // Results not found report

    @Value("${mail.support.name}")
    private String helpDeskName; // Results not found report

    @Value("${mail.support.address}")
    private String helpDeskAddress; // Results not found report

    @Autowired
    public MailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    @SuppressWarnings("WeakerAccess")
    public void start(final String fromName, final String fromAddress, final String toAddress, final String subject, final String msgBody) {
        mailSender.send(mimeMessage -> {
            //Preparing the sender address
            InternetAddress from = new InternetAddress(fromAddress);
            if (StringUtils.isNotBlank(fromName)) {
                from = new InternetAddress(fromAddress, fromName);
            }

            mimeMessage.setFrom(from);
            mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
            mimeMessage.setSubject(subject);
            mimeMessage.setText(msgBody);
        });
    }

    //When using AWS SMTP, the emails cannot longer be sent as if the user was the sender due to the address validation.
    //A third email address (searchAddress) is needed because when the help desk email is used as sender, it cannot be
    //reused as recipient (the list itself will prevent its delivery).
    public void help(final String toName, final String toAddress, final String subject, final String msgBody) {
        mailSender.send(mimeMessage -> {
            //Preparing the sender address
            InternetAddress search = new InternetAddress(searchAddress, searchName);
            //Preparing the help desk address (the reply-to)
            InternetAddress help = new InternetAddress(helpDeskAddress, helpDeskName);
            //Preparing the receiver address
            InternetAddress user = new InternetAddress(toAddress);
            if (StringUtils.isNotBlank(toName)) user = new InternetAddress(toAddress, toName);

            Address[] recipients = new Address[2];
            recipients[0] = user;
            recipients[1] = help;

            //Building up the message parts
            mimeMessage.setFrom(search);
            mimeMessage.setReplyTo(recipients);
            mimeMessage.addRecipients(Message.RecipientType.TO, recipients);
            mimeMessage.setSubject(subject);
            mimeMessage.setText(msgBody);
        });
    }

    //When using AWS SMTP, the emails cannot longer be sent as if the user was the sender due to the address validation.
    //A third email address (searchAddress) is needed because when the help desk email is used as sender, it cannot be
    //reused as recipient (the list itself will prevent its delivery).
    public void help2(final String toName, final String toAddress, final String subject, final String msgBody) {
        mailSender.send(mimeMessage -> {
            //Preparing the sender address
            InternetAddress search = new InternetAddress(searchAddress, searchName);
            //Preparing the help desk address (the reply-to)
            InternetAddress help = new InternetAddress(helpDeskAddress, helpDeskName);
            //Preparing the receiver address
            InternetAddress user = new InternetAddress(toAddress);
            if (StringUtils.isNotBlank(toName)) user = new InternetAddress(toAddress, toName);

            Address[] recipients = new Address[1];
            recipients[0] = help;

            //Building up the message parts
            mimeMessage.setFrom(search);
            mimeMessage.setReplyTo(recipients);
            mimeMessage.setRecipient(Message.RecipientType.TO, user);
            mimeMessage.setRecipient(Message.RecipientType.BCC, help);
            mimeMessage.setSubject(subject);
            mimeMessage.setText(msgBody);
        });
    }

    public void error(final String toName, final String toAddress, final String subject, final String msgBody) {
        mailSender.send(mimeMessage -> {
            //Preparing the sender address
            InternetAddress from = new InternetAddress(mailErrorAddress, mailErrorAddress);
            //Preparing the receiver address
            InternetAddress to = new InternetAddress(toAddress);
            if (StringUtils.isNotBlank(toName)) to = new InternetAddress(toAddress, toName);
            //Building up the message parts
            mimeMessage.setFrom(from);
            mimeMessage.setRecipient(Message.RecipientType.TO, to);
            mimeMessage.setSubject(subject);
            mimeMessage.setText(msgBody);
        });
    }
}
