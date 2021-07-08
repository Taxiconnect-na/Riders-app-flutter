import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Login/EntryScreen.dart';
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
  runApp(new MaterialApp(theme: _appTheme, home: PhoneDetailsScreen()));
}
