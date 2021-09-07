import 'package:flutter/material.dart';

class PdfListScreen extends StatefulWidget {
  final String name;
  const PdfListScreen({Key? key, required this.name}) : super(key: key);

  @override
  _PdfListScreenState createState() => _PdfListScreenState();
}

class _PdfListScreenState extends State<PdfListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          backgroundColor: Colors.red,
        ),
        body: PdfList(dirName: widget.name));
  }
}

// pdf list container
class PdfList extends StatefulWidget {
  final String dirName;
  const PdfList({Key? key, required this.dirName}) : super(key: key);

  @override
  _PdfListState createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
