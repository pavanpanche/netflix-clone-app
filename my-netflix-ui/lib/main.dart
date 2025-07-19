// ✅ main.dart (updated)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_ui/bloc/movie_bloc.dart';
import 'package:netflix_ui/screens/movie_detail_screen.dart';
import 'package:netflix_ui/screens/splash_screen.dart';
import 'package:netflix_ui/service/movie_api_service.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => MovieApiService())],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => MovieBloc())],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/details': (context) {
          final movieId = ModalRoute.of(context)!.settings.arguments as int;
          return MovieDetailScreen(movieId: movieId);
        },
      },
      title: 'Netflix Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
