import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/screens/home_screen.dart';
import 'package:pdf_manager/screens/pdf_list_screen.dart';

void main() {
  PdfManager.createDirs();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        home: HomeScreen());
  }
}
