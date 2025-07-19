package com.example.netflix.backend.service.impl;

import com.example.netflix.backend.models.Movie;
import com.example.netflix.backend.repository.MovieRepository;
import com.example.netflix.backend.service.MovieService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MovieServiceImpl implements MovieService {

    private final MovieRepository movieRepository;

    @Override
    public Movie saveMovie(Movie movie) {
        return movieRepository.save(movie);
    }

    @Override
    public List<Movie> getAllMovies() {
        return movieRepository.findAll();
    }
    @Override
    public List<Movie> getTopRatedMovies() {
        return movieRepository.findTop10ByOrderByRatingDesc(); // ✅ Already present in your repo
    }
    @Override
    public List<Movie> getUpcomingMovies() {
        return movieRepository.findByReleaseDateAfter(LocalDate.now());
    }


    @Override
    public List<Movie> getAllMoviesPaginated(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return movieRepository.findAll(pageable).getContent();
    }

    @Override
    public Movie getMovieById(Integer id) {
        return movieRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Movie not found with id: " + id));
    }

    @Override
    public void deleteMovie(Integer id) {
        movieRepository.deleteById(id);
    }

    @Override
    public List<Movie> getMoviesByGenre(String genre) {
        return movieRepository.findByGenre(genre);
    }

    @Override
    public List<Movie> getMoviesByGenrePaginated(String genre, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return movieRepository.findByGenre(genre, pageable);
    }

    @Override
    public List<Movie> getMoviesByContentType(String contentType) {
        return movieRepository.findByContentType(contentType);
    }

    @Override
    public List<Movie> searchMoviesByTitle(String keyword) {
        return movieRepository.findByTitleContainingIgnoreCase(keyword);
    }

    @Override
    public List<Movie> searchMoviesByTitlePaginated(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return movieRepository.findByTitleContainingIgnoreCase(keyword, pageable);
    }

    @Override
    public List<Movie> getRecentMovies() {
        return movieRepository.findAllByOrderByCreatedDateDesc();
    }

    @Override
    public List<Movie> getMoviesByGenreAndContentType(String genre, String contentType) {
        return movieRepository.findByGenreAndContentType(genre, contentType);
    }

    @Override
    public List<Movie> getPopularMovies() {
        return movieRepository.findTop10ByOrderByRatingDesc();
    }

    @Override
    public List<Movie> getTrendingMovies() {
        return movieRepository.findTop10ByOrderByCreatedDateDesc();
    }
}
