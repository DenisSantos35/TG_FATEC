import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gif/gif.dart';
import 'package:tg_fatec/atoms/buttons/buttons_atoms.dart';
import 'package:tg_fatec/atoms/texts/texts_atoms.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/molecules/Client_pages_molecules/client_pages_molecules.dart';
import 'package:tg_fatec/molecules/Sales_page_molecules/sales_page_molecules.dart';

import '../molecules/Client_pages_molecules/data_clientes_moleculres.dart';
import '../molecules/Products_pages_molecules/products_pages_molecuels.dart';
import '../molecules/custom_drawer/customDowerMolecules.dart';
import '../tabs/home_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();



  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _pageController,
      //animate to page jupin to page mudam as paginas
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        PopScope(
         canPop: false,
          onPopInvoked: (didPop) => false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorsApp.blueColor(),
              iconTheme: const IconThemeData(color: Colors.white, size: 35),
              toolbarHeight: 90,
              title: TextTitle(
                  label: "LEGUMES DO CHICÃO",
                  size: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffffffff)),
              centerTitle: true,
            ),
            bottomNavigationBar: BottomAppBar(
              color: ColorsApp.blueColor(),
              height: 50,
              child: Container(
                alignment: Alignment.center,
                child: Text("Legumes do Chicão", style: TextStyle(color: Colors.white)),
              ),
            ),
            body: HomeTab(),
            drawer: CustomDrawer(_pageController),
            floatingActionButton: CartButton(),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsApp.blueColor(),
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
            backgroundColor: ColorsApp.blueColor(),
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
            colorButton: ColorsApp.blueColorOpacity2(),
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
            backgroundColor: ColorsApp.blueColor(),
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
            colorButton: ColorsApp.blueColorOpacity(),
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
            backgroundColor: ColorsApp.blueColor(),
            iconTheme: const IconThemeData(color: Colors.white, size: 35),
            toolbarHeight: 90,
            title: TextTitle(
                label: "CLIENTES",
                size: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomAppBar(
            height: 50,
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
          drawer: CustomDrawer(_pageController),
          body: TemplateCadastroPagesMolecules(
            title: "CLIENTE",
            page: 0,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsApp.blueColor(),
            iconTheme: const IconThemeData(color: Colors.white, size: 35),
            toolbarHeight: 90,
            title: TextTitle(
                label: "CLIENTES",
                size: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomAppBar(
            height: 50,
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
          drawer: CustomDrawer(_pageController),
          body: ClientesPagesMolecules(
            title: "CLIENTE",
            page: 1,
          ),
        ),
      ],
    );
  }
}
