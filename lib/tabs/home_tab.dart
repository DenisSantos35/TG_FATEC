import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tg_fatec/atoms/imagens/images_atoms.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import '../molecules/HomeTabMolecules/moleculesHomeTab.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  var Firestore =
      FirebaseFirestore.instance.collection("HOME").orderBy("pos").get();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildBodyBack(color1: ColorsApp.blueColor(), color2: ColorsApp.blueColorOpacity2()),
        CustomScrollView(
          slivers: [
            //sliverAppBar(),
            SliverToBoxAdapter(
              child: imageDefault(
                  context: context, image: 'assets/images/tomate_desenho.png', opacity: 1),
            ),
          ],
        )
      ],
    );
  }
}
