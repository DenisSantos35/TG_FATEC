import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tg_fatec/atoms/cards/cards.dart';
import 'package:tg_fatec/datas_class/colors.dart';

import '../../atoms/imagens/images_atoms.dart';



class ViewSalesPage extends StatelessWidget {
  ViewSalesPage(
      {required this.colorButton,
        required this.backgroundImage,
        required this.imageCardOne,
        required this.imageCardTwo,
        required this.labelOne,
        required this.labelTwo,
        required this.midllePage,
        required this.firstPage,
        required this.lastPage,
        required this.labelThree,
        required this.imageCardThree
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
  final String labelThree;
  final String imageCardThree;
  final int midllePage;
  // final DocumentSnapshot? snapshot;



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorsApp.blueColor(),
      bottomNavigationBar: BottomAppBar(

        color: ColorsApp.blueColor(),
        child: Container(
          alignment: Alignment.center,
          child:const Text(
            "Legumes do Chicão",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: Stack(children: [
            imageDefault(context: context, image: backgroundImage, opacity: 0.3),
            GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: 210, crossAxisSpacing: 1, mainAxisSpacing: 1),
              padding: EdgeInsets.only(top: size.height * 0.03, left: 40, right: 40),
              children: [
                viewCardSales(
                    context: context,
                    image: imageCardOne,
                    width: size.width,
                    height: size.height,
                    label: labelOne,
                    color: colorButton,
                    page: firstPage,
                    title: "PRODUTOS"),

                viewCardSales(
                    context: context,
                    image: imageCardTwo,
                    width: size.width,
                    height: size.height,
                    label: labelTwo,
                    color: colorButton,
                    page: lastPage,
                    title: "RELATÓRIO DE VENDAS"
                ),

                viewCardSales(
                    context: context,
                    image: imageCardThree,
                    width: size.width,
                    height: size.height,
                    label: labelThree,
                    color: colorButton,
                    page: midllePage,
                    title: "PRODUTOS"),

              ],
            ),
          ]),
        ),
      ),
    );
  }
}
