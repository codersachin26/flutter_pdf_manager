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
        backgroundColor: Colors.red,
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
                            decoration: BoxDecoration(color: Colors.white),
                            child: Image.memory(
                              img,
                              fit: BoxFit.contain,
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
                  TextButton(
                      onPressed: () {
                        widget.imgToPdfTool
                            .changeOrientation(pageno - 1)
                            .then((value) {
                          setState(() {});
                          print(widget.imgToPdfTool.getAllImg.length);
                        });
                      },
                      child: Text("Rotate")),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        final pageindex = pageno - 1;
                        widget.imgToPdfTool.remove(pageno - 1);
                        setState(() {
                          if (pageindex == widget.imgToPdfTool.getAllImg.length)
                            pageno -= 1;
                        });
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
