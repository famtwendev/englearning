package com.englearning.identity.controller;

import com.englearning.identity.dto.AuthRequest;
import com.englearning.identity.dto.AuthResponse;
import com.englearning.identity.dto.RegisterRequest;
import com.englearning.identity.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService service;

    @PostMapping("/register")
    public ResponseEntity<com.englearning.identity.dto.ApiResponse<AuthResponse>> register(
            @Valid @RequestBody RegisterRequest request) {
        return ResponseEntity.ok(
                com.englearning.identity.dto.ApiResponse.success(service.register(request), "Registration successful"));
    }

    @PostMapping("/authenticate")
    public ResponseEntity<com.englearning.identity.dto.ApiResponse<AuthResponse>> authenticate(
            @Valid @RequestBody AuthRequest request) {
        return ResponseEntity.ok(com.englearning.identity.dto.ApiResponse.success(service.authenticate(request),
                "Authentication successful"));
    }
}
