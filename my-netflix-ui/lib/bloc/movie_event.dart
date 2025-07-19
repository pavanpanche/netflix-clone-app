part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTopRatedMovies extends MovieEvent {}

class LoadUpcomingMovies extends MovieEvent {}

class LoadRecentMovies extends MovieEvent {}

class LoadPopularMovies extends MovieEvent {}

class LoadTrendingMovies extends MovieEvent {}

class LoadAllMovies extends MovieEvent {}

class SearchMoviesEvent extends MovieEvent {
  final String query;

  SearchMoviesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

// ✅ New event for loading a single movie by ID (used in HomeScreen tap)
class LoadMovieById extends MovieEvent {
  final int movieId;

  LoadMovieById(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
