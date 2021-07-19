import 'package:flutter/material.dart';

class GenericCircButton extends StatelessWidget {
  final actuatorFunctionl; //! The function that will be fired when the button is clicked.
  const GenericCircButton({Key? key, required this.actuatorFunctionl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: this.actuatorFunctionl,
          child: Container(
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
          )),
    );
  }
}
