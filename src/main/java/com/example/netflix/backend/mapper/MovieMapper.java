package com.example.netflix.backend.mapper;

import com.example.netflix.backend.dto.MovieDetailDTO;
import com.example.netflix.backend.dto.MovieSummaryDTO;
import com.example.netflix.backend.models.Movie;

public class MovieMapper {

    public static MovieSummaryDTO toSummaryDTO(Movie movie) {
        return MovieSummaryDTO.builder()
                .id(movie.getId())
                .title(movie.getTitle())
                .genre(movie.getGenre())
                .contentType(movie.getContentType())
                .backdropUrl(movie.getBackdropUrl())
                .posterUrl(movie.getPosterUrl())
                .build();
    }

    public static MovieDetailDTO toDetailDTO(Movie movie) {
        return MovieDetailDTO.builder()
                .id(movie.getId())
                .title(movie.getTitle())
                .description(movie.getDescription())
                .genre(movie.getGenre())
                .contentType(movie.getContentType())
                .posterUrl(movie.getPosterUrl())
                .previewUrl(movie.getPreviewUrl())
                .videoUrl(movie.getVideoUrl())
                .durationInMinutes(movie.getDurationInMinutes())
                .durationFormatted(movie.getDurationFormatted())
                .build();
    }
}
