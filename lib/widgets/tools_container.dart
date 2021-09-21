import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_manager/pdf_tools/encrypt_pdf/screens/pdf_encryption_screen.dart';
import 'package:pdf_manager/pdf_tools/img_to_pdf/models/img_to_pdf_model.dart';
import 'package:pdf_manager/pdf_tools/img_to_pdf/screens/images_preview_screen.dart';
import 'package:pdf_manager/widgets/tool_card_container.dart';

class ToolsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .90,
      height: MediaQuery.of(context).size.height * .18,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ToolCardContainer(
                iconData: Icons.image,
                name: "img to pdf",
                iconColor: Colors.red,
                onTap: () async {
                  final imagePicker = ImagePicker();
                  await imagePicker.pickMultiImage().then((images) {
                    if (images != null) {
                      final imgToPdfTool = ImgToPdf(images);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImagesPreviewScreen(
                                    imgToPdfTool: imgToPdfTool,
                                  )));
                    }
                  });
                },
              ),
              ToolCardContainer(
                  iconData: Icons.enhanced_encryption_rounded,
                  name: "encrypt",
                  iconColor: Colors.red,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfEncryptionScreen()));
                  }),
              ToolCardContainer(
                  iconData: Icons.compress_rounded,
                  name: "compress",
                  iconColor: Colors.red,
                  onTap: () {})
            ],
          )
        ],
      ),
    );
  }
}
