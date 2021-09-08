import 'package:flutter/material.dart';
import 'package:pdf_manager/screens/home_screen.dart';
import 'package:pdf_manager/screens/pdf_list_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        home: PdfListScreen(name: "Pdf Dir"));
  }
}
