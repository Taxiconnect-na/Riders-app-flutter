import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxiconnect/Modules/PhoneNumberInput/PhoneNumberInputModal.dart';
import 'countries_codes.dart';

class PhoneNumberInputEntry extends StatefulWidget {
  const PhoneNumberInputEntry({Key? key}) : super(key: key);

  @override
  _PhoneNumberInputEntryState createState() => _PhoneNumberInputEntryState();
}

class _PhoneNumberInputEntryState extends State<PhoneNumberInputEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          //decoration: BoxDecoration(border: Border.all(width: 1)),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              FlagPartPhoneEntry(),
              SizedBox(
                width: 5,
              ),
              TextEntryPhoneInput()
            ],
          ),
        )));
  }
}

//First part of the flag entry
class FlagPartPhoneEntry extends StatelessWidget {
  const FlagPartPhoneEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => showMaterialModalBottomSheet(
            duration: Duration(milliseconds: 350),
            context: context,
            builder: (context) {
              return Container(
                  color: Colors.black,
                  child: SafeArea(
                      bottom: false,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: PhoneNumberInputModal(),
                      )));
            }),
        child: Container(
            decoration: BoxDecoration(
                //color: Colors.grey.shade100,
                border: Border.all(width: 0.5, color: Colors.white),
                borderRadius: BorderRadius.circular(3)),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Text('${new CountriesCodesModel().countriesCodes[0]['flag']}',
                      style: TextStyle(fontSize: 33)),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20,
                  ),
                  Text('+264',
                      style: TextStyle(
                          fontSize: 22, fontFamily: 'UberMoveTextMedium'))
                ],
              ),
            )));
  }
}

//Second part text entry phone input
class TextEntryPhoneInput extends StatelessWidget {
  const TextEntryPhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: Container(
                height: MediaQuery.of(context).size.height,
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
                child: TextField(
                  //autofocus: true,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  showCursor: true,
                  style: TextStyle(fontSize: 22, letterSpacing: 0),
                  maxLength: 10, //! Should be conditional to the country
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      labelText: "856997167",
                      labelStyle: TextStyle(fontFamily: 'UberMoveTextMedium'),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.only(bottom: 15.5)),
                ))));
  }
}
