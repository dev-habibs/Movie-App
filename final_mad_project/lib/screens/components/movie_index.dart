import 'package:final_mad_project/constants/constant.dart';
import 'package:final_mad_project/data/data.dart';
import 'package:final_mad_project/models/movie_model.dart';
import 'package:final_mad_project/screens/booking_screen.dart';
import 'package:final_mad_project/screens/components/custom_appbar.dart';
import 'package:final_mad_project/widget/genres_format.dart';
import 'package:final_mad_project/widget/movie_name.dart';
import 'package:final_mad_project/widget/star_rating.dart';
import 'package:flutter/material.dart';

class MovieIndex extends StatefulWidget {
  final int index;
  final double movieitemWidth;
  final ScrollController movieScrollController;

  // final String movieName;

  MovieIndex(this.index, this.movieitemWidth, this.movieScrollController);

  @override
  State<MovieIndex> createState() => _MovieIndexState();
}

class _MovieIndexState extends State<MovieIndex> {
  var movieData = MovieData();
  double maxMovieTranslate = 65;
  double _movieTranslate(double offset, double activeOffset) {
    double translate;
    if (widget.movieScrollController.offset + widget.movieitemWidth <=
        activeOffset) {
      translate = maxMovieTranslate;
    } else if (widget.movieScrollController.offset <= activeOffset) {
      translate = maxMovieTranslate -
          ((widget.movieScrollController.offset -
                  (activeOffset - widget.movieitemWidth)) /
              widget.movieitemWidth *
              maxMovieTranslate);
    } else if (widget.movieScrollController.offset <
        activeOffset + widget.movieitemWidth) {
      translate = ((widget.movieScrollController.offset -
                  (activeOffset - widget.movieitemWidth)) /
              widget.movieitemWidth *
              maxMovieTranslate) -
          maxMovieTranslate;
    } else {
      translate = maxMovieTranslate;
    }
    return translate;
  }

  double _movieDescriptionOpacity(double offset, double activeOffset) {
    double opacity;
    if (widget.movieScrollController.offset + widget.movieitemWidth <=
        activeOffset) {
      opacity = 0;
    } else if (widget.movieScrollController.offset <= activeOffset) {
      opacity = ((widget.movieScrollController.offset -
              (activeOffset - widget.movieitemWidth)) /
          widget.movieitemWidth *
          100);
    } else if (widget.movieScrollController.offset <
        activeOffset + widget.movieitemWidth) {
      opacity = 100 -
          (((widget.movieScrollController.offset -
                      (activeOffset - widget.movieitemWidth)) /
                  widget.movieitemWidth *
                  100) -
              100);
    } else {
      opacity = 0;
    }
    return opacity;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: appPadding + 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // AnimatedBuilder(w
          //     animation: widget.movieScrollController,
          //     builder: (context, child) {
          //       double activeOffset = widget.index * widget.movieitemWidth;
          // controller : activeOffset;

          // double translate = _movieTranslate(
          //     widget.movieScrollController.offset, activeOffset);
          // return SizedBox(
          //     height: translate,
          //     );
          // }
          // ),

          SizedBox(
            height: size.height * 0.008,
          ),

          // Logo of Movie at Top
          Container(
            height: size.height * 0.15,
            child: Align(
              alignment: Alignment.center,
              child: Image(
                width: size.width / 2.5,
                image: movieData.movieList![widget.index].imageLogo!.image,
              ),
            ),
          ),

          // Rating on Genres Format( darma thriller info )
          GenresFormat(movieData.movieList![widget.index].genre, white),

          SizedBox(
            height: size.height * 0.008,
          ),

          // Rating on main screen Start
          StarRating(movieData.movieList![widget.index].rating),

          // Rating on main screen End

          SizedBox(
            height: size.height * 0.01,
          ),
          // Container(
          //   width: size.width * 0.25,
          //   height: 1.0,
          //   color: secondary.withOpacity(0.5),
          // ),
          SizedBox(
            height: size.height * 0.01,
          ),

          // Red Button Start Buy Ticket

          SizedBox(
            height: size.height * 0.01,
          ),
          // Image of movie
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            child: Image(
              image: movieData.movieList![widget.index].image!.image,
              width: size.width * 0.5,
              height: size.height * 0.35,
            ),
          ),

          // SizedBox(
          //   height: size.height * 0.01,
          // ),

          // AnimatedBuilder(
          // animation: widget.movieScrollController,
          // builder: (context, child) {
          // double activeOffset = widget.index * widget.movieitemWidth;
          // double opacity = _movieDescriptionOpacity(
          // widget.movieScrollController.offset, activeOffset);

          // return Opacity(
          // opacity: opacity / 100,
          MovieName(movieData.movieList![widget.index].name),
          SizedBox(
            height: size.height * 0.03,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookingScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.2, 1.0],
                  colors: [
                    Color.fromARGB(255, 243, 7, 86),
                    Color.fromARGB(255, 82, 9, 95),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              width: size.width * 0.55,
              height: size.height * 0.055,
              child: Center(
                child: Text(
                  'BUY TICKET',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
