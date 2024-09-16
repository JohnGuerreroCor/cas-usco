package com.usco;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UscoPasswordEncode implements PasswordEncoder {
    private final Logger log = LoggerFactory.getLogger(UscoPasswordEncode.class);

    @Override
    public String encode(final CharSequence password) {
        log.warn("---------------------------------encode-------------------------------------");
        MessageDigest mdSha = null;
        MessageDigest mdMd5 = null;
        String result = "";
        try {
            mdSha = MessageDigest.getInstance("SHA1");
            mdMd5 = MessageDigest.getInstance("md5");
            byte[] byteshashed = mdMd5.digest(mdSha.digest(password.toString().getBytes()));

            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteshashed.length; i++) {
                sb.append(Integer.toString((byteshashed[i] & 0xff) + 0x100, 16).substring(1));
            }
            result = sb.toString().toUpperCase();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        log.warn("-------- RESULT: " + result + "---------------------------------");
        return "0x" + result;
    }

    @Override
    public boolean matches(final CharSequence rawPassword, final String encodedPassword) {
        log.info("-------------------------------matches---------------------------------------");
        final String encodedRawPassword = StringUtils.isNotBlank(rawPassword) ? encode(rawPassword.toString()) : null;
        final boolean matched = StringUtils.equals(encodedRawPassword, encodedPassword);
        return matched;
    }
}