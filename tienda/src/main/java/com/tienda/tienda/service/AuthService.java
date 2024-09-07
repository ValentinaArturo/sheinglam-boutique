package com.tienda.tienda.service;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final String SECRET_KEY = "secret"; // Asegúrate de que esta clave sea segura

    public String generateToken(String username) {
        return Jwts.builder()
                .setSubject(username)
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public String extractUsername(String token) {
        return Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }
}
