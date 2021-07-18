import 'package:flutter/material.dart';

import 'BasicProductSelection.dart';

class ConnectMeUsSelection extends StatelessWidget {
  const ConnectMeUsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        top: false,
        child: Container(
          // decoration:
          //     BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text("Private or shared?",
                      style: TextStyle(
                          fontFamily: 'MoveTextMedium', fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("We can handle your convenience",
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
                          BasicProductSelection(
                            actuatorFunctionl: () => {},
                            iconString: 'Assets/Images/meeting.png',
                            iconSize: 25,
                            productName: 'ConnectUs',
                            shortDescription: 'Shared booking',
                            shortDescriptionColor:
                                Color.fromRGBO(9, 110, 212, 1),
                          ),
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
                          BasicProductSelection(
                            actuatorFunctionl: () => {},
                            iconString: 'Assets/Images/user.png',
                            iconSize: 25,
                            productName: 'ConnectMe',
                            shortDescription: 'Private booking',
                            shortDescriptionColor:
                                Color.fromRGBO(9, 110, 212, 1),
                          ),
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
