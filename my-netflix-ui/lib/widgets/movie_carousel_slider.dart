import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie_summary.dart';

class MovieCarouselSlider extends StatefulWidget {
  final String title;
  final List<MovieSummary> movies;
  final void Function(MovieSummary)? onTap; // ✅ New optional callback

  const MovieCarouselSlider({
    super.key,
    required this.title,
    required this.movies,
    this.onTap, // ✅ Allow tap handler from parent
  });

  @override
  State<MovieCarouselSlider> createState() => _MovieCarouselSliderState();
}

class _MovieCarouselSliderState extends State<MovieCarouselSlider> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients && widget.movies.isNotEmpty) {
        final nextPage = (_currentPage + 1) % widget.movies.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  String _fixImageUrl(String url) {
    return url.startsWith('http')
        ? url
        : 'https://image.tmdb.org/t/p/w1280$url';
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final isTablet = screenSize.shortestSide >= 600 && screenSize.width < 1024;
    final isDesktop = screenSize.width >= 1024;

    final double bannerHeight = isDesktop
        ? screenSize.height * 0.5
        : isTablet
        ? screenSize.height * 0.45
        : screenSize.height * 0.4;

    final double titleFontSize = isDesktop
        ? 28
        : isTablet
        ? 26
        : 24;
    final double subtitleFontSize = isDesktop
        ? 16
        : isTablet
        ? 15
        : 14;
    final double buttonFontSize = isDesktop
        ? 16
        : isTablet
        ? 15
        : 14;
    final double iconSize = isDesktop
        ? 28
        : isTablet
        ? 24
        : 20;

    final double buttonPaddingH = screenSize.width * 0.05;
    final double buttonPaddingV = screenSize.height * 0.015;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        const SizedBox(height: 12),

        // 🎞 Carousel Slider
        SizedBox(
          height: bannerHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.movies.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              final imageUrl = movie.backdropUrl.isNotEmpty
                  ? _fixImageUrl(movie.backdropUrl)
                  : 'https://via.placeholder.com/500x300.png?text=No+Image';

              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () =>
                      widget.onTap?.call(movie), // ✅ Call external handler
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 24,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                  shadows: const [
                                    Shadow(blurRadius: 6, color: Colors.black),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${movie.genre} | ${movie.contentType} | ${movie.durationFormatted}',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: subtitleFontSize,
                                  fontWeight: FontWeight.w500,
                                  shadows: const [
                                    Shadow(blurRadius: 4, color: Colors.black),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          left: 0,
                          right: 38,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(21),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(
                                      0.2,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: buttonPaddingH,
                                      vertical: buttonPaddingV,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(21),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () => widget.onTap?.call(
                                    movie,
                                  ), // ✅ Tap from button
                                  icon: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: iconSize,
                                  ),
                                  label: Text(
                                    'Watch Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: buttonFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // 🔘 Dot Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.movies.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 8,
              width: _currentPage == index ? 20 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.red : Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),
      ],
    );
  }
}
