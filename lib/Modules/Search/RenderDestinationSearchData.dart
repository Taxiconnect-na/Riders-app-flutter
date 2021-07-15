import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Providers/SearchProvider.dart';
import 'package:provider/provider.dart';

//Render destination research data
class RenderDestinationSearchData extends StatelessWidget {
  const RenderDestinationSearchData({Key? key}) : super(key: key);

  Widget renderProxiedData(BuildContext context) {
    if (context.watch<SearchProvider>().selectedLocationFieldIndex ==
        0) //Pickup location index
    {
      print(context.watch<SearchProvider>().pickupLocationData['query']);
      if (context.watch<SearchProvider>().pickupLocationData['location_name'] ==
          null) //No custom pickup location
      {}
      return Text('Rendered proxied pickup location data');
    } else //Not pickup location - passenger location
    {
      print(context.watch<SearchProvider>().destination1Data['query']);
      return Text(
          'Rendered proxied data ${context.watch<SearchProvider>().selectedLocationFieldIndex}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: renderProxiedData(context),
    );
  }
}
