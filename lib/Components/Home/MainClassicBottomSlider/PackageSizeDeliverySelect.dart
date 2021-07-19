import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';
import 'package:taxiconnect/Modules/GenericCircButton/GenericCircButton.dart';
import 'package:provider/provider.dart';

class PackageSizeDeliverySelect extends StatefulWidget {
  const PackageSizeDeliverySelect({
    Key? key,
  }) : super(key: key);

  @override
  _PackageSizeDeliverySelectState createState() =>
      _PackageSizeDeliverySelectState();
}

class _PackageSizeDeliverySelectState extends State<PackageSizeDeliverySelect> {
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text("What is your package size?",
                        style: TextStyle(
                            fontFamily: 'MoveBold',
                            fontSize: 24,
                            color: Colors.black))),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(child: ShowGenericPackageSizes()),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    height: 100,
                    child: ListTile(
                      leading: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'MoveTextRegular',
                                  fontSize: 15,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text:
                                        'Select the right package size for a '),
                                TextSpan(
                                    text:
                                        'better delivery handling experience.',
                                    style: TextStyle(
                                        color: Color.fromRGBO(14, 132, 145, 1),
                                        fontFamily: 'MoveTextMedium')),
                              ]),
                        ),
                      ),
                      trailing: GenericCircButton(
                        actuatorFunctionl: () => print('Navigator kicked'),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

//Render the generic list of the package sizes
class ShowGenericPackageSizes extends StatelessWidget {
  const ShowGenericPackageSizes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final packagesGenericData = context
        .read<TripProvider>()
        .packagesSizesGeneralData; //All the packages data

    return Container(
      //decoration: BoxDecoration(border: Border.all(width: 1)),
      child: ListView.builder(
          itemCount: packagesGenericData.length,
          itemBuilder: (context, int index) {
            bool isPackageSelected = context
                    .watch<TripProvider>()
                    .selectedPackageSize['package_type']
                    .toString()
                    .trim()
                    .toLowerCase() ==
                packagesGenericData[index]['package_type']
                    .toString()
                    .trim()
                    .toLowerCase();
            return Column(
              children: [
                ListTile(
                    onTap: () => context
                        .read<TripProvider>()
                        .updateSelectedPackageSize(
                            packageSizeSelected: packagesGenericData[index]),
                    leading: Container(
                      width: 50,
                      height: 100,
                      //decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Image.asset(
                        packagesGenericData[index]['icon'],
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: Text(
                        packagesGenericData[index]['app_label'].toString(),
                        style: TextStyle(
                            fontFamily: 'MoveTextMedium', fontSize: 18)),
                    subtitle: Text(packagesGenericData[index]['dimensions']),
                    trailing: Visibility(
                      visible: isPackageSelected,
                      child: Icon(Icons.check,
                          color: Color.fromRGBO(14, 132, 145, 1)),
                    )),
                Divider(
                  height: 20,
                )
              ],
            );
          }),
    );
  }
}
