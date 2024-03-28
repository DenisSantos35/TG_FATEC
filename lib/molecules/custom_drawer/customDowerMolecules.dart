import 'package:flutter/material.dart';
import 'package:tg_fatec/atoms/texts/texts_atoms.dart';
import 'package:tg_fatec/molecules/Tiles_molecules/tiles_molecules.dart';

import '../HomeTabMolecules/moleculesHomeTab.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          buildBodyBack(
              color1: const Color(0xffF81506), color2: const Color(0xffe89d98)),
          ListView(
            padding: const EdgeInsets.only(left: 15.0, top: 25.0),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                height: 240,
                child: Stack(
                  children: [
                    Positioned(
                        top: 4.0,
                        left: 0.0,
                        child: textTitle(
                            label: "Legumes do \nChicão",
                            size: 34.0,
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 20),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textTitle(label: "Seja Bem Vindo", size: 18.0, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
                          textTitle(label: "Dênis", size: 16.0, fontWeight: FontWeight.bold, color: Color(0xff0AE313))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(endIndent: 20,height: 5,),
              DrawerTile(icon: Icons.home_outlined, text: "Home",page: 0,controller: pageController),
              Divider(endIndent: 20,height: 5,),
              DrawerTile(icon: Icons.stacked_line_chart, text: "Produtos",page: 1,controller: pageController),
              DrawerTile(icon: Icons.point_of_sale_rounded, text: "Vendas",page: 2,controller: pageController),
              DrawerTile(icon: Icons.monetization_on_outlined, text: "Financeiro",page: 3,controller: pageController),
              Divider(endIndent: 20,height: 5,),
              DrawerTile(icon: Icons.person_pin_outlined, text: "Cadastrar Clientes",page: 4,controller: pageController),
              DrawerTile(icon: Icons.person_add_outlined, text: "Cadastrar Fornecedores",page: 5,controller: pageController),
            ],
          )
        ],
      ),
    );
  }
}
