import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';

class PdfTile extends StatefulWidget {
  final pdfFile;
  final bool isPicked;

  PdfTile({Key? key, required this.pdfFile, required this.isPicked})
      : super(key: key);

  @override
  _PdfTileState createState() => _PdfTileState();
}

class _PdfTileState extends State<PdfTile> {
  Color color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: MediaQuery.of(context).size.height * .11,
        width: MediaQuery.of(context).size.width * .97,
        decoration: tileDecoration(),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .17,
              child: Icon(
                Icons.picture_as_pdf_rounded,
                size: 55,
                color: Colors.red,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .66,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.pdfFile.name,
                      style: TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(widget.pdfFile.size,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w100))
                  ]),
            ),
            widget.isPicked
                ? PickedFile(
                    color: color,
                  )
                : SizedBox(
                    width: 10,
                  )
          ],
        ),
      ),
      onTap: () {
        print('file tap');
        if (widget.isPicked) {
          if (PdfManager.pickedFilePaths.contains(widget.pdfFile.path)) {
            PdfManager.pickedFilePaths.remove(widget.pdfFile.path);
            setState(() {
              color = Colors.grey;
            });
          } else {
            PdfManager.pickedFilePaths.add(widget.pdfFile.path);
            setState(() {
              color = Colors.deepPurple;
            });
          }
        } else {}
      },
    );
  }
}

class PickedFile extends StatelessWidget {
  final color;
  const PickedFile({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Icon(Icons.done_sharp, size: 30, color: color ?? Colors.grey));
  }
}

BoxDecoration tileDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.red[50]!));
}
