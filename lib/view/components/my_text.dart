import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final FontWeight weight;
  dynamic size;
  dynamic color;
  dynamic maxLines;

  MyText({
    super.key,
    required this.text,
    required this.weight,
    this.size,
    this.color = Colors.black,
    this.maxLines = null
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // maxLines: maxLines == null ? 5 : null,
      // overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "pop",
        fontWeight: weight,
        fontSize: size,
        color: color,
      ),
    );
  }
}
