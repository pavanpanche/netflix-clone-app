package com.example.netflix.backend.controller;

import com.example.netflix.backend.dto.JwtResponseDTO;
import com.example.netflix.backend.dto.LoginRequest;
import com.example.netflix.backend.security.MyUserDetails;
import com.example.netflix.backend.security.MyUserDetailsServiceImpl;
import com.example.netflix.backend.security.jwt.JwtUtil;
import com.example.netflix.backend.service.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final MyUserDetailsServiceImpl userDetailsService;
    private final JwtUtil jwtUtil;

    @PostMapping("/login")
    public ResponseEntity<JwtResponseDTO> login(@Valid @RequestBody LoginRequest request) {
        String token = authService.login(request.getEmail(), request.getPassword());
        MyUserDetails userDetails = (MyUserDetails) userDetailsService.loadUserByUsername(request.getEmail());

        List<String> roles = userDetails.getAuthorities().stream()
                .map(r -> r.getAuthority().replace("ROLE_", ""))
                .toList();

        JwtResponseDTO response = new JwtResponseDTO(token, request.getEmail(), roles);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/refresh")
    public ResponseEntity<JwtResponseDTO> refresh(@RequestHeader("Authorization") String authHeader) {
        String token = authHeader.replace("Bearer ", "");
        String newToken = authService.refreshToken(token);

        String email = jwtUtil.extractUsername(newToken);
        MyUserDetails userDetails = (MyUserDetails) userDetailsService.loadUserByUsername(email);
        List<String> roles = userDetails.getAuthorities().stream()
                .map(r -> r.getAuthority().replace("ROLE_", ""))
                .toList();

        JwtResponseDTO response = new JwtResponseDTO(newToken, email, roles);
        return ResponseEntity.ok(response);
    }
}
