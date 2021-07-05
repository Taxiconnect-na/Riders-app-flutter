import 'package:flutter/material.dart';

class PhoneDetailsScreen extends StatefulWidget {
  const PhoneDetailsScreen({Key? key}) : super(key: key);

  @override
  _PhoneDetailsScreenState createState() => _PhoneDetailsScreenState();
}

class _PhoneDetailsScreenState extends State<PhoneDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('PhoneDetailsScreen'),
    );
  }
}
