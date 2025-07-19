package com.example.netflix.backend.exception;

public class UserNotFoundException extends RuntimeException {
    public UserNotFoundException(String message) {
        super(message);
    }

    // Optional: Default constructor
    public UserNotFoundException() {
        super("User  not found");
    }
}
