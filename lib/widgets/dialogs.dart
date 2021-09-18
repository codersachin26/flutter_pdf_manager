import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/pdf_tools/img_to_pdf/models/img_to_pdf_model.dart';
import 'package:provider/provider.dart';

// delete action dialog
AlertDialog deleteAlertDialog(BuildContext context, listName) {
  return AlertDialog(
    content: Text("Are you sure you want to delete these files?"),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Cancel",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      TextButton(
        onPressed: () {
          final pdfManager = Provider.of<PdfManager>(context, listen: false);
          pdfManager.removeFiles(listName).then((value) {
            pdfManager.setMarkingState(false);
          });
          Navigator.pop(context);
        },
        child: Text(
          "Delete",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      )
    ],
  );
}

// rename dialog
Dialog pdfRenameDailog(BuildContext context, String listName) {
  TextEditingController controller = TextEditingController();
  controller.text = Provider.of<PdfManager>(context, listen: false)
      .getmarkedPdf
      .name
      .replaceAll('.pdf', "");
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * .23,
      child: Column(
        children: [
          TextField(
            controller: controller,
            autofocus: true,
            autocorrect: false,
            cursorColor: Colors.red.shade300,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade200),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade200),
              ),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.red))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                )),
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Colors.lightGreen.shade400))),
              onPressed: () {
                final pdfManager =
                    Provider.of<PdfManager>(context, listen: false);
                final inputText = controller.text;
                pdfManager.renamePdfFile(inputText, listName).then((value) {
                  pdfManager.setMarkingState(false);
                });
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ])
        ],
      ),
    ),
  );
}

// new pdf name dialog
Dialog pdfNameDialog(BuildContext context, ImgToPdf imgToPdfTool) {
  TextEditingController controller = TextEditingController();
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * .27,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Pdf name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          TextField(
            controller: controller,
            autofocus: true,
            autocorrect: false,
            cursorColor: Colors.red.shade300,
            decoration: InputDecoration(
              labelText: "Pdf Name",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade200),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade200),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.red))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                )),
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Colors.lightGreen.shade400))),
              onPressed: () {
                imgToPdfTool.convertToPdf(controller.text).then((file) {
                  Provider.of<PdfManager>(context, listen: false)
                      .addPdfToList('Save', file);
                  Navigator.pop(context);
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Text(
                  "Create",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ])
        ],
      ),
    ),
  );
}
