package com.example.netflix.backend.exception;

public class InvalidMovieDataException extends RuntimeException {
    public InvalidMovieDataException(String message) {
        super(message);
    }
}
