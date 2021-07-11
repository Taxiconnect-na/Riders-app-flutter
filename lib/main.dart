import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Login/CreateAccountEntry.dart';
import 'package:taxiconnect/Components/Login/EntryScreen.dart';
import 'package:taxiconnect/Components/Login/NewAccountAddiDetails.dart';
import 'package:taxiconnect/Components/Login/OTPVerificationEntry.dart';
import 'package:taxiconnect/Components/Login/PhoneDetailsScreen.dart';
import 'package:taxiconnect/Components/Wallet/SendFundsEntry.dart';
import 'package:taxiconnect/Components/Wallet/WalletEntry.dart';
import 'package:taxiconnect/Modules/PhoneNumberInput/PhoneNumberInputModal.dart'; //Debug
import 'Components/Wallet/CheckPhoneNumberTaxiNumberDest.dart';
import 'Components/Wallet/EnterTopUpAmount.dart';
import 'Components/Wallet/PayTaxiInputNumber.dart';
import 'Components/Wallet/SendFundsConfirmation.dart';
import 'Components/Wallet/SendFundsFriendInputNumber.dart';
import 'Components/Wallet/SendFundsInputAmount.dart';
import 'Components/Wallet/TransactionFinalReport.dart';
import 'Components/Wallet/WalletTopupEntry.dart';
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
    return GestureDetector(
        onTap: () {
          //Hide Keyboard on arbitrary press throughout the app
          FocusScopeNode currentFocus = FocusScope.of(context);
          print(currentFocus.hasPrimaryFocus);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
            theme: _appTheme,
            initialRoute: '/EnterTopUpAmount',
            routes: {
              '/': (context) => EntryScreen(),
              '/PhoneDetailsScreen': (context) => PhoneDetailsScreen(),
              '/OTPVerificationEntry': (context) => OTPVerificationEntry(),
              '/CreateAccountEntry': (context) => CreateAccountEntry(),
              '/NewAccountAddiDetails': (context) => NewAccountAddiDetails(),
              '/WalletEntry': (context) => WalletEntry(),
              '/SendFundsEntry': (context) => SendFundsEntry(),
              '/SendFundsFriendInputNumber': (context) =>
                  SendFundsFriendInputNumber(),
              '/CheckPhoneNumberTaxiNumberDest': (context) =>
                  CheckPhoneNumberTaxiNumberDest(),
              '/SendFundsInputAmount': (context) => SendFundsInputAmount(),
              '/SendFundsConfirmation': (context) => SendFundsConfirmation(),
              '/TransactionFinalReport': (context) => TransactionFinalReport(),
              '/PayTaxiInputNumber': (context) => PayTaxiInputNumber(),
              '/WalletTopupEntry': (context) => WalletTopupEntry(),
              '/EnterTopUpAmount': (context) => EnterTopUpAmount()
            }));
  }
}
