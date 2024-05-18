import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tg_fatec/atoms/cards/cards.dart';

import '../../atoms/imagens/images_atoms.dart';


class CardsTemplate extends StatelessWidget {
  CardsTemplate(
      {required this.colorButton,
      required this.backgroundImage,
      required this.imageCardOne,
      required this.imageCardTwo,
      required this.labelOne,
      required this.labelTwo,
        required this.firstPage,
        required this.lastPage
      });
  //this.snapshot
  final String backgroundImage;
  final String imageCardOne;
  final String imageCardTwo;
  final String labelOne;
  final String labelTwo;
  final Color colorButton;
  final int firstPage;
  final int lastPage;
  // final DocumentSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(children: [
      imageDefault(context: context, image: backgroundImage, opacity: 0.3),
      ListView(
        padding: EdgeInsets.only(top: size.height * 0.1, left: 40, right: 40),
        children: [
          cardSales(
              context: context,
              image: imageCardOne,
              width: size.width,
              height: size.height,
              label: labelOne,
              color: colorButton,
              page: firstPage,
          title: "PRODUTOS"),
          SizedBox(
            height: size.height * 0.05,
          ),
          cardSales(
              context: context,
              image: imageCardTwo,
              width: size.width,
              height: size.height,
              label: labelTwo,
              color: colorButton,
              page: lastPage,
              title: "RELATÓRIO DE VENDAS"
         ),
        ],
      ),
    ]);
  }
}
