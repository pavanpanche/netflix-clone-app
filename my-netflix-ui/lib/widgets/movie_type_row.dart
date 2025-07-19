import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie_summary.dart';

class MovieTypeRow extends StatelessWidget {
  final String title;
  final List<MovieSummary> movies;
  final Function(MovieSummary) onTap; // ✅ Add callback for tap

  const MovieTypeRow({
    super.key,
    required this.title,
    required this.movies,
    required this.onTap, // ✅ Required
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => onTap(movie), // ✅ Call parent handler
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        movie.posterUrl.isNotEmpty
                            ? (movie.posterUrl.startsWith('http')
                                  ? movie.posterUrl
                                  : 'https://image.tmdb.org/t/p/w500${movie.posterUrl}')
                            : 'https://via.placeholder.com/500x280.png?text=No+Image',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
