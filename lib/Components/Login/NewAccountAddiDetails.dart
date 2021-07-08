import 'package:flutter/material.dart';

class NewAccountAddiDetails extends StatefulWidget {
  const NewAccountAddiDetails({Key? key}) : super(key: key);

  @override
  _NewAccountAddiDetailsState createState() => _NewAccountAddiDetailsState();
}

class _NewAccountAddiDetailsState extends State<NewAccountAddiDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              ListTile(
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:
                        Icon(Icons.arrow_back, size: 33, color: Colors.black)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome to TaxiConnect",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'MoveBold',
                                  fontSize: 24,
                                  color: Colors.black)),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '🇳🇦',
                            style: TextStyle(fontSize: 27),
                          )
                        ])),
              ),
              SizedBox(
                height: 10,
              ),
              InputUserDetails()
            ],
          ),
        ),
      ),
    );
  }
}

//Input user details: name, gender and email.
class InputUserDetails extends StatelessWidget {
  const InputUserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          child: Column(
            children: [
              TextField(
                  autocorrect: false,
                  style: TextStyle(fontFamily: 'MoveTextRegular', fontSize: 22),
                  decoration: InputDecoration(
                      // prefixIcon: Icon(
                      //   Icons.person,
                      //   size: 40,
                      // ),
                      focusColor: Colors.amber,
                      labelText: "What's your name?",
                      floatingLabelBehavior: FloatingLabelBehavior.auto)),
              SizedBox(
                height: 18,
              ),
              TextField(
                  autocorrect: false,
                  style: TextStyle(fontFamily: 'MoveTextRegular', fontSize: 22),
                  decoration: InputDecoration(
                      // prefixIcon: Icon(
                      //   Icons.gesture
                      //   size: 40,
                      // ),
                      focusColor: Colors.amber,
                      labelText: 'Gender',
                      floatingLabelBehavior: FloatingLabelBehavior.auto)),
              SizedBox(
                height: 18,
              ),
              TextField(
                  autocorrect: false,
                  style: TextStyle(fontFamily: 'MoveTextRegular', fontSize: 22),
                  decoration: InputDecoration(
                      // prefixIcon: Icon(
                      //   Icons.email_outlined,
                      //   size: 40,
                      // ),
                      focusColor: Colors.amber,
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.auto))
            ],
          ),
        ));
  }
}
