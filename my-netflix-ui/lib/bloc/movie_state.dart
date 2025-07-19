part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

// ✅ Movie category list state
class MovieCategoryState extends MovieState {
  final List<MovieSummary> topRated;
  final List<MovieSummary> recent;
  final List<MovieSummary> upcoming;
  final List<MovieSummary> popular;

  const MovieCategoryState({
    this.topRated = const [],
    this.recent = const [],
    this.upcoming = const [],
    this.popular = const [],
  });

  MovieCategoryState copyWith({
    List<MovieSummary>? topRated,
    List<MovieSummary>? recent,
    List<MovieSummary>? upcoming,
    List<MovieSummary>? popular,
  }) {
    return MovieCategoryState(
      topRated: topRated ?? this.topRated,
      recent: recent ?? this.recent,
      upcoming: upcoming ?? this.upcoming,
      popular: popular ?? this.popular,
    );
  }

  @override
  List<Object> get props => [topRated, recent, upcoming, popular];
}

// ✅ Search result state
class MovieSearchSuccess extends MovieState {
  final List<MovieSummary> movies;

  const MovieSearchSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

// ✅ Loaded single movie detail state
class MovieDetailLoaded extends MovieState {
  final MovieDetail movie;

  const MovieDetailLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}
