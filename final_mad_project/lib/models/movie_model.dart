import 'package:final_mad_project/models/cast_model.dart';
import 'package:flutter/material.dart';

class MovieModel{
   int? id;
  String? name;
  List<String>? genre;
  double? rating;
  String? director;
  String? storyLine;
  Image? image;
  Image? imageLogo;
  List<MovieCastModel>? castList = List.empty(growable: true);

  MovieModel({this.id,this.name,this.genre,this.rating,this.director,this.storyLine,this.image,this.imageLogo, required List<MovieCastModel> castList});

}