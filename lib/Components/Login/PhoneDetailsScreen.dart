import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Modules/GenericCircButton/GenericCircButton.dart';

class PhoneDetailsScreen extends StatefulWidget {
  const PhoneDetailsScreen({Key? key}) : super(key: key);

  @override
  _PhoneDetailsScreenState createState() => _PhoneDetailsScreenState();
}

class _PhoneDetailsScreenState extends State<PhoneDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.arrow_back, size: 33, color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text("What's your phone number?",
                        style: TextStyle(
                            fontFamily: 'MoveTextMedium',
                            fontSize: 21,
                            color: Colors.black))),
              ),
              Expanded(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Text('phone'),
                      ))),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    child: ListTile(
                      leading: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Text(
                            'By proceeding, you will receive an SMS and data fees may apply.'),
                      ),
                      trailing: GenericCircButton(
                        key: Key('PhoneDetailsScreen'),
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
