import 'package:flutter/material.dart';
import 'package:pdf_manager/widgets/container_header.dart';
import 'package:pdf_manager/widgets/tools_container.dart';

class PdfToolsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        ContainerHeader(name: "Tools", iconData: Icons.settings),
        ToolsContainer()
      ],
    ));
  }
}
