import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tg_fatec/atoms/imagens/images_atoms.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:url_launcher/url_launcher.dart';
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
        buildBodyBack(
            color1: ColorsApp.blueColor(),
            color2: ColorsApp.blueColorOpacity2()),
        CustomScrollView(
          slivers: [
            //sliverAppBar(),
            SliverToBoxAdapter(
              child: imageDefault(
                  context: context,
                  image: 'assets/images/tomate_desenho.png',
                  opacity: 1),
            ),
            SliverToBoxAdapter(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Acesse: ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.link,
                  color: Colors.white,
                ),
                TextButton(
                    onPressed: () {
                      openURL();
                    },
                    child: const Text(
                      "Conab.gov.br",
                      style: TextStyle(
                          color: Colors.orange,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.orange),
                    )),
              ],
            )),
          ],
        )
      ],
    );
  }

  void openURL() async {
    const url =
        'https://pentahoportaldeinformacoes.conab.gov.br/pentaho/api/repos/%3Ahome%3APROHORT%3AprecoDia.wcdf/generatedContent?userid=pentaho&password=password';
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar("Erro ao acessar o conteudo conab.gov.br",
          "Verifique sua internet e tente novamente!",
          duration: const Duration(seconds: 3),
          colorText: const Color(0xffffffff),
          backgroundColor: Colors.red);
    }
  }
}
