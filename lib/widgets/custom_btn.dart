import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomBtn({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 11, right: 11, top: 7, bottom: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red)),
        child: Text(
          text,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        ),
      ),
      onTap: onTap,
    );
  }
}
