import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taxiconnect/Modules/GenericCircButton/GenericCircButton.dart';
import 'package:taxiconnect/Modules/OTPVerificationInput/OTPVerificationInput.dart';

class PayTaxiInputNumber extends StatefulWidget {
  const PayTaxiInputNumber({Key? key}) : super(key: key);

  @override
  _PayTaxiInputNumberState createState() => _PayTaxiInputNumberState();
}

class _PayTaxiInputNumberState extends State<PayTaxiInputNumber> {
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
                    child: Text("What's the taxi number?",
                        style: TextStyle(
                            fontFamily: 'MoveBold',
                            fontSize: 28,
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
                        child: TaxiNumberInputPart(),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              children: [
                                TextSpan(
                                    text:
                                        "Note that you can also use the driver's "),
                                TextSpan(
                                    text: 'payment number ',
                                    style: TextStyle(
                                        fontFamily: 'MoveTextMedium',
                                        color:
                                            Color.fromRGBO(14, 132, 145, 1))),
                                TextSpan(text: 'instead.')
                              ]),
                        ),
                      ),
                      trailing: GenericCircButton(
                        originRouteName: 'PayTaxiInputNumber',
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

//Taxi number input part
class TaxiNumberInputPart extends StatelessWidget {
  const TaxiNumberInputPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: PinCodeTextField(
        enablePinAutofill: true,
        showCursor: false,
        autoFocus: true,
        autovalidateMode: AutovalidateMode.disabled,
        autoDismissKeyboard: true,
        appContext: context,
        length: 6,
        obscureText: false,
        blinkDuration: Duration(milliseconds: 250),
        textStyle: TextStyle(
            fontSize: 25,
            fontFamily: 'MoveTextMedium',
            fontWeight: FontWeight.normal),
        animationType: AnimationType.none,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            borderRadius: BorderRadius.circular(5),
            borderWidth: 3,
            fieldHeight: 60,
            activeColor: Colors.grey.shade700,
            inactiveColor: Colors.grey.shade400,
            selectedColor: Color.fromRGBO(14, 132, 145, 1),
            fieldWidth: MediaQuery.of(context).size.width / 8,
            activeFillColor: Colors.white),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return false;
        },
      ),
    );
  }
}
