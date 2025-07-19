package com.example.netflix.backend.dto;


import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MovieSummaryDTO {
        private Integer id;
        private String title;
        private String genre;
        private String contentType;
        private String backdropUrl;
        private String posterUrl;
    }



