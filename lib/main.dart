import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'ThemesAndRoutes/AppRoutes.dart'; //Debug

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => HomeProvider())],
    child: AppGeneralEntry(),
  ));
}
