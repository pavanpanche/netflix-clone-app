import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_details.dart';
import '../models/movie_summary.dart';

class MovieApiService {
  static const String baseUrl = 'http://192.168.31.31:8080/api/movies';

  Future<List<MovieSummary>> fetchAllMovies() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => MovieSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieSummary>> fetchTrendingMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/trending'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => MovieSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<MovieSummary>> fetchRecentMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/recent'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => MovieSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load recent movies');
    }
  }

  Future<List<MovieSummary>> fetchUpcomingMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/upcoming'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => MovieSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<MovieSummary>> fetchTopRatedMovies() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/top-rated'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => MovieSummary.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load top-rated movies');
      }
    } catch (e) {
      print("Top-rated error: $e");
      rethrow;
    }
  }

  Future<List<MovieSummary>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/popular'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => MovieSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<MovieDetail> fetchMovieById(int id) async {
    final url = '$baseUrl/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  Future<List<MovieSummary>> searchMovies(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = '$baseUrl/search?keyword=$encodedQuery';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => MovieSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
