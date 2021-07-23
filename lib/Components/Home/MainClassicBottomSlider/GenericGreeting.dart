import 'package:flutter/material.dart';

class GenericGreeting extends StatelessWidget {
  const GenericGreeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Text('Hi Jessica',
          style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 25)),
    );
  }
}
