import 'package:flutter/material.dart';

///? SETTINGS PROVIDER
///Will hold all the provider settings relevant to the settings only

class SettingsProvider with ChangeNotifier {
  List customLocations = [
    {
      'location_type': 'Home',
      'icon': Icons.home,
      'location_data': {
        'city': 'Windhoek',
        'location_name': 'Trift Place',
        'country': 'Namibia',
        'street': 'Trift street'
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
}
