package com.example.netflix.backend.repository;

import com.example.netflix.backend.models.Movie;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface MovieRepository extends JpaRepository<Movie, Integer> {

    // Non-paginated methods
    List<Movie> findByTitle(String title);
    List<Movie> findByContentType(String contentType);
    List<Movie> findByGenre(String genre);
    List<Movie> findByTitleContainingIgnoreCase(String keyword);
    List<Movie> findAllByOrderByCreatedDateDesc();
    List<Movie> findByGenreAndContentType(String genre, String contentType);
    List<Movie> findTop10ByOrderByRatingDesc();
    List<Movie> findTop10ByOrderByCreatedDateDesc();
    List<Movie> findByReleaseDateAfter(LocalDate date);

    // Pagination use case
    Page<Movie> findAll(Pageable pageable);
    List<Movie> findByGenre(String genre, Pageable pageable);
    List<Movie> findByTitleContainingIgnoreCase(String keyword, Pageable pageable);
}
