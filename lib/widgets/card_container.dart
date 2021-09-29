import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/screens/pdf_list_screen.dart';
import 'package:provider/provider.dart';

class CardContainer extends StatelessWidget {
  final IconData iconData;
  final String name;
  final Color? iconColor;
  final String dirPath;

  const CardContainer(
      {Key? key,
      required this.iconData,
      required this.name,
      required this.iconColor,
      required this.dirPath})
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
        if (dirPath.isNotEmpty) {
          Provider.of<PdfManager>(context, listen: false)
              .setMarkingState(false);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PdfListScreen(name: name, dirPath: dirPath)));
        } else {
          ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
              content: Text('SDcard is not implemented yet!'),
              actions: [
                TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ))
              ],
              backgroundColor: Colors.yellow));
          Timer(Duration(seconds: 5), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
        }
      },
    );
  }
}
