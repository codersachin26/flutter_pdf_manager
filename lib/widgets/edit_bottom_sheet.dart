import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/widgets/bottom_sheets.dart';
import 'package:pdf_manager/widgets/custom_container.dart';
import 'package:pdf_manager/widgets/dialogs.dart';
import 'package:provider/provider.dart';

class EditBottomSheet extends StatelessWidget {
  final dirName;

  const EditBottomSheet({Key? key, this.dirName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<PdfManager>(
      builder: (context, pdfManager, _) => Container(
        decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(.9)),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomContainer(
              iconData: Icons.cut,
              name: "Move",
              color: pdfManager.markedCount != 0 ? Colors.black : Colors.grey,
              onTap: () {
                if (pdfManager.markedCount != 0)
                  movePdfBottomSheet(context, dirName);
              },
            ),
            CustomContainer(
              iconData: Icons.delete,
              name: "Delete",
              color: pdfManager.markedCount != 0 ? Colors.black : Colors.grey,
              onTap: () {
                if (pdfManager.markedCount != 0)
                  showDialog(
                      context: context,
                      builder: (context) =>
                          deleteAlertDialog(context, dirName));
              },
            ),
            // CustomContainer(
            //   iconData: Icons.picture_as_pdf_outlined,
            //   name: "Tools",
            //   color: pdfManager.markedCount != 0 ? Colors.black : Colors.grey,
            //   onTap: () {},
            // ),
            CustomContainer(
              iconData: Icons.file_copy,
              name: "Rename",
              color: pdfManager.markedCount == 1 ? Colors.black : Colors.grey,
              onTap: () {
                if (pdfManager.markedCount == 1)
                  showDialog(
                      context: context,
                      builder: (context) => PdfRenameDialog(listName: dirName));
              },
            )
          ],
        ),
      ),
    );
  }
}
