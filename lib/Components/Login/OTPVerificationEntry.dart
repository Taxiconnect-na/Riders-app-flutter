import 'package:flutter/material.dart';
import 'package:taxiconnect/Modules/GenericCircButton/GenericCircButton.dart';
import 'package:taxiconnect/Modules/OTPVerificationInput/OTPVerificationInput.dart';

class OTPVerificationEntry extends StatefulWidget {
  const OTPVerificationEntry({Key? key}) : super(key: key);

  @override
  _OTPVerificationEntryState createState() => _OTPVerificationEntryState();
}

class _OTPVerificationEntryState extends State<OTPVerificationEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
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
                    child: Text("Enter the 5-digits code sent you.",
                        style: TextStyle(
                            fontFamily: 'MoveTextMedium',
                            fontSize: 24,
                            color: Colors.black))),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: OTPVerificationInput(),
                      ))),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    child: ListTile(
                      trailing: GenericCircButton(
                        originRouteName: 'OTPVerificationEntry',
                        destinationRouteName: 'CreateAccountEntry',
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
