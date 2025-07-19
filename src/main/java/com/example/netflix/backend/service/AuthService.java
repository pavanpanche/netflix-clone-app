package com.example.netflix.backend.service;

import com.example.netflix.backend.security.MyUserDetails;
import com.example.netflix.backend.security.MyUserDetailsServiceImpl;
import com.example.netflix.backend.security.jwt.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final JwtUtil jwtUtil;
    private final MyUserDetailsServiceImpl userDetailsService;

    public String login(String email, String password) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(email, password)
        );
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        return jwtUtil.generateToken(userDetails);
    }

    public String refreshToken(String oldToken) {
        if (jwtUtil.validateToken(oldToken)) {
            String username = jwtUtil.extractUsername(oldToken);
            MyUserDetails userDetails = (MyUserDetails) userDetailsService.loadUserByUsername(username);
            return jwtUtil.generateToken(userDetails);
        } else {
            throw new RuntimeException("Invalid refresh token");
        }
    }
}
