// tile definition
import 'package:flutter/material.dart';

import '../model.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.model,
    required this.leftPadding,
    required this.rightPadding,
    required this.animation,
    required this.offset,
  }) : super(key: key);
  final Model model;
  final double leftPadding;
  final double rightPadding;
  final Animation<double> animation; //64 and 8 is a good proportion
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: offset, end: Offset.zero).animate(
        CurvedAnimation(parent: animation, curve: Curves.decelerate),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: leftPadding, bottom: 8, right: rightPadding, top: 8),
        child: Container(
          decoration: BoxDecoration(
              color: model.color,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10)),
          height: MediaQuery.of(context).size.height / 12,
          child: Center(
            child: Text(
              model.text,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}
