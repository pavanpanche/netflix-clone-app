package com.example.netflix.backend.controller;

import com.example.netflix.backend.dto.MovieDetailDTO;
import com.example.netflix.backend.dto.MovieSummaryDTO;
import com.example.netflix.backend.mapper.MovieMapper;
import com.example.netflix.backend.models.Movie;
import com.example.netflix.backend.service.MovieService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/movies")
@RequiredArgsConstructor
public class MovieController {

    private final MovieService movieService;

    // USER USE CASE ENDPOINTS
    // Get All Movies with Pagination
    @GetMapping
    public ResponseEntity<List<MovieSummaryDTO>> getAllMovies(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(
                movieService.getAllMoviesPaginated(page, size).stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList()));
    }
    @GetMapping("/top-rated")
    public ResponseEntity<List<MovieSummaryDTO>> getTopRatedMovies() {
        return ResponseEntity.ok(
                movieService.getTopRatedMovies().stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList())
        );
    }
    @GetMapping("/upcoming")
    public ResponseEntity<List<MovieSummaryDTO>> getUpcomingMovies() {
        return ResponseEntity.ok(
                movieService.getUpcomingMovies().stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList())
        );
    }



    // ✅ Get Movie Details
    @GetMapping("/{id}")
    public ResponseEntity<?> getMovieById(@PathVariable Integer id) {
        try {
            Movie movie = movieService.getMovieById(id);
            MovieDetailDTO dto = MovieMapper.toDetailDTO(movie);
            return ResponseEntity.ok(dto);
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }

    // ✅ Search Movies by Keyword with Pagination
    @GetMapping("/search")
    public ResponseEntity<List<MovieSummaryDTO>> searchMovies(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(
                movieService.searchMoviesByTitlePaginated(keyword, page, size).stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList()));
    }

    // ✅ Filter by Genre with Pagination
    @GetMapping("/genre/{genre}")
    public ResponseEntity<List<MovieSummaryDTO>> getByGenre(
            @PathVariable String genre,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(
                movieService.getMoviesByGenrePaginated(genre, page, size).stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList()));
    }

    // Filter by Content Type
    @GetMapping("/content-type/{type}")
    public ResponseEntity<List<MovieSummaryDTO>> getByContentType(@PathVariable("type") String contentType) {
        return ResponseEntity.ok(
                movieService.getMoviesByContentType(contentType).stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList()));
    }

    // Get Recent Movies
    @GetMapping("/recent")
    public ResponseEntity<List<MovieSummaryDTO>> getRecentMovies() {
        return ResponseEntity.ok(
                movieService.getRecentMovies().stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList()));
    }

    // ✅ Filter by Genre + ContentType
    @GetMapping("/filter")
    public ResponseEntity<List<MovieSummaryDTO>> getByGenreAndType(
            @RequestParam String genre,
            @RequestParam String contentType) {
        return ResponseEntity.ok(
                movieService.getMoviesByGenreAndContentType(genre, contentType).stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList()));
    }

    // ✅ Top 10 Popular Movies by Rating
    @GetMapping("/popular")
    public ResponseEntity<List<MovieSummaryDTO>> getPopularMovies() {
        return ResponseEntity.ok(
                movieService.getPopularMovies().stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList()));
    }

    // ✅ Trending Movies by Recent Date
    @GetMapping("/trending")
    public ResponseEntity<List<MovieSummaryDTO>> getTrendingMovies() {
        return ResponseEntity.ok(
                movieService.getTrendingMovies().stream()
                        .map(MovieMapper::toSummaryDTO)
                        .collect(Collectors.toList()));
    }

    // ================================
    // 🔐 ADMIN USE CASE ENDPOINTS
    // ================================

    @PostMapping("/bulk")
    public ResponseEntity<?> createMultipleMovies(@RequestBody List<Movie> movies) {
        try {
            List<Movie> saved = movies.stream()
                    .map(movieService::saveMovie)
                    .collect(Collectors.toList());
            return ResponseEntity.ok(saved);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Failed to save movies: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateMovie(@PathVariable Integer id, @RequestBody Movie updatedMovie) {
        try {
            updatedMovie.setId(id);
            Movie updated = movieService.saveMovie(updatedMovie);
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update movie: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteMovie(@PathVariable Integer id) {
        try {
            movieService.deleteMovie(id);
            return ResponseEntity.ok("Movie deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(404).body("Movie not found: " + e.getMessage());
        }
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleAllExceptions(Exception e) {
        return ResponseEntity.status(500).body("Internal Server Error: " + e.getMessage());
    }
}
