
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/molecules/View_Client_molecules/view_client_datails.dart';
import '../../controllers/data_clientes_controllers.dart';
import '../../datas_class/client.dart';
import 'edit_client_details.dart';

class EditClientTile extends StatelessWidget {
  final Client data;
  final reference;

  const EditClientTile({super.key, required this.data, required this.reference});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.lazyPut(()=>DataClientesController() );
        Get.to(EditClientDetails(client: data,controller: DataClientesController(),reference: reference,));
      },
      child: Card(
        color: ColorsApp.blueColorOpacity2(),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: Text(
                          data.razao_social!.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, color: Colors.white),textAlign: TextAlign.center,
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      rowDataUser(title: "NOME: ", subtitle: data.nome??""),
                      rowDataUser(title: "TELEFONE: ", subtitle: data.telefone??""),
                      const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Text(
                        "E-MAIL:     ${data.email!.toLowerCase()??""}",
                        style: TextStyle(
                          color: ColorsApp.orangeColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 48, right: 48),
                        child: Center(
                          child: Container(
                              alignment: Alignment.center,
                              height: Get.height * 0.04,
                              decoration: BoxDecoration(
                                color: ColorsApp.orangeColor(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "EDITAR CLIENTE",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Icon(Icons.person_pin_outlined, color: Colors.black,),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowDataUser({required String title, required final subtitle}) {
    return Row(children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
      Expanded(
        child: Text(
          "${subtitle.toUpperCase()}",
          style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
          textAlign: TextAlign.end,
        ),
      ),
    ]);
  }
}
