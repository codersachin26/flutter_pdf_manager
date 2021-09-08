import 'package:flutter/material.dart';

class PdfTile extends StatelessWidget {
  final file;
  final bool isPicked;

  PdfTile({Key? key, required this.file, required this.isPicked})
      : super(key: key);
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
                      file,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text("4.00MB",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w100))
                  ]),
            ),
            isPicked
                ? PickedFile()
                : SizedBox(
                    width: 10,
                  )
          ],
        ),
      ),
      onTap: () {
        if (isPicked) {
        } else {}
      },
    );
  }
}

class PickedFile extends StatelessWidget {
  const PickedFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Icon(Icons.done_sharp, size: 30, color: Colors.grey));
  }
}

BoxDecoration tileDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.red[50]!));
}
