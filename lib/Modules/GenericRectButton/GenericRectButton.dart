import 'package:flutter/material.dart';

///Generic rectangular button
///Can receive any on press action void function
class GenericRectButton extends StatelessWidget {
  final String label;
  final bool isArrowShow;

  GenericRectButton({required this.label, this.isArrowShow = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          height: 65,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            onPressed: () =>
                Navigator.pushNamed(context, '/NewAccountAddiDetails'),
            child: Padding(
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          this.label,
                          style: TextStyle(
                              fontFamily: 'MoveTextMedium', fontSize: 28),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: this.isArrowShow,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 25,
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
