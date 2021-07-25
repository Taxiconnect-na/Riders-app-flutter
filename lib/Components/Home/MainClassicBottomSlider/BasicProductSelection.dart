import 'package:flutter/material.dart';

//Basic production selection
class BasicProductSelection extends StatelessWidget {
  final String iconString; //The image of the product
  final double iconSize; //The size of the product image
  final String productName; //The name of the product
  final String
      shortDescription; //A short bu concise description of the product.
  final Color shortDescriptionColor; //The color for the short description
  final Color
      arrowMoveForwardColor; //The color of the arrow for the move forward.
  final Color
      arrowMoveForwardBackgroundColor; //The background color for the arrow for the mov forward.
  final actuatorFunctionl; //!The function that will be called after the product is selected

  const BasicProductSelection(
      {Key? key,
      required this.iconString,
      required this.actuatorFunctionl,
      this.iconSize = 40,
      required this.productName,
      required this.shortDescription,
      this.shortDescriptionColor = Colors.black,
      this.arrowMoveForwardColor = Colors.white,
      this.arrowMoveForwardBackgroundColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: this.actuatorFunctionl,
          child: Container(
            alignment: Alignment.center,
            //decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Column(
              children: [
                CircleAvatar(
                  child: CircleAvatar(
                    child: Image.asset(
                      this.iconString,
                      fit: BoxFit.contain,
                    ),
                    backgroundColor: Colors.white,
                    radius: this.iconSize,
                  ),
                  backgroundColor: Colors.white,
                  radius: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(this.productName,
                      style: TextStyle(fontFamily: 'MoveBold', fontSize: 22)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(this.shortDescription,
                      style: TextStyle(
                          fontFamily: 'MoveTextRegular',
                          fontSize: 15,
                          color: this.shortDescriptionColor)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      //decoration: BoxDecoration(border: Border.all(width: 1)),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: this.arrowMoveForwardBackgroundColor,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: this.arrowMoveForwardColor,
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
