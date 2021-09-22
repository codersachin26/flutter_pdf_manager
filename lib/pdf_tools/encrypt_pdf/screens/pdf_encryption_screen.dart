import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/pdf_tools/encrypt_pdf/models/encrypt_pdf_model.dart';
import 'package:pdf_manager/utils/get_file_size.dart';
import 'package:pdf_manager/widgets/pdf_file_tile.dart';
import 'package:provider/provider.dart';

class PdfEncryptionScreen extends StatefulWidget {
  @override
  _PdfEncryptionScreenState createState() => _PdfEncryptionScreenState();
}

class _PdfEncryptionScreenState extends State<PdfEncryptionScreen> {
  final PdfEncryptTool pdfEncryptTool = PdfEncryptTool();
  bool isFilePicked = false;

  void setPdfEncryptionState() {
    setState(() {
      isFilePicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Pdf Encryption"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf']);
                      if (result != null) {
                        final file = result.files.first;

                        pdfEncryptTool.addPdf(PdfFile(
                            file.name, getFileSize(file.path!), file.path!));
                        setState(() {
                          isFilePicked = true;
                        });
                      }
                    },
                    child: Text(
                      " Choose Pdf ",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Colors.red.shade400))),
                  ),
                ),
                if (isFilePicked)
                  EnterPasswordContainer(
                      pdfEncryptTool: pdfEncryptTool,
                      setPdfEncryptionState: setPdfEncryptionState)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EnterPasswordContainer extends StatefulWidget {
  final PdfEncryptTool pdfEncryptTool;
  final VoidCallback setPdfEncryptionState;

  EnterPasswordContainer(
      {Key? key,
      required this.pdfEncryptTool,
      required this.setPdfEncryptionState})
      : super(key: key);

  @override
  _EnterPasswordContainerState createState() => _EnterPasswordContainerState();
}

class _EnterPasswordContainerState extends State<EnterPasswordContainer> {
  String? passwrdError;
  String passwrd1 = '';
  String passwrd2 = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .97,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          PdfTile(pdfFile: widget.pdfEncryptTool.getPdfFile),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Password'),
            onChanged: (value) {
              passwrd1 = value;
              print(passwrd1);
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Re-Enter Password', errorText: passwrdError),
            onChanged: (value) {
              passwrd2 = value;
              print(passwrd2);
            },
            onTap: () {
              setState(() {
                passwrdError = null;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text(" encrypt ", style: TextStyle(color: Colors.red)),
              onPressed: () {
                if (passwrd2 == passwrd1) {
                  widget.pdfEncryptTool.encryptIt(passwrd1).then((value) {
                    final pdfManager =
                        Provider.of<PdfManager>(context, listen: false);
                    pdfManager.addPdfToList(
                        'Save', widget.pdfEncryptTool.getPdfFile);
                  });
                  widget.setPdfEncryptionState();
                } else {
                  setState(() {
                    passwrdError = "password didn't matched";
                  });
                }
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Colors.red.shade400))),
            ),
          )
        ],
      ),
    );
  }
}
