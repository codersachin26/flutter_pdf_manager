import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final IconData iconData;
  final String name;
  final VoidCallback onTap;

  const CustomContainer(
      {Key? key,
      required this.iconData,
      required this.name,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * .16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Icon(iconData), Text(name)],
        ),
      ),
      onTap: onTap,
    );
  }
}
