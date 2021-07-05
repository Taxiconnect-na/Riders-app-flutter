import 'package:flutter/material.dart';

class GenericCircButton extends StatefulWidget {
  const GenericCircButton({Key? key}) : super(key: key);

  @override
  _GenericCircButtonState createState() => _GenericCircButtonState();
}

class _GenericCircButtonState extends State<GenericCircButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 5,
        )
      ], shape: BoxShape.circle, color: Color.fromRGBO(14, 132, 145, 1)),
      child: Icon(
        Icons.arrow_forward,
        size: 33,
        color: Colors.white,
      ),
    );
  }
}
