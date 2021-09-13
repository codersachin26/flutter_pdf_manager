import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/widgets/custom_container.dart';

late _EditBottomSheetState editBottomSheetState;

class EditBottomSheet extends StatefulWidget {
  @override
  _EditBottomSheetState createState() {
    editBottomSheetState = _EditBottomSheetState();
    return editBottomSheetState;
  }
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(.9)),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomContainer(
            iconData: Icons.cut,
            name: "Move",
            color: PdfManager.pickedFilePaths.isNotEmpty
                ? Colors.black
                : Colors.grey,
            onTap: () {},
          ),
          CustomContainer(
            iconData: Icons.delete,
            name: "Delete",
            color: PdfManager.pickedFilePaths.isNotEmpty
                ? Colors.black
                : Colors.grey,
            onTap: () {},
          ),
          CustomContainer(
            iconData: Icons.picture_as_pdf_outlined,
            name: "Tools",
            color: PdfManager.pickedFilePaths.isNotEmpty
                ? Colors.black
                : Colors.grey,
            onTap: () {},
          ),
          CustomContainer(
            iconData: Icons.file_copy,
            name: "Rename",
            color: PdfManager.pickedFilePaths.length == 1
                ? Colors.black
                : Colors.grey,
            onTap: () {},
          )
        ],
      ),
    );
  }
}
