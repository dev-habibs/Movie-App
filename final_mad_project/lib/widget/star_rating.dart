import 'package:final_mad_project/constants/constant.dart';
import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final double? rating;
  StarRating(this.rating);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    Widget star(bool fill){
      return Container(
        child: Icon(
          Icons.star,
          size: 18.0,
          color: fill ? primary: grey,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index){
        if(index < (widget.rating! / 2).round()){
          return star(true);
        }
        else{
          return star(false);
        }
      }),
    );
  }
}