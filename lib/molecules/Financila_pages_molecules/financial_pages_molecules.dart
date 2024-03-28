import 'package:flutter/material.dart';

import '../../atoms/cards/cards.dart';
import '../../atoms/imagens/images_atoms.dart';

class Financial extends StatelessWidget {
  const Financial({Key? key}) : super(key: key);

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
              image: "assets/images/relatorio_vendas.png",
              width: size.width,
              height: size.height,
              label: "Relatório de Vendas",
              color: Colors.green.withOpacity(0.5),
              page: 2
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          cardSales(
              context: context,
              image: "assets/images/relatorio-de-compras.png",
              width: size.width,
              height: size.height,
              label: "Relatório de Compras",
              color: Colors.green.withOpacity(0.5),
              page: 3
          ),
        ],
      ),
    ]);
  }
}