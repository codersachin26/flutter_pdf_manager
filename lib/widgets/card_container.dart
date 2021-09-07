import 'package:flutter/material.dart';
import 'package:pdf_manager/screens/pdf_list_screen.dart';

class CardConatainer extends StatelessWidget {
  final IconData iconData;
  final String name;
  final Color? color;

  const CardConatainer(
      {Key? key,
      required this.iconData,
      required this.name,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(iconData, color: color, size: 45.0),
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
