import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'countries_codes.dart';

class PhoneNumberInputModal extends StatefulWidget {
  const PhoneNumberInputModal({Key? key}) : super(key: key);

  @override
  _PhoneNumberInputModalState createState() => _PhoneNumberInputModalState();
}

class _PhoneNumberInputModalState extends State<PhoneNumberInputModal> {
  List countryCodes = new CountriesCodesModel().countriesCodes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, size: 28)),
        title: Container(
          child: Text('Select your country',
              style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 21)),
        ),
        centerTitle: false,
        actions: [
          InkWell(
            child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Icon(Icons.search, size: 28))),
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView.separated(
            itemCount: countryCodes.length,
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                  child: Container(
                      child: ListTile(
                leading: Text('${countryCodes[index]['flag']}',
                    style: TextStyle(fontSize: 33)),
                title: Text(
                  '${countryCodes[index]['name']} (${countryCodes[index]['dial_code']})',
                  style: TextStyle(fontSize: 19),
                ),
              )));
            },
          )),
    );
  }
}
