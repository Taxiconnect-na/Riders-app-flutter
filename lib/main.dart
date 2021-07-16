import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:taxiconnect/Components/Providers/SearchProvider.dart';
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
          create: (_) => SettingsProvider()) //For settings management
    ],
    child: AppGeneralEntry(),
  ));
}
