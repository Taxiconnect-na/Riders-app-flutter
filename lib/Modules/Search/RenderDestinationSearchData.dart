import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Providers/SearchProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Modules/Search/Search.dart';

//Render destination research data
class RenderDestinationSearchData extends StatelessWidget {
  const RenderDestinationSearchData({Key? key}) : super(key: key);

  Widget renderProxiedData(BuildContext context) {
    if (context.watch<SearchProvider>().selectedLocationFieldIndex ==
        0) //Pickup location index
    {
      if (context
              .watch<SearchProvider>()
              .pickupLocationController
              .text
              .trim()
              .length <=
          0) //Empty text field, so suggest current pickup location or other custom ones set.
      {
        return Text(
            'Empty field, suggest current pickup location point or custom ones.');
      } else //Has some value already - suggest
      {
        return renderFutureBuilderResearchData(context);
      }
    } else //Not pickup location - passenger location
    {
      return renderFutureBuilderResearchData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
      child: renderProxiedData(context),
    );
  }

  //Render Future builder research data
  Widget renderFutureBuilderResearchData(BuildContext context) {
    if (context.read<SearchProvider>().resultSearchLocations != null) {
      if (context.watch<SearchProvider>().resultSearchLocations.runtimeType !=
              int &&
          context.watch<SearchProvider>().resultSearchLocations.runtimeType !=
              double) {
        return FutureBuilder(
            future: context.watch<SearchProvider>().resultSearchLocations,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  snapshot.hasError == false) //Got some data
              {
                return createResultsListView(snapshot.data, context);
              }
              return SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(child: CircularProgressIndicator()));
            });
      } else //Empty Search
      {
        return Text(
            'Rendered empty proxied data ${context.watch<SearchProvider>().selectedLocationFieldIndex}');
      }
    } else //No iniitialized yet
    {
      return Text(
          'Rendered not initialized proxied data ${context.watch<SearchProvider>().selectedLocationFieldIndex}');
    }
  }

  //Create a list of data results
  Widget createResultsListView(List data, BuildContext context) {
    data.removeWhere((element) => element == null); //Remove all null values.
    print('${data.length} locations found.');
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            log(data[index]['location_name']);
            return Container(
              //decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      onTap: () => context
                          .read<SearchProvider>()
                          .updateLocationSelectedInputFields(
                              locationSelected: data[index], context: context),
                      horizontalTitleGap: -5,
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(width: 1, color: Colors.grey),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 18,
                          )),
                      title: Text(
                        data[index]['location_name'],
                        style: TextStyle(
                            fontFamily: 'MoveTextMedium', fontSize: 16),
                      ),
                      subtitle: Text(
                          '${data[index]['street'] != false ? data[index]['street'] + ', ' : ''}${data[index]['city'] != false ? data[index]['city'] + '' : ''}'),
                    ),
                  ),
                  Visibility(
                    visible: index + 1 == data.length ? false : true,
                    child: Divider(
                      thickness: 1,
                      height: 0,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
