import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/pdf_tools/encrypt_pdf/models/encrypt_pdf_model.dart';
import 'package:pdf_manager/utils/get_file_size.dart';
import 'package:pdf_manager/widgets/custom_btn.dart';
import 'package:pdf_manager/widgets/pdf_file_tile.dart';
import 'package:provider/provider.dart';

class PdfEncryptionScreen extends StatefulWidget {
  @override
  _PdfEncryptionScreenState createState() => _PdfEncryptionScreenState();
}

class _PdfEncryptionScreenState extends State<PdfEncryptionScreen> {
  final PdfEncryptTool pdfEncryptTool = PdfEncryptTool();
  bool isFilePicked = false;

  void resetPdfEncryptionState() {
    setState(() {
      isFilePicked = false;
    });
  }

  void onTap() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      final file = result.files.first;

      pdfEncryptTool
          .addPdf(PdfFile(file.name, getFileSize(file.path!), file.path!));
      setState(() {
        isFilePicked = true;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pdf file did not pick')));
    }
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
                  padding: EdgeInsets.only(top: 14),
                  child: CustomBtn(
                    text: 'Choose Pdf',
                    onTap: onTap,
                  ),
                ),
                if (isFilePicked)
                  SetPasswordContainer(
                      pdfEncryptTool: pdfEncryptTool,
                      setPdfEncryptionState: resetPdfEncryptionState)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// set pdf password
class SetPasswordContainer extends StatefulWidget {
  final PdfEncryptTool pdfEncryptTool;
  final VoidCallback setPdfEncryptionState;

  SetPasswordContainer(
      {Key? key,
      required this.pdfEncryptTool,
      required this.setPdfEncryptionState})
      : super(key: key);

  @override
  _SetPasswordContainerState createState() => _SetPasswordContainerState();
}

class _SetPasswordContainerState extends State<SetPasswordContainer> {
  String? passwrdError;
  String passwrd1 = '';
  String passwrd2 = '';

  void onTap() {
    if (passwrd2 == passwrd1) {
      widget.pdfEncryptTool.encryptIt(passwrd1).then((value) {
        if (value.isEmpty) {
          final pdfManager = Provider.of<PdfManager>(context, listen: false);
          pdfManager.addPdfToList('Save', widget.pdfEncryptTool.getPdfFile);
          widget.setPdfEncryptionState();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('File encrypted successfully')));
        } else {
          ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
            content: Text(value),
            actions: [
              TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ))
            ],
            backgroundColor: Colors.white,
          ));
          Timer(Duration(seconds: 5), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
        }
      });
    } else {
      setState(() {
        passwrdError = "password didn't matched";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .96,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          PdfTile(
            pdfFile: widget.pdfEncryptTool.getPdfFile,
            isLastElement: false,
          ),
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
            height: 14,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomBtn(
              text: 'encrypt',
              onTap: onTap,
            ),
          )
        ],
      ),
    );
  }
}
