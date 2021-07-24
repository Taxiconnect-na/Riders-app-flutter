import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/MainSliderAnimatorProvider.dart';

class MainSliderAnimator {
  bool isSliderClosed =
      true; //! If the slider is closed or not, if so, do not please a reverse animation.
  final TickerProvider animationProvider; //TO allow animations.
  final BuildContext context; //The parent's context
  late AnimationController _controller;
  late final AnimationController _controllerReverse;
  late Animation
      topPositionAnimation; //Margin top position offset of the main slider contentt
  late Animation
      opacityAnimation; //Opacity of the content of the main slider content
  late Animation
      topPositionAnimationBackup; //Main top position offset of the main slider content - scenario 2
  late Animation
      opacityAnimationBackup; //Opacity of the content of the main slider content - scenario 2
  //----Reverse
  late Animation topPositionAnimationReverse;
  late Animation opacityAnimationReverse;

  bool isAnimationPhase1 =
      true; //To know if the animation is in scenario 1 or 2
  final Interval interval1 = Interval(0.0, 0.75,
      curve: Curves.easeInCubic); //The intterval for scenario 1
  final Interval interval2 =
      Interval(0.75, 1.0, curve: Curves.easeIn); //The intterval for scenario 2
  final Interval intervalReverse = Interval(0.0, 1.0, curve: Curves.easeIn);

  MainSliderAnimator({required this.animationProvider, required this.context}) {
    //Initialize values
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1450),
        vsync: this.animationProvider);
    _controllerReverse = AnimationController(
        duration: const Duration(milliseconds: 450),
        vsync: this.animationProvider);

    //? Animate the opacity
    opacityAnimation = new Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: interval1,
    ));
    //? Animate the top position
    topPositionAnimation = new Tween(begin: 0.0, end: 100.0)
        .animate(CurvedAnimation(parent: _controller, curve: interval1));
    //? Animate the opacity - backup ------------------------------
    opacityAnimationBackup = new Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: interval2));
    //? Animate the top position - backup
    topPositionAnimationBackup = new Tween(begin: 100.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: interval2));

    //2. TOP POSITION
    topPositionAnimation.addListener(() {
      if (isAnimationPhase1 == true) {
        context.read<MainSliderAnimatorProvider>().updateTopPositionValues(
            newTopPositionAnimation: opacityAnimation.value);
      }
    });
    topPositionAnimationBackup.addListener(() {
      if (isAnimationPhase1 == false) {
        context.read<MainSliderAnimatorProvider>().updateTopPositionValues(
            newTopPositionAnimation: topPositionAnimationBackup.value);
      }
    });
    //3. OPACITY
    opacityAnimation.addListener(() {
      if (_controller.value > 0.55) {
        isAnimationPhase1 = false;
      } else if (_controller.value == 1.0) {
        isAnimationPhase1 = true;
      }

      if (isAnimationPhase1 == true) {
        context
            .read<MainSliderAnimatorProvider>()
            .updateOpacityValues(newOpacityAnimation: opacityAnimation.value);
      }
    });
    opacityAnimationBackup.addListener(() {
      if (isAnimationPhase1 == false) {
        context.read<MainSliderAnimatorProvider>().updateOpacityValues(
            newOpacityAnimation: opacityAnimationBackup.value);
      }
    });

    //REVERSE
    topPositionAnimationReverse = new Tween(begin: 100.0, end: 0.0).animate(
        CurvedAnimation(parent: _controllerReverse, curve: intervalReverse));
    opacityAnimationReverse = new Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controllerReverse, curve: intervalReverse));

    opacityAnimationReverse.addListener(() {
      context.read<MainSliderAnimatorProvider>().updateOpacityValues(
          newOpacityAnimation: opacityAnimationReverse.value);
    });
    topPositionAnimationReverse.addListener(() {
      context.read<MainSliderAnimatorProvider>().updateTopPositionValues(
          newTopPositionAnimation: topPositionAnimationReverse.value);
    });
  }

  //?1. Start normal animation
  void startNormaAnimation() {
    if (isSliderClosed) {
      //Only update when the slider is closed
      _controller.forward().whenComplete(() {
        //Reset the values
        isAnimationPhase1 = true;
        isSliderClosed = false;
      });
    }
  }

  //?2. Start reverse animation
  void startReverseAnimation() {
    if (isSliderClosed == false) {
      _controller.reverse();
      _controllerReverse.forward(from: 0.0);
      //...
      isSliderClosed = true;
    }
  }

  //!Dispose the animation
  void dispose() {
    _controller.dispose();
  }
}
