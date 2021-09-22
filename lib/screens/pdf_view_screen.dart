import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/widgets/dialogs.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:after_layout/after_layout.dart';

class PdfViewScreen extends StatelessWidget {
  final PdfFile pdf;
  PdfViewScreen({Key? key, required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pdf.name,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: PdfViewContainer(
          pdf: pdf,
        ),
      ),
    );
  }
}

// pdf view container
class PdfViewContainer extends StatefulWidget {
  final PdfFile pdf;
  const PdfViewContainer({Key? key, required this.pdf}) : super(key: key);

  @override
  _PdfViewContainerState createState() => _PdfViewContainerState();
}

class _PdfViewContainerState extends State<PdfViewContainer>
    with AfterLayoutMixin<PdfViewContainer> {
  bool isPasswordProtected = false;

  String? pdfPassword;

  void onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  void onSuccess(String protectedPassword) {
    isPasswordProtected = !isPasswordProtected;
    pdfPassword = protectedPassword;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    try {
      File memoryFile = File(widget.pdf.path);
      PdfDocument(inputBytes: memoryFile.readAsBytesSync());
      setState(() {
        isPasswordProtected = true;
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => PasswordProtectedDialog(
              pdf: widget.pdf, onCancel: onCancel, onSuccess: onSuccess));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isPasswordProtected)
      return PdfView(
        pdf: widget.pdf,
        pdfPassword: pdfPassword,
      );
    else
      return Container();
  }
}

// pdf view

class PdfView extends StatefulWidget {
  final String? pdfPassword;
  final PdfFile pdf;
  PdfView({Key? key, required this.pdf, this.pdfPassword}) : super(key: key);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfView> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  int? pages = 0;

  int? currentPage = 0;

  bool isReady = false;

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PDFView(
          password: widget.pdfPassword,
          filePath: widget.pdf.path,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          pageFling: true,
          pageSnap: true,
          defaultPage: currentPage!,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation:
              false, // if set to true the link is handled in flutter
          onRender: (_pages) {
            setState(() {
              pages = _pages;
              isReady = true;
            });
          },
          onError: (error) {
            setState(() {
              errorMessage = error.toString();
            });
            print(error.toString());
          },
          onPageError: (page, error) {
            setState(() {
              errorMessage = '$page: ${error.toString()}';
            });
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onLinkHandler: (String? uri) {
            print('goto uri: $uri');
          },
          onPageChanged: (int? page, int? total) {
            if (page != null) page += 1;
            print('page change: $page /$total');
            setState(() {
              currentPage = page;
            });
          },
        ),
        errorMessage.isEmpty
            ? !isReady
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
            : Center(
                child: Text(errorMessage),
              )
      ],
    );
  }
}
