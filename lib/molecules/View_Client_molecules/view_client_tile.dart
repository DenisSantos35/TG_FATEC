import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/molecules/View_Client_molecules/view_client_datails.dart';
import '../../datas_class/client.dart';

class ViewClientTile extends StatelessWidget {
  final Client data;

  const ViewClientTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(ViewClientDetails(client: data,)),
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
                              fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      rowDataUser(title: "NOME: ", subtitle: data.nome),
                      rowDataUser(title: "TELEFONE: ", subtitle: data.telefone),
                      const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Text(
                        "E-MAIL:     ${data.email}",
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
                        padding: EdgeInsets.only(left: 32, right: 32),
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
                                    flex: 3,
                                    child: Text(
                                      "VISUALIZAR CLIENTE",
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
