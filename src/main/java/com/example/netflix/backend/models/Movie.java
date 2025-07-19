package com.example.netflix.backend.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "Title is required")
    private String title;

    @Lob
    @NotBlank(message = "Description is required")
    private String description;

    @NotBlank(message = "Genre is required")
    private String genre;

    @NotBlank(message = "Content type is required (e.g., Movie/Series)")
    private String contentType;

    @NotBlank(message = "Poster URL is required")
    private String posterUrl;

    private String previewUrl;

    @NotBlank(message = "Video URL is required")
    private String videoUrl;

    @NotNull(message = "Duration (in minutes) is required")
    @Min(value = 1, message = "Duration must be at least 1 minute")
    private Integer durationInMinutes;

    private String durationFormatted;

    private LocalDateTime createdDate;

    @NotNull(message = "Rating is required")
    @DecimalMin(value = "0.0", inclusive = true)
    @DecimalMax(value = "10.0", inclusive = true)
    private Double rating;

    @Column(nullable = true)
    private String backdropUrl;

    @FutureOrPresent(message = "Release date must be today or in the future")
    private LocalDate releaseDate; // ✅ Used to support upcoming movies

    @PrePersist
    protected void onCreate() {
        this.createdDate = LocalDateTime.now();
    }
}
