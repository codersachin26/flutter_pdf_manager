import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:provider/provider.dart';

AlertDialog deleteAlertDialog(BuildContext context, listName) {
  return AlertDialog(
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
