import 'package:flutter/material.dart';
import 'package:taxiconnect/Modules/GenericCircButton/GenericCircButton.dart';
import 'package:taxiconnect/Modules/PhoneNumberInput/PhoneNumberInputEntry.dart';

class PackageReceiverDeliveryInput extends StatefulWidget {
  const PackageReceiverDeliveryInput({
    Key? key,
  }) : super(key: key);

  @override
  _PackageReceiverDeliveryInputState createState() =>
      _PackageReceiverDeliveryInputState();
}

class _PackageReceiverDeliveryInputState
    extends State<PackageReceiverDeliveryInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              ListTile(
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:
                        Icon(Icons.arrow_back, size: 33, color: Colors.black)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text("Who is receiving the package?",
                        style: TextStyle(
                            fontFamily: 'MoveBold',
                            fontSize: 24,
                            color: Colors.black))),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                    autocorrect: false,
                    style:
                        TextStyle(fontFamily: 'MoveTextRegular', fontSize: 22),
                    decoration: InputDecoration(
                        // prefixIcon: Icon(
                        //   Icons.person,
                        //   size: 40,
                        // ),
                        focusColor: Colors.amber,
                        labelText: "Name",
                        floatingLabelBehavior: FloatingLabelBehavior.auto)),
              ),
              SizedBox(
                height: 18,
              ),
              Expanded(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: PhoneNumberInputEntry(),
                      ))),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    height: 100,
                    child: ListTile(
                      leading: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'MoveTextRegular',
                                  fontSize: 15,
                                  color: Colors.black),
                              children: [
                                TextSpan(text: 'The '),
                                TextSpan(
                                    text: 'receiver can track ',
                                    style: TextStyle(
                                        color: Color.fromRGBO(14, 132, 145, 1),
                                        fontFamily: 'MoveTextMedium')),
                                TextSpan(text: ' the delivery of the package '),
                                TextSpan(
                                    text: 'in real-time.',
                                    style: TextStyle(
                                        color: Color.fromRGBO(14, 132, 145, 1),
                                        fontFamily: 'MoveTextMedium'))
                              ]),
                        ),
                      ),
                      trailing: GenericCircButton(
                        originRouteName: 'PackageReceiverDeliveryInput',
                        destinationRouteName: 'OTPVerificationEntry',
                        destinationRouteNature: 'obvious',
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
