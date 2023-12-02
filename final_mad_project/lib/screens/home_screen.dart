import 'package:final_mad_project/constants/constant.dart';
import 'package:final_mad_project/screens/components/movie_list_view.dart';
import 'package:flutter/material.dart';

import 'components/background_list_view.dart';
import 'components/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  Size get size => MediaQuery.of(context).size;
  // TO center the movie list View
  double get movieItemWidth => size.width / 2 + 48;
  ScrollController backgroundScrollController = ScrollController();
  ScrollController movieScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // Connecting backgorund and movielist

    movieScrollController.addListener(() {
      backgroundScrollController
          .jumpTo(movieScrollController.offset * (size.width / movieItemWidth));
    });
    return Scaffold(
      backgroundColor: black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background of home screen
          BackgroundListView(backgroundScrollController),

          // Movie Detail list view
          MovieListView(movieItemWidth, movieScrollController),
          CustomAppBar(),

          // animation with background list with movie list items
          // connect both controllers
        ],
      ),
    );
  }
}
