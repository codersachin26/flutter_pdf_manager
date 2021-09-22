import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/pdf_tools/compress_pdf/models/pdf_compressor.dart';
import 'package:pdf_manager/utils/get_file_size.dart';
import 'package:pdf_manager/widgets/pdf_file_tile.dart';
import 'package:provider/provider.dart';

class PdfCompressorScreen extends StatefulWidget {
  @override
  _PdfCompressorScreenState createState() => _PdfCompressorScreenState();
}

class _PdfCompressorScreenState extends State<PdfCompressorScreen> {
  final PdfCompressorTool pdfCompressorTool = PdfCompressorTool();
  bool isFilePicked = false;

  void setPdfCompressorState() {
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

                        pdfCompressorTool.addPdf(PdfFile(
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
                  CompressorContainer(
                      pdfCompressorTool: pdfCompressorTool,
                      setPdfCompressorState: setPdfCompressorState)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompressorContainer extends StatefulWidget {
  final PdfCompressorTool pdfCompressorTool;
  final VoidCallback setPdfCompressorState;

  CompressorContainer(
      {Key? key,
      required this.pdfCompressorTool,
      required this.setPdfCompressorState})
      : super(key: key);

  @override
  _CompressorContainerState createState() => _CompressorContainerState();
}

class _CompressorContainerState extends State<CompressorContainer> {
  CompressQuality _quality = CompressQuality.MEDIUM;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .95,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          PdfTile(pdfFile: widget.pdfCompressorTool.getPdfFile),
          ListTile(
            onTap: () {
              setState(() {
                _quality = CompressQuality.LOW;
              });
            },
            title: const Text('Low'),
            leading: Radio(
              value: CompressQuality.LOW,
              groupValue: _quality,
              onChanged: (CompressQuality? value) {
                setState(() {
                  _quality = value!;
                });
              },
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                _quality = CompressQuality.MEDIUM;
              });
            },
            title: const Text('Medium'),
            leading: Radio(
              value: CompressQuality.MEDIUM,
              groupValue: _quality,
              onChanged: (CompressQuality? value) {
                setState(() {
                  _quality = value!;
                });
              },
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                _quality = CompressQuality.HIGH;
              });
            },
            title: const Text('High'),
            leading: Radio(
              value: CompressQuality.HIGH,
              groupValue: _quality,
              onChanged: (CompressQuality? value) {
                setState(() {
                  _quality = value!;
                });
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                widget.pdfCompressorTool.compressor(_quality).then((value) {
                  final pdfManager =
                      Provider.of<PdfManager>(context, listen: false);
                  pdfManager.addPdfToList(
                      'Save', widget.pdfCompressorTool.getPdfFile);
                  widget.setPdfCompressorState();
                });
              },
              child: Text(
                " Compress ",
                style: TextStyle(color: Colors.red),
              ),
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
