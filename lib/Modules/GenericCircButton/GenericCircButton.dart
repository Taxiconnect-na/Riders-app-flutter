import 'package:flutter/material.dart';

//? DestinationRouteNature: can be "obvious" (for static know ones) or "ambigue" (for variable ones)

class GenericCircButton extends StatefulWidget {
  late final String destinationRouteName, destinationRouteNature;
  late final String originRouteName;
  GenericCircButton(
      {required this.originRouteName,
      required this.destinationRouteName,
      required this.destinationRouteNature});

  @override
  _GenericCircButtonState createState() => _GenericCircButtonState(
      originRouteName: this.originRouteName,
      destinationRouteName: this.destinationRouteName,
      destinationRouteNature: this.destinationRouteNature);
}

class _GenericCircButtonState extends State<GenericCircButton> {
  ///Will receive the destination route for straight static destination route or
  ///origin routes for non obvious destination route (which can depend on the server analysis)
  late final String destinationRouteName, destinationRouteNature;
  late final String originRouteName;
  _GenericCircButtonState(
      {required this.originRouteName,
      required this.destinationRouteName,
      required this.destinationRouteNature});

  @override
  Widget build(BuildContext context) {
    print(this.originRouteName);
    print(this.destinationRouteName);
    print(this.destinationRouteNature);
    return InkWell(
        onTap: () {
          if (this.destinationRouteNature == 'obvious') //Static
          {
            Navigator.pushNamed(context, '/${this.destinationRouteName}');
          } else //ambigue destination - do some processing first
          {
            Navigator.pushNamed(context, '/${this.destinationRouteName}');
          }
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 5,
            )
          ], shape: BoxShape.circle, color: Color.fromRGBO(14, 132, 145, 1)),
          child: Icon(
            Icons.arrow_forward,
            size: 33,
            color: Colors.white,
          ),
        ));
  }
}
