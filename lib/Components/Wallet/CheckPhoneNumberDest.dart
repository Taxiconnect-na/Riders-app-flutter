import 'package:flutter/material.dart';
import 'package:taxiconnect/Modules/GenericRectButton/GenericRectButton.dart';

class CheckPhoneNumberDest extends StatefulWidget {
  const CheckPhoneNumberDest({Key? key}) : super(key: key);

  @override
  _CheckPhoneNumberDestState createState() => _CheckPhoneNumberDestState();
}

class _CheckPhoneNumberDestState extends State<CheckPhoneNumberDest> {
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
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text("Good to go!",
                        style: TextStyle(
                            fontFamily: 'MoveBold',
                            fontSize: 28,
                            color: Colors.black))),
              ),
              SizedBox(
                height: 10,
              ),
              AvatarAndServerDetails(),
              GenericRectButton()
            ],
          ),
        ),
      ),
    );
  }
}

//Avatar and server answer
class AvatarAndServerDetails extends StatelessWidget {
  const AvatarAndServerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 3, color: Color.fromRGBO(14, 132, 145, 1)),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10)
                    ]),
                child: CircleAvatar(
                  backgroundImage: AssetImage('Assets/Images/girl.jpg'),
                  radius: 45,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  child: Text('Jessica',
                      style: TextStyle(
                          fontFamily: 'MoveTextMedium', fontSize: 22)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  child: Text(
                    'You are allowed to make the transaction.',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(14, 132, 145, 1)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
