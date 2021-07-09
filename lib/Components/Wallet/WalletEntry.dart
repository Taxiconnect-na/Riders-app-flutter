import 'package:flutter/material.dart';

class WalletEntry extends StatelessWidget {
  const WalletEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          'Wallet',
          style: TextStyle(
              color: Colors.black, fontFamily: 'MoveBold', fontSize: 23),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          HeaderPartWalletEntry(),
          Expanded(
            child: SafeArea(
              bottom: false,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 6)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Text('Bottom part'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Header part of the wallet entry
class HeaderPartWalletEntry extends StatelessWidget {
  const HeaderPartWalletEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 8)
                        ]),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('Assets/Images/girl.jpg'),
                      radius: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Text('N\$125',
                          style: TextStyle(
                              fontFamily: 'MoveBold',
                              fontSize: 48,
                              color: Color.fromRGBO(14, 132, 145, 1)))),
                  Container(
                      child: Text('Your balance',
                          style: TextStyle(fontSize: 17, color: Colors.grey))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
