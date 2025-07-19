import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/movie_summary.dart';
import '../models/movie_details.dart';
import '../service/movie_api_service.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieApiService _apiService = MovieApiService();

  MovieCategoryState _getCurrentState(MovieState state) {
    return state is MovieCategoryState ? state : const MovieCategoryState();
  }

  MovieBloc() : super(const MovieCategoryState()) {
    // 🔹 Load all movies for home
    on<LoadAllMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final topRated = await _apiService.fetchTopRatedMovies();
        final recent = await _apiService.fetchRecentMovies();
        final upcoming = await _apiService.fetchUpcomingMovies();
        final popular = await _apiService.fetchPopularMovies();

        emit(
          MovieCategoryState(
            topRated: topRated,
            recent: recent,
            upcoming: upcoming,
            popular: popular,
          ),
        );
      } catch (e) {
        emit(MovieError("Failed to load movie categories: ${e.toString()}"));
      }
    });

    on<LoadTopRatedMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await _apiService.fetchTopRatedMovies();
        final current = _getCurrentState(state);
        emit(current.copyWith(topRated: movies));
      } catch (e) {
        emit(MovieError("Failed to load top-rated movies: ${e.toString()}"));
      }
    });

    on<LoadUpcomingMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await _apiService.fetchUpcomingMovies();
        final current = _getCurrentState(state);
        emit(current.copyWith(upcoming: movies));
      } catch (e) {
        emit(MovieError("Failed to load upcoming movies: ${e.toString()}"));
      }
    });

    on<LoadRecentMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await _apiService.fetchRecentMovies();
        final current = _getCurrentState(state);
        emit(current.copyWith(recent: movies));
      } catch (e) {
        emit(MovieError("Failed to load recent movies: ${e.toString()}"));
      }
    });

    on<LoadPopularMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await _apiService.fetchPopularMovies();
        final current = _getCurrentState(state);
        emit(current.copyWith(popular: movies));
      } catch (e) {
        emit(MovieError("Failed to load popular movies: ${e.toString()}"));
      }
    });

    on<SearchMoviesEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final results = await _apiService.searchMovies(event.query);
        emit(MovieSearchSuccess(results));
      } catch (e) {
        emit(MovieError("Search failed: ${e.toString()}"));
      }
    });

    // ✅ Load single movie detail by ID
    on<LoadMovieById>((event, emit) async {
      emit(MovieLoading());
      try {
        final movie = await _apiService.fetchMovieById(event.movieId);
        emit(MovieDetailLoaded(movie));
      } catch (e) {
        emit(MovieError("Failed to load movie details: ${e.toString()}"));
      }
    });
  }
}
