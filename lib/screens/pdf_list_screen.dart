import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/widgets/edit_bottom_sheet.dart';
import 'package:pdf_manager/widgets/pdf_file_tile.dart';

class PdfListScreen extends StatefulWidget {
  final String name;
  final String dirPath;
  const PdfListScreen({Key? key, required this.name, required this.dirPath})
      : super(key: key);

  @override
  _PdfListScreenState createState() => _PdfListScreenState();
}

class _PdfListScreenState extends State<PdfListScreen> {
  bool isPicked = false;
  void _onEdit() {
    setState(() {
      isPicked = !isPicked;
      print(PdfManager.pickedFilePaths.length);
      PdfManager.pickedFilePaths.clear();
      print(PdfManager.pickedFilePaths.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.name),
            backgroundColor: Colors.red,
            actions: [
              IconButton(
                  onPressed: _onEdit,
                  icon: Icon(
                    Icons.mode_edit_outline_rounded,
                    color: isPicked ? Colors.green : Colors.white,
                    size: 28,
                  ))
            ],
          ),
          body: PdfList(
              dirPath: widget.dirPath,
              isPicked: isPicked,
              dirName: widget.name)),
    );
  }
}

// pdf list container
class PdfList extends StatefulWidget {
  final String dirName;
  final String dirPath;
  final isPicked;
  const PdfList(
      {Key? key,
      required this.dirPath,
      required this.isPicked,
      required this.dirName})
      : super(key: key);

  @override
  _PdfListState createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
            height: widget.isPicked
                ? MediaQuery.of(context).size.height * .89
                : MediaQuery.of(context).size.height * .87,
            child: FutureBuilder<List<PdfFile>>(
              future: PdfManager.getPdfs(widget.dirPath),
              builder: (context, AsyncSnapshot<List<PdfFile>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) => PdfTile(
                          pdfFile: snapshot.data![index],
                          isPicked: widget.isPicked));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )),
        widget.isPicked
            ? EditBottomSheet(
                dirName: widget.dirName,
              )
            : Container()
      ],
    );
  }
}
