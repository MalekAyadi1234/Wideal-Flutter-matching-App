import 'package:flutter/material.dart';

class ILine extends StatelessWidget {
  final double margin;
  ILine({this.margin = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: margin, right: margin, top: 10, bottom: 10),
      height: 0.5,
      color: Colors.grey,
    );
  }
}