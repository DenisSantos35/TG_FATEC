import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tg_fatec/atoms/buttons/buttons_atoms.dart';
import 'package:tg_fatec/atoms/texts/texts_atoms.dart';
import 'package:tg_fatec/molecules/Client_pages_molecules/client_pages_molecules.dart';
import 'package:tg_fatec/molecules/Sales_page_molecules/sales_page_molecules.dart';

import '../molecules/Products_pages_molecules/products_pages_molecuels.dart';
import '../molecules/custom_drawer/customDowerMolecules.dart';
import '../tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      //animate to page jupin to page mudam as paginas
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        WillPopScope(
          onWillPop: ()async{
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red.withOpacity(0.9),
              iconTheme: const IconThemeData(color: Colors.white, size: 35),
              toolbarHeight: 90,
              title: TextTitle(
                  label: "LEGUMES DO CHICÃO",
                  size: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffffffff)),
              centerTitle: true,
            ),
            body: HomeTab(),
            drawer: CustomDrawer(_pageController),
            floatingActionButton: CartButton(),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.6),
            iconTheme: const IconThemeData(color: Colors.white, size: 35),
            toolbarHeight: 90,
            title: TextTitle(
                label: "PRODUTOS",
                size: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsPage(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red.withOpacity(0.9),
            iconTheme: const IconThemeData(color: Colors.white, size: 35),
            toolbarHeight: 90,
            title: TextTitle(
                label: "VENDAS",
                size: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CardsTemplate(
            colorButton: Colors.red.withOpacity(0.5),
            backgroundImage: "assets/images/tomate_desenho.png",
            imageCardOne: "assets/images/realizar_vendas.png",
            imageCardTwo: "assets/images/visualizar_vendas.png",
            labelOne: "Realizar Vendas",
            labelTwo: "Visualisar Vendas",
            firstPage: 0,
            lastPage: 1,
          ),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff267228).withOpacity(0.6),
            iconTheme: const IconThemeData(color: Colors.white, size: 35),
            toolbarHeight: 90,
            title: TextTitle(
                label: "FINANCEIRO",
                size: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CardsTemplate(
            colorButton: Colors.green.withOpacity(0.5),
            backgroundImage: "assets/images/tomate_desenho.png",
            imageCardOne: "assets/images/relatorio_vendas.png",
            imageCardTwo: "assets/images/relatorio-de-compras.png",
            labelOne: "Relatório de Vendas",
            labelTwo: "Relatório de Compras",
            firstPage: 2,
            lastPage: 3,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffAF9530),
            iconTheme: const IconThemeData(color: Colors.white, size: 35),
            toolbarHeight: 90,
            title: TextTitle(
                label: "CLIENTES",
                size: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: TemplateCadastroPagesMolecules(
            title: "CLIENTE",
            page: 0,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffAF9530),
            iconTheme: const IconThemeData(color: Colors.white, size: 35),
            toolbarHeight: 90,
            title: TextTitle(
                label: "FORNECEDORES",
                size: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: TemplateCadastroPagesMolecules(
            title: "FORNECEDOR",
            page: 1,
          ),
        ),
      ],
    );
  }
}
