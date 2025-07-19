import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_ui/bloc/movie_bloc.dart';
import 'package:netflix_ui/screens/app_navbar_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingData {
  final String title;
  final String subtitle;
  final String imageAsset;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> pages = [
    OnboardingData(
      title: 'Unlimited movies, TV\nshows and more',
      subtitle: 'Starts at ₹149. Cancel at any time.',
      imageAsset: 'assets/images/intro_banner.png',
    ),
    OnboardingData(
      title: 'Watch Anywhere',
      subtitle: 'Stream on your phone, tablet, laptop, and TV.',
      imageAsset: 'assets/animations/intro2.json',
    ),
    OnboardingData(
      title: 'Download and Go',
      subtitle: 'Save your favorites and watch offline anytime.',
      imageAsset: 'assets/images/third_image.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    final isLast = _currentPage == pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: screenHeight * 0.08),
                            if (page.imageAsset.endsWith('.json'))
                              Lottie.asset(
                                page.imageAsset,
                                height: screenHeight * 0.45,
                                width: screenWidth * 0.8,
                                fit: BoxFit.contain,
                              )
                            else
                              Image.asset(
                                page.imageAsset,
                                height: screenHeight * 0.45,
                                width: screenWidth * 0.8,
                                fit: BoxFit.contain,
                              ),
                            SizedBox(height: screenHeight * 0.06),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                              child: Text(
                                page.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth.clamp(18.0, 28.0), // adaptive
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                              child: Text(
                                page.subtitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: screenWidth.clamp(12.0, 18.0), // adaptive
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Page indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pages.length, (i) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: i == _currentPage ? 16 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _currentPage ? Colors.red : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 18),

                // Button
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.035),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLast) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => MovieBloc(),
                              child: const AppNavbarScreen(),
                            ),
                          ),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.12,
                        vertical: screenHeight * 0.016,
                      ),
                    ),
                    child: Text(
                      isLast ? 'Get Started' : 'Next',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
