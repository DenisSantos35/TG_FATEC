import 'package:flutter/material.dart';
import 'package:tg_fatec/atoms/cards/cards.dart';

import '../../atoms/imagens/images_atoms.dart';
import '../../atoms/texts/texts_atoms.dart';

class Sales extends StatelessWidget {
  const Sales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(children: [
      imageDefault(
          context: context,
          image: "assets/images/tomate_desenho.png",
          opacity: 0.3),
      ListView(
        padding: EdgeInsets.only(top: size.height * 0.1, left: 40, right: 40),
        children: [
          cardSales(
            context: context,
            image: "assets/images/realizar_vendas.png",
            width: size.width,
            height: size.height,
            label: "Realizar Vendas",
            color: Colors.red.withOpacity(0.5),
            page: 0
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          cardSales(
            context: context,
            image: "assets/images/visualizar_vendas.png",
            width: size.width,
            height: size.height,
            label: "Visualisar Vendas",
            color: Colors.red.withOpacity(0.5),
            page: 1
          ),
        ],
      ),
    ]);
  }
}
