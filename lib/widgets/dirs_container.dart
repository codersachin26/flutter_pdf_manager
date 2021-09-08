import 'package:flutter/material.dart';
import 'package:pdf_manager/widgets/card_container.dart';

// dir cards container
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
                CardContainer(
                  iconData: Icons.picture_as_pdf_rounded,
                  name: "All Pdf",
                  iconColor: Colors.red,
                ),
                CardContainer(
                  iconData: Icons.download_for_offline,
                  name: "Download",
                  iconColor: Colors.green,
                ),
                CardContainer(
                  iconData: Icons.document_scanner_rounded,
                  name: "Documents",
                  iconColor: Colors.black12,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CardContainer(
                  iconData: Icons.phone_iphone,
                  name: "WhatsApp",
                  iconColor: Colors.red,
                ),
                CardContainer(
                  iconData: Icons.save_alt_rounded,
                  name: "Save",
                  iconColor: Colors.pink,
                ),
                CardContainer(
                  iconData: Icons.favorite_border_rounded,
                  name: "Favorites",
                  iconColor: Colors.red[900],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 13.0),
                  child: CardContainer(
                    iconData: Icons.business_center_rounded,
                    name: "Office",
                    iconColor: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: CardContainer(
                    iconData: Icons.sd_card_rounded,
                    name: "SD Card",
                    iconColor: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
