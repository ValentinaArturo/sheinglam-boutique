package com.tienda.tienda.security;

import com.tienda.tienda.service.AuthService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfiguration {

    private final AuthService authService;

    public SecurityConfig(AuthService authService) {
        this.authService = authService;
    }

    protected void configure(HttpSecurity http) throws Exception {
        JwtAuthenticationFilter jwtFilter = new JwtAuthenticationFilter(authService);

        http.csrf().disable()
            .authorizeRequests()
            .requestMatchers("/auth/login").permitAll()
            .anyRequest().authenticated()
            .and()
            .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
