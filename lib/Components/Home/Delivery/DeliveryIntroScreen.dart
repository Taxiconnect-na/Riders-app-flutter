import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';
import 'package:taxiconnect/Modules/GenericCircButton/GenericCircButton.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Modules/GenericRectButton/GenericRectButton.dart';
import 'package:taxiconnect/Modules/Search/Search.dart';

class DeliveryIntroScreen extends StatefulWidget {
  const DeliveryIntroScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DeliveryIntroScreenState createState() => _DeliveryIntroScreenState();
}

class _DeliveryIntroScreenState extends State<DeliveryIntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //?Auto select the small package
    Provider.of<TripProvider>(context, listen: false).updateSelectedPackageSize(
        packageSizeSelected: Provider.of<TripProvider>(context, listen: false)
            .packagesSizesGeneralData[0],
        shouldUpdate: false);
  }

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
                trailing: InkWell(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            color: Colors.white,
                            child: SafeArea(
                                child: Container(
                              height: 485,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: ShowGuidelinesInfoModal(),
                            )));
                      }),
                  child: Container(
                    width: 110,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border:
                            Border.all(width: 1, color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child:
                                Icon(Icons.info, size: 15, color: Colors.black),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text('Guidelines',
                              style: TextStyle(
                                  fontFamily: 'MoveTextMedium', fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: ShowContentIntro()),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    //decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: GenericRectButton(
                      label: 'Send a package',
                      labelFontSize: 25,
                      isArrowShow: true,
                      horizontalPadding: 15,
                      actuatorFunctionl: () => showMaterialModalBottomSheet(
                          duration: Duration(milliseconds: 400),
                          context: context,
                          builder: (context) {
                            return Container(
                                color: Colors.white,
                                child: SafeArea(
                                    bottom: false,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: Search(),
                                    )));
                          }),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Show content intro
class ShowContentIntro extends StatelessWidget {
  const ShowContentIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              //decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Image.asset('Assets/Images/Delivery/diverseStuffBox.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 16, top: 25),
              child: Container(
                width: MediaQuery.of(context).size.width,
                //decoration: BoxDecoration(border: Border.all(width: 1)),
                child: Text(
                  'Sending packages has never been easier',
                  style: TextStyle(fontFamily: 'MoveBold', fontSize: 28),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 16, top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                //decoration: BoxDecoration(border: Border.all(width: 1)),
                child: Text(
                  'Send your packages from one point to another quickly and hussle free.',
                  style: TextStyle(fontFamily: 'MoveTextRegular', fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Show guidelines info modal
class ShowGuidelinesInfoModal extends StatelessWidget {
  const ShowGuidelinesInfoModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Container(
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text('Guidelines',
              style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 20)),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Divider(),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          //decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Text('Disclosure',
              style: TextStyle(
                  fontFamily: 'MoveTextMedium',
                  fontSize: 16,
                  color: Colors.grey.shade900)),
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            //decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Text('Please make sure your package is :',
                style: TextStyle(fontSize: 17)),
          )),
      Container(
        width: MediaQuery.of(context).size.width,
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  //decoration: BoxDecoration(border: Border.all(width: 1)),
                  height: 20,
                  child: Row(
                    children: [
                      NumberPrefix(numberValue: 1),
                      GuideTextRender(
                        textValue: 'Under N\$1000 in value',
                        fontSize: 17,
                        fontFamily: 'MoveTextBold',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  //decoration: BoxDecoration(border: Border.all(width: 1)),
                  height: 20,
                  child: Row(
                    children: [
                      NumberPrefix(numberValue: 2),
                      GuideTextRender(
                        textValue: 'Securely sealed',
                        fontSize: 17,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  //decoration: BoxDecoration(border: Border.all(width: 1)),
                  height: 50,
                  child: Row(
                    children: [
                      NumberPrefix(numberValue: 3),
                      GuideTextRender(
                        textValue:
                            'Not a prohibited item (such as recreational drugs, dangerous or illegal items).',
                        fontSize: 17,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          //decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Text('Prohibited items',
              style: TextStyle(
                  fontFamily: 'MoveTextMedium',
                  fontSize: 16,
                  color: Colors.grey.shade900)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: GuideTextRender(
          textValue:
              'Not a prohibited item (such as recreational drugs, dangerous or illegal items).',
          fontSize: 17,
          shouldUseFlexible: false,
        ),
      ),
      Expanded(
        child: GenericRectButton(
            label: 'I understand',
            isArrowShow: false,
            labelFontSize: 22,
            actuatorFunctionl: () => Navigator.pop(context)),
      )
    ]));
  }
}

//Number prefix
class NumberPrefix extends StatelessWidget {
  final int numberValue; //The value of the number
  const NumberPrefix({Key? key, required this.numberValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(border: Border.all(width: 1)),
      child: SizedBox(
          height: 40,
          width: 17,
          child: Text('${this.numberValue}.',
              style: TextStyle(fontSize: 17, fontFamily: 'MoveTextMedium'))),
    );
  }
}

//Point render
class GuideTextRender extends StatelessWidget {
  final String textValue;
  final double fontSize;
  final String fontFamily;
  final bool shouldUseFlexible;
  const GuideTextRender(
      {Key? key,
      required this.textValue,
      this.fontSize = 16,
      this.fontFamily = 'MoveTextRegular',
      this.shouldUseFlexible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.shouldUseFlexible) //Flexible based
    {
      return Flexible(
        flex: 1,
        child: Container(
          //decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Text(this.textValue,
              style: TextStyle(
                  fontSize: this.fontSize, fontFamily: this.fontFamily)),
        ),
      );
    } else //Non flexible based
    {
      return Container(
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Text(this.textValue,
            style: TextStyle(
                fontSize: this.fontSize, fontFamily: this.fontFamily)),
      );
    }
  }
}
