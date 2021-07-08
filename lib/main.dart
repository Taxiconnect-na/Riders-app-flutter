import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Login/CreateAccountEntry.dart';
import 'package:taxiconnect/Components/Login/EntryScreen.dart';
import 'package:taxiconnect/Components/Login/OTPVerificationEntry.dart';
import 'package:taxiconnect/Components/Login/PhoneDetailsScreen.dart';
import 'package:taxiconnect/Modules/PhoneNumberInput/PhoneNumberInputModal.dart'; //Debug
import 'Modules/PhoneNumberInput/PhoneNumberInputEntry.dart'; //Debug

final ThemeData _appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(textTheme: _appTextTheme(base.textTheme));
}

TextTheme _appTextTheme(TextTheme base) {
  return base.apply(fontFamily: 'MoveTextRegular', bodyColor: Colors.black);
}

void main() {
  runApp(AppGeneralEntry());
}

class AppGeneralEntry extends StatefulWidget {
  const AppGeneralEntry({Key? key}) : super(key: key);

  @override
  _AppGeneralEntryState createState() => _AppGeneralEntryState();
}

class _AppGeneralEntryState extends State<AppGeneralEntry> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _appTheme,
        initialRoute: '/CreateAccountEntry',
        routes: {
          '/': (context) => EntryScreen(),
          '/PhoneDetailsScreen': (context) => PhoneDetailsScreen(),
          '/OTPVerificationEntry': (context) => OTPVerificationEntry(),
          '/CreateAccountEntry': (context) => CreateAccountEntry()
        });
  }
}
