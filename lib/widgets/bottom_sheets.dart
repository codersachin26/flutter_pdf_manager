import 'package:flutter/material.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';

void movePdfBottomSheet(BuildContext context, String dirName) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (context) => Container(
            height: 180,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              margin: EdgeInsets.only(right: 10, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                      child: Text(
                    "Move Pdf",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                  Container(
                    width: MediaQuery.of(context).size.width * .97,
                    height: 1,
                    color: Colors.black,
                  ),
                  if (dirName != 'Favorites')
                    InkWell(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_rounded,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Favorites",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        PdfManager.moveFile('Favorites/');
                        Navigator.pop(context);
                      },
                    ),
                  if (dirName != 'Office')
                    InkWell(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.business_center_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Office",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        PdfManager.moveFile('Office/');
                        Navigator.pop(context);
                      },
                    ),
                  if (dirName != 'Download')
                    InkWell(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.download_rounded,
                              color: Colors.lightGreen,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Download",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        PdfManager.moveFile('Download/');
                        Navigator.pop(context);
                      },
                    ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ));
}
