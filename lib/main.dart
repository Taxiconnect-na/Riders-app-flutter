import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:taxiconnect/Components/Providers/MainSliderAnimatorProvider.dart';
import 'package:taxiconnect/Components/Providers/SearchProvider.dart';
import 'package:taxiconnect/Components/Providers/SmartBookingStepsProvider.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';
import 'Components/Providers/SettingsProvider.dart';
import 'ThemesAndRoutes/AppRoutes.dart'; //Debug

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => HomeProvider()), //For home interface
      ChangeNotifierProvider(
          create: (_) => TripProvider()), //For trips management
      ChangeNotifierProvider(
          create: (_) => SearchProvider()), //For search management
      ChangeNotifierProvider(
          create: (_) => SettingsProvider()), //For settings management
      ChangeNotifierProvider(
          create: (_) =>
              SmartBookingStepsProvider()), //For the smart booking route management
      ChangeNotifierProvider(
          create: (_) =>
              MainSliderAnimatorProvider()) //For the management fo the main slider animator
    ],
    child: AppGeneralEntry(),
  ));
}
