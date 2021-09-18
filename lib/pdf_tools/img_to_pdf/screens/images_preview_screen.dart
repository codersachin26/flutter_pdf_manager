import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pdf_manager/pdf_tools/img_to_pdf/models/img_to_pdf_model.dart';
import 'package:pdf_manager/widgets/dialogs.dart';

class ImagesPreviewScreen extends StatefulWidget {
  final ImgToPdf imgToPdfTool;

  const ImagesPreviewScreen({Key? key, required this.imgToPdfTool})
      : super(key: key);
  @override
  _ImagesPreviewScreenState createState() => _ImagesPreviewScreenState();
}

class _ImagesPreviewScreenState extends State<ImagesPreviewScreen> {
  int pageno = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Img to Pdf"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                        context: context,
                        builder: (context) =>
                            pdfNameDialog(context, widget.imgToPdfTool))
                    .then((value) {
                  Navigator.pop(context);
                });
              },
              icon: Icon(
                Icons.save_alt_rounded,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        height: 400.0,
                        onPageChanged: (index, page) {
                          setState(() {
                            pageno = index + 1;
                          });
                        }),
                    items: widget.imgToPdfTool.getAllImg.map((img) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: Image.file(
                              File(img.path),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(pageno.toString()),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: Text("Rotate")),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text("Remove")),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
