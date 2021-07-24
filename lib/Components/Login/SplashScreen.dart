import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taxiconnect/Components/Home/Home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double sideLength = 90; //The side of the squre for the logo
  double superSideLength =
      90; //The side of the container above the logo for the scale out

  late final Animation<double> logoScaleAnimation;
  late final Animation<double> superScaleAnimation;
  late final Animation globalOpacityAnimation;

  final Interval forwardInterval =
      Interval(0.0, 1.0, curve: Curves.easeInOutExpo);
  final Interval superInterval =
      Interval(0.4, 1.0, curve: Curves.easeInOutCubic);
  final Interval opacityInterval = Interval(0.6, 1.0, curve: Curves.ease);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);

    logoScaleAnimation = new Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: forwardInterval));

    superScaleAnimation = new Tween(begin: 1.0, end: 50.0)
        .animate(CurvedAnimation(parent: _controller, curve: superInterval));

    globalOpacityAnimation = new Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: opacityInterval));

    globalOpacityAnimation.addListener(() {
      setState(() {
        //Do some stuff
      });
    });

    //Debug start
    Future.delayed(Duration(seconds: 2), () {
      _controller.forward().whenComplete(() => Navigator.push(context,
          PageTransition(child: Home(), type: PageTransitionType.fade)));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Opacity(
        opacity: globalOpacityAnimation.value,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color.fromRGBO(9, 132, 145, 1),
              border: Border.all(width: 1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  ScaleTransition(
                    scale: superScaleAnimation,
                    child: Container(
                      alignment: Alignment.center,
                      width: superSideLength,
                      height: superSideLength,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                  ),
                  Container(
                    child: ScaleTransition(
                      scale: logoScaleAnimation,
                      child: Container(
                          alignment: Alignment.center,
                          width: sideLength,
                          height: sideLength,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              'Assets/Images/logo.png',
                              fit: BoxFit.contain,
                            ),
                          )),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
