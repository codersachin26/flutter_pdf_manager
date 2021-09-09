import 'package:flutter/material.dart';
import 'package:pdf_manager/widgets/tool_card_container.dart';

class ToolsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .90,
      height: MediaQuery.of(context).size.height * .18,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ToolCardContainer(
                iconData: Icons.image,
                name: "img to pdf",
                iconColor: Colors.red,
                onTap: () {},
              ),
              ToolCardContainer(
                  iconData: Icons.enhanced_encryption_rounded,
                  name: "encrypt",
                  iconColor: Colors.red,
                  onTap: () {}),
              ToolCardContainer(
                  iconData: Icons.compress_rounded,
                  name: "compress",
                  iconColor: Colors.red,
                  onTap: () {})
            ],
          )
        ],
      ),
    );
  }
}
