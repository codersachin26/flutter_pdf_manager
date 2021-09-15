import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/screens/pdf_view_screen.dart';
import 'package:provider/provider.dart';

class PdfTile extends StatefulWidget {
  final PdfFile pdfFile;

  PdfTile({Key? key, required this.pdfFile}) : super(key: key);

  @override
  _PdfTileState createState() => _PdfTileState();
}

class _PdfTileState extends State<PdfTile> {
  @override
  Widget build(BuildContext context) {
    final pdfManager = Provider.of<PdfManager>(context, listen: false);

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
            pdfManager.isMarking
                ? DoneIcon(
                    color: pdfManager.isMarked(widget.pdfFile.name)
                        ? Colors.deepPurple
                        : Colors.grey,
                  )
                : SizedBox(
                    width: 10,
                  )
          ],
        ),
      ),
      onTap: () {
        if (pdfManager.isMarking) {
          final pdfManager = Provider.of<PdfManager>(context, listen: false);
          pdfManager.marked(widget.pdfFile);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PdfViewScreen(pdf: widget.pdfFile)));
        }
      },
    );
  }
}

class DoneIcon extends StatelessWidget {
  final color;
  const DoneIcon({Key? key, this.color}) : super(key: key);

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
