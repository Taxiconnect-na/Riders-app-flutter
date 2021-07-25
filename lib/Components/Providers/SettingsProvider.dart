import 'package:flutter/material.dart';

///? SETTINGS PROVIDER
///Will hold all the provider settings relevant to the settings only

class SettingsProvider with ChangeNotifier {
  List customLocations = [
    {
      'location_type': 'Home',
      'icon': Icons.home,
      'location_data': {
        "location_id": 598475513,
        "location_name": "Khomasdal",
        "coordinates": [17.0470405, -22.5493927],
        "averageGeo": -5.502352199999997,
        "city": "Windhoek",
        "street": false,
        "state": "Khomas Region",
        "country": "Namibia",
        "query": "Khomas",
        "_id": "60fc777fa361439ed83ebc5d"
      } //!DEBUG location
    }, //Contains standard location data: street, city, country, location_name
    {'location_type': 'Work', 'icon': Icons.work, 'location_data': null},
    {
      'location_type': 'Gym',
      'icon': Icons.accessibility,
      'location_data': null
    },
    {'location_type': 'Add more', 'icon': Icons.add, 'location_data': null},
  ]; //Hold all the details of the custom location preselected by the user.
  String defaultPaymentMethod =
      'cash'; //Hold the default payment method selected

  //?1. Get default payment method icon asset
  IconData getDefaultPaymentMethodIcon() {
    switch (defaultPaymentMethod) {
      case 'cash':
        return Icons.payments;
      case 'wallet':
        return Icons.account_balance_wallet;
      default:
        return Icons.payments;
    }
  }

  //?2. Uppercase only the first char
  String ucFirst({required String text}) {
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }
}
