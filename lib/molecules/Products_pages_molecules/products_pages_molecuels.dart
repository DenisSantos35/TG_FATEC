import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tg_fatec/atoms/containers/containers_atoms.dart';
import 'package:tg_fatec/atoms/imagens/images_atoms.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Stack(
          children: [
        imageDefault(
            context: context,
            image: "assets/images/tomate_desenho.png",
            opacity: 0.3),
        ListView(
          children: [
            cardProducts(
                context: context,
                width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(0.6),
                image: "assets/images/cadastro.png",
                label: "Cadastrar Produtos", page: 0),
            cardProducts(
                context: context,
                width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(0.6),
                image: "assets/images/editar.png",
                label: "Editar Produto", page: 1),
            cardProducts(
                context: context,
                width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(0.6),
                image: "assets/images/excluir-pacote.png",
                label: "Inativar Produto", page: 2),
            cardProducts(
                context: context,
                width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(0.6),
                image: "assets/images/entrada_estoque.png",
                label: "Entrada em estoque", page: 3),
            cardProducts(
                context: context,
                width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(0.6),
                image: "assets/images/custo_medio.png",
                label: "Custo Médio Produtos", page: 4),
            cardProducts(
                context: context,
                width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(0.6),
                image: "assets/images/historico_entrada.png",
                label: "Histórico Entrada de Produtos", page: 5),
            cardProducts(
                context: context,
                width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(0.6),
                image: "assets/images/historico_inativo.png",
                label: "Histórico de Produtos Inativos", page: 6),
          ],
        ),
      ]),
    );
  }
}
