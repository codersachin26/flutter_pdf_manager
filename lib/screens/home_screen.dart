import 'package:flutter/material.dart';
import 'package:pdf_manager/widgets/dirs_container.dart';
import 'package:pdf_manager/widgets/pdf_tools_container.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Pdf Manager"),
            backgroundColor: Colors.red,
          ),
          body: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          DirsContainer(),
          SizedBox(height: 5),
          PdfToolsContainer()
        ],
      ),
    );
  }
}
