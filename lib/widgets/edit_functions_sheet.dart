import 'package:flutter/material.dart';
import 'package:pdf_manager/widgets/custom_container.dart';

class EditSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(.9)),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomContainer(
            iconData: Icons.move_to_inbox_rounded,
            name: "Move",
            onTap: () {},
          ),
          CustomContainer(
            iconData: Icons.delete,
            name: "Delete",
            onTap: () {},
          ),
          CustomContainer(
            iconData: Icons.picture_as_pdf_outlined,
            name: "Tools",
            onTap: () {},
          )
        ],
      ),
    );
  }
}
