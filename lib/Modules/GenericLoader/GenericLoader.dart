import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenericLoader extends StatefulWidget {
  final BuildContext parentContext; //!Very useful to get the default width
  const GenericLoader({Key? key, required this.parentContext})
      : super(key: key);

  @override
  _GenericLoaderState createState() =>
      _GenericLoaderState(parentContext: this.parentContext);
}

class _GenericLoaderState extends State<GenericLoader>
    with SingleTickerProviderStateMixin {
  final BuildContext parentContext; //!Very useful to get the default width
  late final double screenWidth; //The default screen width

  _GenericLoaderState({required this.parentContext}) {
    screenWidth = MediaQuery.of(this.parentContext).size.width;
  }

  late AnimationController _controller;
  late Animation verticalMotionAnimation; //Left and right motion
  late Animation widthAnimation; //Width  variation animation
  late Animation opacityAnimation; //Opacity variattion

  final double minWidth = 30; //The minimum width of the loader - default:30
  late final double maxWidth; //THe maximum width of the loader - default: 90

  final forwardInterval = Interval(0.0, 0.85, curve: Curves.easeInOutCubic);
  final endingInterval = Interval(0.85, 1.0, curve: Curves.easeInOut);

  @override
  void initState() {
    maxWidth = screenWidth *
        0.6; //Set the max width of the loader based on the screen width

    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 750), vsync: this);

    verticalMotionAnimation = new Tween(begin: 0.0, end: screenWidth)
        .animate(CurvedAnimation(parent: _controller, curve: forwardInterval));

    widthAnimation = new Tween(begin: minWidth, end: maxWidth)
        .animate(CurvedAnimation(parent: _controller, curve: forwardInterval));

    opacityAnimation = new Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: endingInterval));

    widthAnimation.addListener(() {
      setState(() {
        //Do some stuff
      });
    });

    _controller.forward().whenComplete(() => _controller.repeat(reverse: true));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacityAnimation.value,
      child: Container(
        margin: EdgeInsets.only(left: verticalMotionAnimation.value),
        width: widthAnimation.value,
        height: 1.5,
        decoration: BoxDecoration(
            color: Colors.red,
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.black, Colors.black, Colors.black])),
      ),
    );
  }
}
