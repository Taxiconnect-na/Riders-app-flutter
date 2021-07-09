import 'package:flutter/material.dart';
import 'PhoneDetailsScreen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PhoneDetailsScreen()));
      },
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(14, 132, 145, 1)),
                child: SafeArea(
                    child: Column(
                  children: [
                    Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.asset(
                            'Assets/Images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        )),
                    Expanded(
                        child: Container(
                      //decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Image.asset('Assets/Images/entryImage0.png',
                          fit: BoxFit.contain),
                    )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Get yourself a safe ride',
                              style: TextStyle(
                                  fontSize: 33,
                                  color: Colors.white,
                                  fontFamily: 'MoveBold'))),
                    ),
                  ],
                )),
              )),
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                  child: Container(
                child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      size: 25,
                      color: Colors.black,
                    ),
                    title: Text("What's your phone number?",
                        style: TextStyle(
                            fontFamily: 'MoveTextRegular',
                            fontSize: 20,
                            color: Colors.black)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 20, color: Colors.black)),
              )),
            ),
          )
        ],
      )),
    ));
  }
}
