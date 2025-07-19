import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../models/movie_summary.dart';
import '../widgets/movie_card.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            setState(() => _query = value.trim());
            if (_query.isNotEmpty) {
              context.read<MovieBloc>().add(SearchMoviesEvent(_query));
            }
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          } else if (state is MovieSearchSuccess) {
            final List<MovieSummary> results = state.movies;
            if (results.isEmpty) {
              return const Center(
                child: Text("No results found", style: TextStyle(color: Colors.white)),
              );
            }
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final movie = results[index];
                return MovieCard(movie: movie);
              },
            );
          } else if (state is MovieError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.white)),
            );
          }
          return const Center(
            child: Text('Search something...', style: TextStyle(color: Colors.white70)),
          );
        },
      ),
    );
  }
}
