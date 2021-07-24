import 'package:flutter/material.dart';

///? MainSliderAnimatorProvider provider
///Will hold all the essentials to animation the main slider of the app only!

class MainSliderAnimatorProvider with ChangeNotifier {
  double topPositionAnimation =
      0; //The current top margin of the slider's content - default:0
  double opacityAnimation =
      1; //The current opacity of the slider's content - default: 1

  //?2. Update top position values
  void updateTopPositionValues({required double newTopPositionAnimation}) {
    topPositionAnimation = newTopPositionAnimation;
    //...
    notifyListeners();
  }

  //?3. Update new opacity values
  void updateOpacityValues({required double newOpacityAnimation}) {
    opacityAnimation = newOpacityAnimation;
    //...
    notifyListeners();
  }
}
