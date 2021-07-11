import 'package:flutter/material.dart';

class WalletTopupEntry extends StatelessWidget {
  const WalletTopupEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text('Payment settings',
              style: TextStyle(fontFamily: 'MoveTextRegular', fontSize: 22)),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 15, bottom: 5),
                child: ListTile(
                  leading: Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 55,
                      child: Icon(Icons.account_balance_wallet,
                          size: 25, color: Colors.black)),
                  horizontalTitleGap: 5,
                  contentPadding: EdgeInsets.only(left: 0),
                  title: Text(
                    'Your wallet',
                    style: TextStyle(fontFamily: 'MoveBold', fontSize: 22),
                  ),
                  trailing: Container(
                      alignment: Alignment.centerRight,
                      height: 55,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        'N\$950',
                        style: TextStyle(
                            fontFamily: 'MoveBold',
                            fontSize: 22,
                            color: Color.fromRGBO(9, 110, 212, 1)),
                      )),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              TopupMethodsPart()
            ],
          ),
        ));
  }
}

//Sending fares options part
class TopupMethodsPart extends StatelessWidget {
  const TopupMethodsPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text('Top up with',
                      style: TextStyle(
                          fontFamily: 'MoveTextMedium',
                          fontSize: 19,
                          color: Colors.grey))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
              child: ListTile(
                leading: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 55,
                    child: Icon(Icons.credit_card,
                        size: 30, color: Color.fromRGBO(9, 110, 212, 1))),
                horizontalTitleGap: 5,
                contentPadding: EdgeInsets.only(left: 0),
                title: Text(
                  'Credit card',
                  style: TextStyle(
                    fontFamily: 'MoveTextMedium',
                    fontSize: 22,
                  ),
                ),
                trailing: Container(
                    width: 40,
                    height: 55,
                    child: Icon(Icons.arrow_forward_ios,
                        size: 17, color: Colors.black)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text('Preferred method',
                      style: TextStyle(
                          fontFamily: 'MoveTextMedium',
                          fontSize: 19,
                          color: Colors.grey))),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 15, top: 15, left: 20, right: 20),
              child: ListTile(
                leading: Container(
                    alignment: Alignment.topCenter,
                    width: 40,
                    height: 40,
                    child: Icon(Icons.mobile_friendly_outlined,
                        size: 35, color: Colors.black)),
                horizontalTitleGap: 5,
                contentPadding: EdgeInsets.only(left: 0),
                title: Text(
                  'Wallet',
                  style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 20),
                ),
                subtitle: Text('Cashless, recommended.'),
                trailing: Container(
                    width: 40,
                    height: 55,
                    child: Icon(Icons.check_circle,
                        size: 30, color: Color.fromRGBO(9, 110, 212, 1))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 15, top: 0, left: 20, right: 20),
              child: ListTile(
                leading: Container(
                    alignment: Alignment.topCenter,
                    width: 40,
                    height: 40,
                    child: Icon(Icons.attach_money_outlined,
                        size: 35, color: Colors.green)),
                horizontalTitleGap: 5,
                contentPadding: EdgeInsets.only(left: 0),
                title: Text(
                  'Cash',
                  style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 20),
                ),
                trailing: Visibility(
                  visible: false,
                  child: Container(
                      width: 40,
                      height: 55,
                      child: Icon(Icons.check_circle,
                          size: 30, color: Color.fromRGBO(9, 110, 212, 1))),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
