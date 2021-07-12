import 'package:flutter/material.dart';

class RideDeliverySelection extends StatelessWidget {
  const RideDeliverySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        top: false,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text("You're the boss",
                      style: TextStyle(
                          fontFamily: 'MoveTextMedium', fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("Choose the desired service",
                      style:
                          TextStyle(fontFamily: 'MoveTextLight', fontSize: 14)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      //decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Row(
                        children: [
                          BasicProductionSelection(
                              iconString: 'Assets/Images/normaltaxieconomy.jpg',
                              productName: 'Ride',
                              shortDescription:
                                  'The easiest way to move around the city.'),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.27,
                            width: 1.5,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.white,
                                  Colors.black,
                                  Colors.white
                                ])),
                          ),
                          BasicProductionSelection(
                              iconString: 'Assets/Images/box_delivery.png',
                              iconSize: 31,
                              productName: 'Delivery',
                              shortDescription:
                                  'Send your packages from one place to another.'),
                        ],
                      ),
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

//Basic production selection
class BasicProductionSelection extends StatelessWidget {
  final String iconString; //The image of the product
  final double iconSize; //The size of the product image
  final String productName; //The name of the product
  final String
      shortDescription; //A short bu concise description of the product.

  const BasicProductionSelection(
      {Key? key,
      required this.iconString,
      this.iconSize = 40,
      required this.productName,
      required this.shortDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
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
                    style:
                        TextStyle(fontFamily: 'MoveTextRegular', fontSize: 15)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    //decoration: BoxDecoration(border: Border.all(width: 1)),
                    alignment: Alignment.bottomRight,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.white,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
