import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:taxiconnect/Components/Providers/SearchProvider.dart';
import 'package:taxiconnect/Components/Providers/SettingsProvider.dart';

class RenderCustomDestinations extends StatefulWidget {
  const RenderCustomDestinations({Key? key}) : super(key: key);

  @override
  _RenderCustomDestinationsState createState() =>
      _RenderCustomDestinationsState();
}

class _RenderCustomDestinationsState extends State<RenderCustomDestinations> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
      children: [
        //Original pickup location
        //! Only show current pickup location field when the pickup location field is selected
        //! Also only show if the pickup location present is different than the current pickup location from HomeProvider.
        Visibility(
          visible:
              context.read<SearchProvider>().selectedLocationFieldIndex == 0 &&
                      context
                              .read<SearchProvider>()
                              .pickupLocationController
                              .text
                              .trim()
                              .length ==
                          0
                  ? true
                  : false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListTile(
              onTap: () => context
                  .read<SearchProvider>()
                  .updateLocationSelectedInputFields(
                      locationSelected:
                          context.read<HomeProvider>().userLocationDetails,
                      context: context),
              horizontalTitleGap: -5,
              contentPadding: EdgeInsets.zero,
              leading: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(width: 1, color: Colors.black),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.gps_fixed,
                    color: Colors.white,
                    size: 18,
                  )),
              title: Text(
                'Set to my current location',
                style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 16),
              ),
              subtitle: Text(
                  '${context.read<HomeProvider>().userLocationDetails['street'] != null && context.read<HomeProvider>().userLocationDetails['street'] != false ? context.read<HomeProvider>().userLocationDetails['street'] + ', ' : ''}${context.read<HomeProvider>().userLocationDetails['city'] != false ? context.read<HomeProvider>().userLocationDetails['city'] + '' : ''}',
                  style: TextStyle(color: Colors.black)),
            ),
          ),
        ),
        Visibility(
          //! ** Same conditions as above for displaying
          visible:
              context.read<SearchProvider>().selectedLocationFieldIndex == 0 &&
                      context
                              .read<SearchProvider>()
                              .pickupLocationController
                              .text
                              .trim()
                              .length ==
                          0
                  ? true
                  : false,
          child: Divider(
            thickness: 1,
            height: 0,
          ),
        ),
        GetAdditionalCustomLocations()
      ],
    ));
  }
}

class GetAdditionalCustomLocations extends StatelessWidget {
  const GetAdditionalCustomLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List customLocationsData = context.read<SettingsProvider>().customLocations;
    return Expanded(
      child: Container(
          //decoration: BoxDecoration(border: Border.all(width: 1)),
          child: ListView.builder(
              itemCount: customLocationsData.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListTile(
                        onTap: () =>
                            customLocationsData[index]['location_data'] != null
                                ? context
                                    .read<SearchProvider>()
                                    .updateLocationSelectedInputFields(
                                        locationSelected:
                                            customLocationsData[index]
                                                ['location_data'],
                                        context: context)
                                : print('Go to settings for setup.'),
                        horizontalTitleGap: -5,
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(9, 110, 212, 1),
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromRGBO(9, 110, 212, 1)),
                                shape: BoxShape.circle),
                            child: Icon(
                              customLocationsData[index]['icon'],
                              color: Colors.white,
                              size: 18,
                            )),
                        title: Text(
                          customLocationsData[index]['location_type'],
                          style: TextStyle(
                              fontFamily: 'MoveTextMedium', fontSize: 16),
                        ),
                        subtitle:
                            customLocationsData[index]['location_data'] != null
                                ? Text(
                                    '${customLocationsData[index]['location_data']['street'] != null && customLocationsData[index]['location_data']['street'] != false ? customLocationsData[index]['location_data']['street'] + ', ' : ''}${customLocationsData[index]['location_data']['city'] != false ? customLocationsData[index]['location_data']['city'] + '' : ''}',
                                    style: TextStyle(color: Colors.black),
                                  )
                                : Text('Add location'),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                    Visibility(
                      visible: index + 1 == customLocationsData.length
                          ? false
                          : true,
                      child: Divider(
                        thickness: 1,
                        height: 0,
                      ),
                    )
                  ],
                );
              })),
    );
  }
}
