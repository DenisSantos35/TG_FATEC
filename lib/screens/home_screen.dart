import 'package:flutter/material.dart';
import 'package:tg_fatec/atoms/texts/texts_atoms.dart';
import 'package:tg_fatec/molecules/Client_pages_molecules/client_pages_molecules.dart';
import 'package:tg_fatec/molecules/Financila_pages_molecules/financial_pages_molecules.dart';
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
      controller: _pageController, //animate to page jupin to page mudam as paginas
      physics: const  NeverScrollableScrollPhysics(),
      children:  <Widget>[
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red.withOpacity(0.9),
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 35
            ),
            toolbarHeight: 90,
            title: textTitle(label: "LEGUMES DO CHICÃO", size: 22, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
            centerTitle: true,
          ),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.6),
            iconTheme: IconThemeData(
                color: Colors.white,
                size: 35
            ),
            toolbarHeight: 90,
            title: textTitle(label: "PRODUTOS", size: 22, fontWeight: FontWeight.bold, color: Colors.white),
            centerTitle: true,
          ),
          drawer:CustomDrawer(_pageController),
          body: ProductsPage(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red.withOpacity(0.9),
            iconTheme: IconThemeData(
                color: Colors.white,
                size: 35
            ),
            toolbarHeight: 90,
            title: textTitle(label: "VENDAS", size: 22, fontWeight: FontWeight.bold, color: Colors.white),
            centerTitle: true,
          ),
          drawer:CustomDrawer(_pageController),
          body: Sales(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff267228).withOpacity(0.6),
            iconTheme: IconThemeData(
                color: Colors.white,
                size: 35
            ),
            toolbarHeight: 90,
            title: textTitle(label: "FINANCEIRO", size: 22, fontWeight: FontWeight.bold, color: Colors.white),
            centerTitle: true,
          ),
          drawer:CustomDrawer(_pageController),
          body: Financial(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffAF9530),
            iconTheme: IconThemeData(
                color: Colors.white,
                size: 35
            ),
            toolbarHeight: 90,
            title: textTitle(label: "CLIENTES", size: 22, fontWeight: FontWeight.bold, color: Colors.white),
            centerTitle: true,
          ),
          drawer:CustomDrawer(_pageController),
          body: ClientPagesMolecules(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffAF9530),
            iconTheme: IconThemeData(
                color: Colors.white,
                size: 35
            ),
            toolbarHeight: 90,
            title: textTitle(label: "FORNECEDORES", size: 22, fontWeight: FontWeight.bold, color: Colors.white),
            centerTitle: true,
          ),
          drawer:CustomDrawer(_pageController),
          body: Container(),
        ),

      ],
    );
  }
}
