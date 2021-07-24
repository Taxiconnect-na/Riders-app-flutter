import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxiconnect/Components/Login/SplashScreen.dart';
import 'package:taxiconnect/ThemesAndRoutes/AppTheme.dart' as AppTheme;
import 'package:taxiconnect/Components/Home/Home.dart';
import 'package:taxiconnect/Components/Login/CreateAccountEntry.dart';
import 'package:taxiconnect/Components/Login/EntryScreen.dart';
import 'package:taxiconnect/Components/Login/NewAccountAddiDetails.dart';
import 'package:taxiconnect/Components/Login/OTPVerificationEntry.dart';
import 'package:taxiconnect/Components/Login/PhoneDetailsScreen.dart';
import 'package:taxiconnect/Components/Wallet/SendFundsEntry.dart';
import 'package:taxiconnect/Components/Wallet/WalletEntry.dart';
import 'package:taxiconnect/Modules/PhoneNumberInput/PhoneNumberInputModal.dart'; //Debug
import 'package:taxiconnect/Components/Wallet/CheckPhoneNumberTaxiNumberDest.dart';
import 'package:taxiconnect/Components/Wallet/EnterTopUpAmount.dart';
import 'package:taxiconnect/Components/Wallet/PayTaxiInputNumber.dart';
import 'package:taxiconnect/Components/Wallet/SendFundsConfirmation.dart';
import 'package:taxiconnect/Components/Wallet/SendFundsFriendInputNumber.dart';
import 'package:taxiconnect/Components/Wallet/SendFundsInputAmount.dart';
import 'package:taxiconnect/Components/Wallet/TransactionFinalReport.dart';
import 'package:taxiconnect/Components/Wallet/WalletTopupEntry.dart';
import 'package:taxiconnect/Modules/PhoneNumberInput/PhoneNumberInputEntry.dart';

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
        child: ScreenUtilInit(
            builder: () => MaterialApp(
                    theme: AppTheme.appTheme,
                    initialRoute: '/Home',
                    routes: {
                      '/': (context) => SplashScreen(),
                      '/EntryScreen': (context) => EntryScreen(),
                      '/Home': (context) => Home(),
                      '/PhoneDetailsScreen': (context) => PhoneDetailsScreen(),
                      '/OTPVerificationEntry': (context) =>
                          OTPVerificationEntry(),
                      '/CreateAccountEntry': (context) => CreateAccountEntry(),
                      '/NewAccountAddiDetails': (context) =>
                          NewAccountAddiDetails(),
                      '/WalletEntry': (context) => WalletEntry(),
                      '/SendFundsEntry': (context) => SendFundsEntry(),
                      '/SendFundsFriendInputNumber': (context) =>
                          SendFundsFriendInputNumber(),
                      '/CheckPhoneNumberTaxiNumberDest': (context) =>
                          CheckPhoneNumberTaxiNumberDest(),
                      '/SendFundsInputAmount': (context) =>
                          SendFundsInputAmount(),
                      '/SendFundsConfirmation': (context) =>
                          SendFundsConfirmation(),
                      '/TransactionFinalReport': (context) =>
                          TransactionFinalReport(),
                      '/PayTaxiInputNumber': (context) => PayTaxiInputNumber(),
                      '/WalletTopupEntry': (context) => WalletTopupEntry(),
                      '/EnterTopUpAmount': (context) => EnterTopUpAmount()
                    })));
  }
}
