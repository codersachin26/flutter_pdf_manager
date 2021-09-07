import 'package:flutter/material.dart';
import 'package:pdf_manager/widgets/card_container.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pdf Manager"),
          backgroundColor: Colors.red,
        ),
        body: DirsContainer());
  }
}

// dir cards conatiner
class DirsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .48,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CardConatainer(
                  iconData: Icons.picture_as_pdf_rounded,
                  name: "All Pdf",
                  color: Colors.red,
                ),
                CardConatainer(
                  iconData: Icons.download_for_offline,
                  name: "Download",
                  color: Colors.green,
                ),
                CardConatainer(
                  iconData: Icons.document_scanner_rounded,
                  name: "Documents",
                  color: Colors.black12,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CardConatainer(
                  iconData: Icons.phone_iphone,
                  name: "Whatsapp",
                  color: Colors.red,
                ),
                CardConatainer(
                  iconData: Icons.save_alt_rounded,
                  name: "Save",
                  color: Colors.pink,
                ),
                CardConatainer(
                  iconData: Icons.favorite_border_rounded,
                  name: "Favorites",
                  color: Colors.red[900],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: CardConatainer(
                    iconData: Icons.business_center_rounded,
                    name: "Office",
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: CardConatainer(
                    iconData: Icons.sd_card_rounded,
                    name: "SD Card",
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
