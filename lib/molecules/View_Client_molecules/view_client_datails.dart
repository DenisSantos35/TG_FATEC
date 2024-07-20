import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../atoms/imagens/images_atoms.dart';
import '../../atoms/texts/texts_atoms.dart';
import '../../datas_class/client.dart';
import '../../datas_class/colors.dart';

class ViewClientDetails extends StatelessWidget {
  final Client client;

  const ViewClientDetails({Key? key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.blueColor(),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        toolbarHeight: 90,
        title: TextTitle(
            label: "${client.razao_social!.toUpperCase()}",
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
          child: const Text(
            "Legumes do Chicão",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            imageDefault(
                context: context,
                image: "assets/images/tomate_desenho.png",
                opacity: 0.1),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 40),
              child: Column(
                children: [
                  titleContainer(title: "DADOS DO CLIENTE", icon: Icons.person_pin),
                  divider(),
                  dataUserContainer(
                      title: "Razão Social: ", subtitle: client.razao_social),
                  dataUserContainer(title: "Nome: ", subtitle: client.nome),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  titleContainer(title: "CONTATOS", icon: Icons.contact_mail_outlined),
                  divider(),
                  dataUserContainer(
                      title: "Telefone: ", subtitle: client.telefone),
                  dataUserContainer(title: "E-mail: ", subtitle: client.email),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  titleContainer(title: "ENDEREÇO", icon: Icons.cottage_outlined),
                  divider(),
                  dataUserContainer(title: "Rua/Av: ", subtitle: client.rua),
                  dataUserContainer(title: "Bairro: ", subtitle: client.bairro),
                  dataUserContainer(
                      title: "Complemento: ", subtitle: client.complemento),
                  dataUserContainer(title: "Numero: ", subtitle: client.numero),
                  dataUserContainer(title: "Cidade: ", subtitle: client.cidade),
                  dataUserContainer(title: "CEP: ", subtitle: client.cep),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
      color: Colors.black,
      thickness: 2,
    );
  }

  Widget titleContainer({required String title, required IconData icon}) {
    return Container(
      height: Get.height * 0.04,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white,),
          SizedBox(width: Get.width * 0.03,),
          Text(
            title,
            style: TextStyle(
                color: ColorsApp.whiteColor(),
                fontWeight: FontWeight.w900,
                fontSize: 14,),textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget dataUserContainer({required String title, required final subtitle}) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Container(
        width: Get.width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  textAlign: TextAlign.start,
                )),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${subtitle.toUpperCase()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16),
                  textAlign: TextAlign.start,
                ))
          ],
        ),
      ),
    );
  }
}
