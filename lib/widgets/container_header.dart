import 'package:flutter/material.dart';

class ContainerHeader extends StatelessWidget {
  final String name;
  final IconData iconData;
  const ContainerHeader({Key? key, required this.iconData, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            children: <Widget>[
              Text("Tools",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Icon(
                iconData,
                color: Colors.black87,
                size: 30,
              )
            ],
          ),
        ));
  }
}
