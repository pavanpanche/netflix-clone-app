import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:netflix_ui/screens/home_screen.dart';
import 'package:netflix_ui/bloc/movie_bloc.dart';
import 'package:netflix_ui/screens/search_screen.dart';
import 'package:netflix_ui/screens/user_profile_screen.dart'; // ✅ Add this import
class AppNavbarScreen extends StatelessWidget {
  const AppNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieBloc(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: const SafeArea(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                SearchScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.black,
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Iconsax.home5), text: "Home"),
                Tab(icon: Icon(Iconsax.search_normal), text: "Search"),
                Tab(icon: Icon(Iconsax.profile_circle), text: "Profile"),
              ],
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              indicatorColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}


