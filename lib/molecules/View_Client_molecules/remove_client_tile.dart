import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/molecules/View_Client_molecules/view_client_datails.dart';
import '../../atoms/dialog/dialog_atoms.dart';
import '../../controllers/data_clientes_controllers.dart';
import '../../datas_class/client.dart';

class RemoveClientTile extends StatelessWidget {
  final Client data;
  DataClientesController contoller;
  final reference;

  RemoveClientTile(
      {super.key,
      required this.data,
      required this.contoller,
      required this.reference});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    InkWell(
                      onTap: () async {
                        final res = await DialogDefault.of(context).GetDelete(
                            context: context,
                            title: "Deseja Exluir o contado de ${data.nome}?",
                            subTitle:
                                "Ao confirmar os dados serão apagados de nossas bases de dados.");
                        if (res) {
                          final result = await contoller.deleteClient(reference: reference);
                          Get.back();
                          if(result){

                            Get.showSnackbar(
                              GetSnackBar(
                                title: "${data.nome} DELETADO COM SUCESSO",
                                message: "Para obter os dados de ${data.nome} cadastre - o novamente.",
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: Duration(seconds: 5),
                              ),
                            );

                          }
                        } else {
                          Get.showSnackbar(
                            GetSnackBar(
                              title: "Operação Cancelada com sucesso!",
                              message: "Para deletar aperte em confirmar no dialogo!",
                              backgroundColor: ColorsApp.orangeColor(),
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }

                        //
                        // if(result){
                        //
                        // }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 48, right: 48),
                        child: Center(
                          child: Container(
                              alignment: Alignment.center,
                              height: Get.height * 0.04,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "EXCLUIR",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowDataUser({required String title, required final subtitle}) {
    return Row(children: [
      Expanded(
        child: Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
      Expanded(
        child: Text(
          "${subtitle.toUpperCase()}",
          style:
              const TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
          textAlign: TextAlign.end,
        ),
      ),
    ]);
  }
}
