import 'package:flutter/material.dart';
import 'package:taxiconnect/Modules/GenericCircButton/GenericCircButton.dart';
import 'package:taxiconnect/Modules/PhoneNumberInput/PhoneNumberInputEntry.dart';

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
                    child: Text("What's your phone number?",
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
                        child: PhoneNumberInputEntry(),
                      ))),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    child: ListTile(
                      leading: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Text(
                          'By proceeding, you will receive an SMS and data fees may apply.',
                          style: TextStyle(fontSize: 14),
                        ),
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
