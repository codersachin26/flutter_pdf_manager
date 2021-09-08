import 'package:flutter/material.dart';
import 'package:pdf_manager/screens/pdf_list_screen.dart';

class CardContainer extends StatelessWidget {
  final IconData iconData;
  final String name;
  final Color? iconColor;

  const CardContainer(
      {Key? key,
      required this.iconData,
      required this.name,
      required this.iconColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(iconData, color: iconColor, size: 45.0),
          Text(name)
        ],
      )),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PdfListScreen(name: name)));
      },
    );
  }
}
