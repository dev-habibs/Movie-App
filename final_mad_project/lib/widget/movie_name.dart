import 'package:final_mad_project/constants/constant.dart';
import 'package:flutter/material.dart';

class MovieName extends StatefulWidget {
  final String? name;

  MovieName(this.name);

  @override
  State<MovieName> createState() => _MovieNameState();
}

class _MovieNameState extends State<MovieName> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.name?.length ?? 0, (index) {
          if (index < widget.name!.length) {
            return Row(
              children: [
                Text(
                  widget.name![index],
                  style: TextStyle(
                      color: white, fontSize: 17, fontWeight: FontWeight.w900),
                ),
              ],
            );
          } else {
            return Text(
              widget.name![index],
              style: TextStyle(
                  color: white, fontSize: 12, fontWeight: FontWeight.w600),
            );
          }
        }));
  }
}
