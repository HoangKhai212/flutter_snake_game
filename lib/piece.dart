import 'package:flutter/material.dart';

class Piece extends StatefulWidget {
  const Piece(
      {Key? key,
      required this.posX,
      required this.posY,
      required this.size,
      this.color = const Color(0XFFBF3100),
      this.isAnimated = false})
      : super(key: key);
  final int posX, posY;
  final int size;
  final Color color;
  final bool isAnimated;

  @override
  State<Piece> createState() => _PieceState();
}

class _PieceState extends State<Piece> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.25,
        upperBound: 1.0,
        duration: Duration(microseconds: 1000));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.posX.toDouble(),
        top: widget.posY.toDouble(),
        child: Opacity(
          opacity: widget.isAnimated ? animationController.value : 1.0,
          child: Container(
            width: widget.size.toDouble(),
            height: widget.size.toDouble(),
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.size.toDouble()),
                ),
                border: Border.all(color: Colors.black, width: 2.0)),
          ),
        ));
  }
}
