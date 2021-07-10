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
                  child: WalletEntryBottomPart(),
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

//Bottom part of the wallet entry
class WalletEntryBottomPart extends StatelessWidget {
  const WalletEntryBottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            horizontalTitleGap: 5,
            contentPadding: EdgeInsets.only(left: 0),
            leading: Container(
                child: Icon(
              Icons.phone_android,
              color: Colors.black,
              size: 35,
            )),
            title: Text('Send cab fares',
                style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 20)),
            subtitle: Text('Easily send to anyone'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            horizontalTitleGap: 5,
            contentPadding: EdgeInsets.only(left: 0),
            leading: Container(
                child: Icon(
              Icons.account_balance_wallet,
              color: Colors.black,
              size: 35,
            )),
            title: Text('Top-up',
                style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 20)),
            subtitle: Text('Safely top-up your wallet'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          LastTransactionSection()
        ],
      ),
    );
  }
}

//Last transaction part
class LastTransactionSection extends StatelessWidget {
  const LastTransactionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'Last transaction',
                  style: TextStyle(fontSize: 19, color: Colors.grey.shade700),
                )),
                Text('Show all',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'MoveTextMedium',
                        color: Color.fromRGBO(14, 132, 145, 1)))
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(3)),
            child: ListTile(
              horizontalTitleGap: 5,
              contentPadding: EdgeInsets.only(left: 5, right: 5),
              leading: Icon(Icons.date_range_rounded),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Paid for ride',
                          style: TextStyle(
                              fontFamily: 'MoveTextMedium', fontSize: 17))),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Cash payment',
                          style: TextStyle(
                              color: Color.fromRGBO(14, 132, 145, 1))))
                ],
              ),
              subtitle: Text('12-05-2021 at 13:00'),
              trailing: Text(
                'N\$30',
                style: TextStyle(
                    fontFamily: 'MoveBold',
                    fontSize: 22,
                    color: Color.fromRGBO(14, 132, 145, 1)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
