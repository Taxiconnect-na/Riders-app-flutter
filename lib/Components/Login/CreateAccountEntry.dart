import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CreateAccountEntry extends StatefulWidget {
  const CreateAccountEntry({Key? key}) : super(key: key);

  @override
  _CreateAccountEntryState createState() => _CreateAccountEntryState();
}

class _CreateAccountEntryState extends State<CreateAccountEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: 'MoveBold',
                          fontSize: 38,
                          color: Colors.black,
                        ),
                        child: AnimatedTextKit(animatedTexts: [
                          WavyAnimatedText('Hi',
                              speed: Duration(milliseconds: 250)),
                          WavyAnimatedText('Ongeipi',
                              speed: Duration(milliseconds: 250))
                        ], repeatForever: true, pause: Duration(seconds: 5)))),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Image.asset('Assets/Images/newRiderWelcome.jpg'),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  child: Text(
                    'Would you like to create a new account?',
                    style: TextStyle(fontFamily: 'MoveBold', fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'MoveTextLight',
                                fontSize: 15),
                            children: [
                      TextSpan(text: 'By clicking '),
                      TextSpan(
                          text: 'Create your account',
                          style: TextStyle(fontFamily: 'MoveTextBold')),
                      TextSpan(text: ', you automatically accept our '),
                      TextSpan(
                          text: 'terms and conditions.',
                          style: TextStyle(
                              fontFamily: 'MoveTextMedium',
                              color: Color.fromRGBO(14, 132, 145, 1)))
                    ]))),
              ),
              CreateNewAccountButton()
            ],
          ),
        ),
      ),
    );
  }
}

//Button to create the account
class CreateNewAccountButton extends StatelessWidget {
  const CreateNewAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          height: 65,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            onPressed: () =>
                Navigator.pushNamed(context, '/NewAccountAddiDetails'),
            child: Padding(
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Text(
                  'Create your account',
                  style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 25),
                )),
          ),
        ));
  }
}
