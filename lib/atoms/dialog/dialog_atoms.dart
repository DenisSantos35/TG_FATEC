import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/models/product_model.dart';
import 'package:tg_fatec/molecules/Inactive_historic_molecules/inactive_historic_molecules.dart';

import '../../helper/list_snapshot_status.dart';
import '../../molecules/Inactivate_product_molecules/inactivate_product_molecule.dart';

class DialogDefault extends Model {
  static DialogDefault of(context) => ScopedModel.of<DialogDefault>(context);

  ListSnapshotStatus _data = ListSnapshotStatus();

  GetDialog(
      {required int page,
      required BuildContext context,
      required String title,
      required String subTitle,
      String? id,
      bool? status}) {
    return Get.defaultDialog(
        title: title,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        middleText: subTitle,
        backgroundColor: Colors.blue,
        middleTextStyle: TextStyle(color: Colors.white),
        textCancel: "Cancelar",
        textConfirm: "Confirmar",
        cancelTextColor: Colors.white,
        buttonColor: Colors.green,
        radius: 10,
        onConfirm: () async {
          ProductDataClass product =
              ProductDataClass.cancel(id: id, status: status);
          Map<String, dynamic> res = await ProductModel.of(context)
              .inactivateProduct(product: product.canelProductMap(), id: id!);

          List data = _data.data(res["data"], true);
          Get.back(result: data);
          Get.off(page == 1
              ? InactivateProductScreen(
                  title: "INATIVAR PRODUTOS",
                  product: data,
                )
              : InactiveHistoricProductScreen(
                  title: "HISTÓRICO PRODUTOS \nINATIVOS"));
          Get.back();
          if (res["res"]) {
            page == 1
                ? Get.showSnackbar(const GetSnackBar(
                    title: "Produto cancelado com sucesso",
                    message: "Para reativa-lo acesse o histórico de inativos!",
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ))
                : Get.showSnackbar(const GetSnackBar(
                    title: "Produto reativado com sucesso",
                    message: "Para inativalo acesse o inativar produtos!",
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ));
          } else {
            Get.snackbar("Erro ao inativar produto", "Tente novamente!",
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.red);
          }
        });
  }

}
