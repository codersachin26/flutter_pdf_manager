import 'package:flutter/material.dart';
import 'package:pdf_manager/widgets/card_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                    iconData: FontAwesomeIcons.filePdf,
                    name: "All Pdf",
                    iconColor: Colors.red,
                    dirPath: '/storage/emulated/0'),
                CardContainer(
                    iconData: Icons.download_for_offline,
                    name: "Download",
                    iconColor: Colors.green,
                    dirPath: '/storage/emulated/0/Download'),
                CardContainer(
                    iconData: FontAwesomeIcons.telegram,
                    name: "Telegram",
                    iconColor: Colors.lightBlue,
                    dirPath: '/storage/emulated/0/Telegram/Telegram Documents')
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CardContainer(
                    iconData: FontAwesomeIcons.whatsapp,
                    name: "WhatsApp",
                    iconColor: Colors.green.shade500,
                    dirPath:
                        '/storage/emulated/0/WhatsApp/Media/WhatsApp Documents'),
                CardContainer(
                    iconData: Icons.save_alt_rounded,
                    name: "Save",
                    iconColor: Colors.pink,
                    dirPath: '/storage/emulated/0/Pdf Manager/Save'),
                CardContainer(
                    iconData: Icons.favorite_rounded,
                    name: "Favorites",
                    iconColor: Colors.red,
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
                      dirPath: ''),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
