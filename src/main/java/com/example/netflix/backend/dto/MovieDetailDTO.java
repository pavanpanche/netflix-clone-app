package com.example.netflix.backend.dto;

import lombok.Builder;
import lombok.Getter;


@Getter
@Builder
public class MovieDetailDTO {
        private Integer id;
        private String title;
        private String genre;
        private String contentType;
        private String posterUrl;
        private String previewUrl;
        private String videoUrl;
        private String description;
        private Integer durationInMinutes;
        private String durationFormatted;
    }


