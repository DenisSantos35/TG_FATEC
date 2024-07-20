import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/controllers/data_clientes_controllers.dart';
import 'package:tg_fatec/datas_class/client.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/models/client_model.dart';
import 'package:tg_fatec/screens/final_create_product_screen.dart';
import '../../atoms/containers/containers_atoms.dart';
import '../../atoms/imagens/images_atoms.dart';
import '../../atoms/sizedbox/SizedBox_atoms.dart';

enum Page {visualizar, remover, editar}

class ClientesPagesMolecules extends StatefulWidget {
  ClientesPagesMolecules({Key? key, required this.title, required this.page})
      : super(key: key);

  String title;
  double page;

  @override
  State<ClientesPagesMolecules> createState() => _ClientesPagesMoleculesState();
}

class _ClientesPagesMoleculesState extends State<ClientesPagesMolecules> {
  DataClientesController controller = Get.put(DataClientesController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: [
                  imageDefault(
                      context: context,
                      image: "assets/images/tomate_desenho.png",
                      opacity: 0.2),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: showTextTitle(
                            label: "MENU ${widget.title}S",
                            size: 20,
                            color: ColorsApp.whiteColor()),
                      ),
                      Divider(
                        indent: 4,
                        endIndent: 4,
                        thickness: 3,
                        color: Colors.black,
                      ),
                      SizeHeight(height: size.width, multiplier: 0.07),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          containerMenuCliente(
                              icon: Icons.person_pin_outlined,
                              title: "Visualizar \nCliente",
                              page: Page.visualizar),
                          SizedBox(
                            width: 10,
                          ),
                          containerMenuCliente(
                              icon: Icons.edit_note,
                              title: "Editar \nCliente",
                              page: Page.editar),
                          SizedBox(
                            width: 10,
                          ),
                          containerMenuCliente(
                              icon: Icons.person_remove_alt_1_outlined,
                              title: "Remover \nCliente",
                              page: Page.remover),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget containerMenuCliente(
      {required IconData icon, required String title, required Page page}) {
    return InkWell(
      onTap: () {
        controller.acessPage(page: page);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        height: 145,
        width: 115,
        decoration: BoxDecoration(
          color: ColorsApp.blueColorOpacity(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
