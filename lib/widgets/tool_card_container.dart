import 'package:flutter/material.dart';

class ToolCardContainer extends StatelessWidget {
  final IconData iconData;
  final String name;
  final Color? iconColor;
  final VoidCallback onTap;

  const ToolCardContainer(
      {Key? key,
      required this.iconData,
      required this.name,
      required this.iconColor,
      required this.onTap})
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
      onTap: onTap,
    );
  }
}
