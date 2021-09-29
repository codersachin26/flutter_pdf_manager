import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/pdf_tools/img_to_pdf/models/img_to_pdf_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

// delete action dialog
AlertDialog deleteAlertDialog(BuildContext context, listName) {
  return AlertDialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 20),
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

// pdf rename statefulwidget dialog box
class PdfRenameDialog extends StatefulWidget {
  final listName;
  const PdfRenameDialog({Key? key, required this.listName}) : super(key: key);

  @override
  _PdfRenameDialogState createState() => _PdfRenameDialogState();
}

class _PdfRenameDialogState extends State<PdfRenameDialog> {
  String? errorText;
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    final filename = Provider.of<PdfManager>(context, listen: false)
        .getmarkedPdf
        .name
        .replaceAll('.pdf', "");
    controller.text = filename;
    controller.selection =
        TextSelection(baseOffset: 0, extentOffset: filename.length);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * .26,
        child: Column(
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              autocorrect: false,
              cursorColor: Colors.red.shade300,
              onChanged: (text) {
                setState(() {
                  errorText = null;
                });
              },
              decoration: InputDecoration(
                errorText: errorText,
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
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 6, 2),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  )),
              TextButton(
                onPressed: () {
                  final pdfManager =
                      Provider.of<PdfManager>(context, listen: false);
                  final inputText = controller.text;
                  pdfManager
                      .renamePdfFile(inputText, widget.listName)
                      .then((value) {
                    if (value != null)
                      setState(() {
                        errorText = value;
                      });
                    else {
                      pdfManager.setMarkingState(false);
                      Navigator.pop(context);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 2, 8, 2),
                  child: Text(
                    "Rename",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

// new pdf name dialog
Dialog pdfNameDialog(BuildContext context, ImgToPdf imgToPdfTool) {
  TextEditingController controller = TextEditingController();
  return Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 20),
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
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
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

// pdf password protected dialog
class PasswordProtectedDialog extends StatefulWidget {
  final PdfFile pdf;
  final Function(BuildContext) onCancel;
  final Function(String) onSuccess;
  const PasswordProtectedDialog(
      {Key? key,
      required this.pdf,
      required this.onCancel,
      required this.onSuccess})
      : super(key: key);

  @override
  _PasswordProtectedDialogState createState() =>
      _PasswordProtectedDialogState();
}

class _PasswordProtectedDialogState extends State<PasswordProtectedDialog> {
  String? wrongPassword;
  String enterPassword = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: MediaQuery.of(context).size.height * .30,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "this file is protected",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onTap: () {
                  setState(() {
                    wrongPassword = null;
                  });
                },
                autofocus: true,
                onChanged: (value) {
                  enterPassword = value;
                },
                decoration: InputDecoration(
                    hintText: 'password', errorText: wrongPassword),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onCancel(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      try {
                        File memoryFile = File(widget.pdf.path);
                        PdfDocument(
                            password: enterPassword,
                            inputBytes: memoryFile.readAsBytesSync());
                        Navigator.pop(context);
                        widget.onSuccess(enterPassword);
                      } catch (e) {
                        setState(() {
                          wrongPassword = 'incorrect password';
                        });
                      }
                    },
                    child: Text(
                      'Open',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
