import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tg_fatec/atoms/texts/texts_atoms.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile({required this.icon, required this.text, required this.page, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Get.back();
          controller.jumpToPage(page);

        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 80.0,
          child: Row(
            children: [
              Icon(icon, size: 32, color: controller.page!.round() == page? Colors.orange.shade100 : Colors.white,),
              SizedBox(width: 32.0,),
              TextTitle(label: text, size: 14, fontWeight: FontWeight.bold, color: controller.page!.round() == page? Colors.orange.shade100  : Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
