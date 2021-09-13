import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final IconData iconData;
  final String name;
  final VoidCallback onTap;
  final Color color;

  const CustomContainer(
      {Key? key,
      required this.iconData,
      required this.name,
      required this.onTap,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * .17,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            Text(
              name,
              style: TextStyle(color: color),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
