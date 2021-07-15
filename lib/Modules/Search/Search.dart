import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:taxiconnect/Components/Providers/SearchProvider.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';

import 'DestinationInputsFields.dart';
import 'RenderDestinationSearchData.dart';

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
          bottom: false,
          child: Column(
            children: [GoBackPart(), HeaderPart(), BottomPart()],
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
      decoration: BoxDecoration(color: Colors.white),
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
  final FocusNode pickupLocationFocusNode = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Focus node for the pickup location
    pickupLocationFocusNode.addListener(() {
      if (this.pickupLocationFocusNode.hasFocus) {
        context
            .read<SearchProvider>()
            .updateSelectedLocationFieldIndex(newLocationIndex: 0);
      }
    });
    //..
    //Initialize pickup location
    context.read<SearchProvider>().updatePickupLocationDetails(
        newLocation: context.read<HomeProvider>().userLocationDetails);
    //Add the value
    context.read<SearchProvider>().updatePickupLocationIFieldController(
        value: context
                    .read<SearchProvider>()
                    .pickupLocationData['location_name'] !=
                null
            ? context.read<SearchProvider>().pickupLocationData['location_name']
            : 'Searching');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    pickupLocationFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 7),
                spreadRadius: 1,
                blurRadius: 6)
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              width: 15,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, top: 1),
                      child: Container(
                        width: 1,
                        height: 45,
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.5)),
                      ),
                    ),
                    Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(9, 110, 212, 1)),
                            color: Color.fromRGBO(9, 110, 212, 1)))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  //decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                                width: 1, color: Colors.grey.shade300)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                              controller: context
                                  .read<SearchProvider>()
                                  .pickupLocationController,
                              autocorrect: false,
                              focusNode: pickupLocationFocusNode,
                              maxLength: 35,
                              onChanged: (value) => context
                                  .read<SearchProvider>()
                                  .updateLocationQueryDataPerLocation(
                                      query: value),
                              style: TextStyle(fontSize: 17),
                              decoration: InputDecoration(
                                  counterText: "",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: 'Pickup location',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 11))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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

//Bottom part
class BottomPart extends StatefulWidget {
  const BottomPart({Key? key}) : super(key: key);

  @override
  _BottomPartState createState() => _BottomPartState();
}

class _BottomPartState extends State<BottomPart> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: RenderDestinationSearchData(),
        ),
      ),
    );
  }
}
