import 'package:flutter/material.dart';

///Search destination/pickup location

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: SafeArea(
          child: Column(
        children: [GoBackPart(), HeaderPart()],
      )),
    );
  }
}

//Go back part
class GoBackPart extends StatelessWidget {
  const GoBackPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, size: 27, color: Colors.black),
        ),
      ),
    );
  }
}

//Header part
class HeaderPart extends StatefulWidget {
  const HeaderPart({Key? key}) : super(key: key);

  @override
  _HeaderPartState createState() => _HeaderPartState();
}

class _HeaderPartState extends State<HeaderPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Container(
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blue)),
              child: Placeholder(
                fallbackWidth: 20,
                fallbackHeight: 20,
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.red)),
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: TextField(
                              maxLength: 35,
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                  counterText: "",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: 'Where are you?',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 15))),
                        ),
                      ),
                      DestinationInputsFields()
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

//Destination input fields
class DestinationInputsFields extends StatelessWidget {
  const DestinationInputsFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Text('Destination inputs'),
      ),
    );
  }
}
