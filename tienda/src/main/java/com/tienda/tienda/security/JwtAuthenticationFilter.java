package com.tienda.tienda.security;

import com.tienda.tienda.service.AuthService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final AuthService authService;

    public JwtAuthenticationFilter(AuthService authService) {
        this.authService = authService;
    }

   

	@Override
	protected void doFilterInternal(jakarta.servlet.http.HttpServletRequest request,
			jakarta.servlet.http.HttpServletResponse response, jakarta.servlet.FilterChain filterChain)
			throws jakarta.servlet.ServletException, IOException {
		 String authorizationHeader = request.getHeader("Authorization");

	        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
	            String token = authorizationHeader.substring(7);
	            if (authService.validateToken(token)) {
	                String username = authService.extractUsername(token);
	                UsernamePasswordAuthenticationToken authentication = 
	                    new UsernamePasswordAuthenticationToken(username, null, new ArrayList<>());
	                SecurityContextHolder.getContext().setAuthentication(authentication);
	            }
	        }

	        filterChain.doFilter(request, response); // Usar filterChain en lugar de chain
	}
}
