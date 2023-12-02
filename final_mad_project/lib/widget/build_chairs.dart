import 'package:final_mad_project/constants/constant.dart';
import 'package:flutter/material.dart';

class BuildChairs {
  static Widget selectedChairs() {
    return Expanded(
        child: FittedBox(
            child: Icon(
              Icons.chair,
              color: Color.fromARGB(255, 35, 252, 252),
            ),
            fit: BoxFit.cover));
  }

  static Widget availableChairs() {
    return Expanded(
        child: FittedBox(
            child: Icon(
              Icons.chair,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            fit: BoxFit.cover));
  }

  static Widget reservedChairs() {
    return Expanded(
        child: FittedBox(
            child: Icon(
              Icons.chair,
              color: Color.fromARGB(255, 177, 1, 59),
            ),
            fit: BoxFit.cover));

    // height: 10.0,
    // width: 10.0,

    // decoration: BoxDecoration(
    //   color: white,
    //   borderRadius:  BorderRadius.circular(6.0)
    // ),
  }
}
