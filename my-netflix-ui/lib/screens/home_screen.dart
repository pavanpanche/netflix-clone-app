import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_ui/service/movie_api_service.dart';
import 'package:netflix_ui/widgets/movie_carousel_slider.dart';
import '../bloc/movie_bloc.dart';
import '../widgets/movie_type_row.dart';
import '../screens/video_player_screen.dart';
import '../models/movie_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(LoadAllMovies());
  }

  void _playVideo(MovieSummary movie) async {
    try {
      final movieService = context.read<MovieApiService>();

      final details = await movieService.fetchMovieById(movie.id);

      final url = details.videoUrl ?? details.previewUrl;
      if (url == null || url.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("No video URL found")));
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoUrl: url)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load movie details")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (state is MovieCategoryState) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 50),
                _buildAppBar(),
                const SizedBox(height: 12),
                _buildCategoryButtons(),
                const SizedBox(height: 10),

                /// 🔥 Main Carousel
                MovieCarouselSlider(
                  title: 'Now Playing',
                  movies: state.topRated,
                  onTap: _playVideo,
                ),

                const SizedBox(height: 30),
                MovieTypeRow(
                  title: "Recent Movies",
                  movies: state.recent,
                  onTap: _playVideo,
                ),
                const SizedBox(height: 10),
                MovieTypeRow(
                  title: "Trending",
                  movies: state.topRated,
                  onTap: _playVideo,
                ),
                const SizedBox(height: 10),
                MovieTypeRow(
                  title: "Upcoming",
                  movies: state.upcoming,
                  onTap: _playVideo,
                ),
                const SizedBox(height: 10),
                MovieTypeRow(
                  title: "Popular",
                  movies: state.popular,
                  onTap: _playVideo,
                ),
                const SizedBox(height: 20),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Image.asset("assets/images/Netflix_Logo.png", height: 40),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 24, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cast, size: 24, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.download_sharp,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          _buildFilterButton("TV Shows"),
          const SizedBox(width: 8),
          _buildFilterButton("Movies"),
          const SizedBox(width: 8),
          _buildFilterButtonWithIcon("Categories"),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String title) {
    return MaterialButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.white38),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFilterButtonWithIcon(String title) {
    return MaterialButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.white38),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ],
      ),
    );
  }
}
