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
    final pdfManager = Provider.of<PdfManager>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (pdfManager.isMarking) {
          pdfManager.setMarkingState(false);
          return false;
        } else
          return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(name),
              backgroundColor: Colors.red,
              actions: [
                IconButton(onPressed: () {
                  pdfManager.setMarkingState(!pdfManager.isMarking);
                }, icon:
                    Consumer<PdfManager>(builder: (context, pdfManager, _) {
                  if (!pdfManager.isMarking)
                    return Icon(
                      Icons.mode_edit_outline_rounded,
                      color: Colors.white,
                      size: 28,
                    );
                  else
                    return Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 28,
                    );
                }))
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
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Consumer<PdfManager>(
            builder: (context, pdfManager, _) => PdfListContainer(
                  dirName: dirName,
                  pdfManager: pdfManager,
                )),
        Consumer<PdfManager>(builder: (context, pdfManager, _) {
          if (pdfManager.isMarking)
            return EditBottomSheet(
              dirName: dirName,
            );
          else
            return SizedBox();
        })
      ],
    );
  }
}

class PdfListContainer extends StatelessWidget {
  const PdfListContainer(
      {Key? key, required this.dirName, required this.pdfManager})
      : super(key: key);

  final String dirName;
  final pdfManager;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: FutureBuilder<List<PdfFile>>(
          future: pdfManager.getPdfs(dirName),
          builder: (context, AsyncSnapshot<List<PdfFile>> snapshot) {
            if (snapshot.hasData) {
              final itemLength = snapshot.data!.length;
              return ListView.builder(
                  itemCount: itemLength,
                  itemBuilder: (context, index) {
                    print('$index ___ $itemLength');

                    return PdfTile(
                      pdfFile: snapshot.data![index],
                      isLastElement: index == itemLength - 1,
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
