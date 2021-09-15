import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/widgets/edit_bottom_sheet.dart';
import 'package:pdf_manager/widgets/pdf_file_tile.dart';
import 'package:provider/provider.dart';

class PdfListScreen extends StatelessWidget {
  final String name;
  final String dirPath;
  const PdfListScreen({Key? key, required this.name, required this.dirPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<PdfManager>(
        builder: (context, pdfManager, _) => Scaffold(
            appBar: AppBar(
              title: Text(name),
              backgroundColor: Colors.red,
              actions: [
                IconButton(
                    onPressed: () {
                      pdfManager.setMarkingState(!pdfManager.isMarking);
                    },
                    icon: Icon(
                      Icons.mode_edit_outline_rounded,
                      color: pdfManager.isMarking ? Colors.green : Colors.white,
                      size: 28,
                    ))
              ],
            ),
            body: PdfList(dirName: name)),
      ),
    );
  }
}

class PdfList extends StatelessWidget {
  final dirName;

  const PdfList({Key? key, this.dirName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pdfManager = Provider.of<PdfManager>(context, listen: false);
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .87,
          child: FutureBuilder<List<PdfFile>>(
            future: pdfManager.getPdfs(dirName),
            builder: (context, AsyncSnapshot<List<PdfFile>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) =>
                        PdfTile(pdfFile: snapshot.data![index]));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        if (pdfManager.isMarking)
          EditBottomSheet(
            dirName: dirName,
          )
      ],
    );
  }
}
