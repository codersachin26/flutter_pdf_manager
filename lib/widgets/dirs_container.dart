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
                    dirPath: '/storage/emulated/0'),
                CardContainer(
                    iconData: Icons.download_for_offline,
                    name: "Download",
                    iconColor: Colors.green,
                    dirPath: '/storage/emulated/0/Download'),
                CardContainer(
                    iconData: Icons.document_scanner_rounded,
                    name: "Telegram",
                    iconColor: Colors.lightBlue,
                    dirPath: '/storage/emulated/0/Telegram/Telegram Documents')
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CardContainer(
                    iconData: Icons.phone_iphone,
                    name: "WhatsApp",
                    iconColor: Colors.red,
                    dirPath:
                        '/storage/emulated/0/WhatsApp/Media/WhatsApp Documents'),
                CardContainer(
                    iconData: Icons.save_alt_rounded,
                    name: "Save",
                    iconColor: Colors.pink,
                    dirPath: '/storage/emulated/0/Pdf Manager/Save'),
                CardContainer(
                    iconData: Icons.favorite_border_rounded,
                    name: "Favorites",
                    iconColor: Colors.red[900],
                    dirPath: '/storage/emulated/0/Pdf Manager/Favorites')
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
                      dirPath: '/storage/emulated/0/Pdf Manager/Office'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: CardContainer(
                      iconData: Icons.sd_card_rounded,
                      name: "SD Card",
                      iconColor: Colors.black,
                      dirPath: '/storage/SD card'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
