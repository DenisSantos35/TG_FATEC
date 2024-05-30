import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/models/report_model.dart';

class ReportController extends GetxController {
  ReportModel model = Get.put(ReportModel());

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  Map<String, dynamic> totalStock(
      QuerySnapshot<Map<String, dynamic>>? documents) {
    double total = 0.0;
    double valueTotal = 0.0;
    if (documents == null) return {"total": "0", "valueTotal": "0,00"};
    documents.docs.forEach((element) {
      //Logger().i(element.data());
      total += element["quantidade"];
      valueTotal += (element["quantidade"] * element["preco"]);
    });
    return {
      "total": total.toStringAsFixed(0),
      "valueTotal": valueTotal.toStringAsFixed(2).replaceAll(".", ",")
    };
  }

  Map<String, dynamic> typeSales(QuerySnapshot<Map<String, dynamic>>? documents) {
    double valueTotalVista = 0.0;
    double valueTotalPrazo = 0.0;
    double total = 0.0;
    if (documents == null)
      return {
        "valueTotalVista": "0,00",
        "valueTotalPrazo": "0,00",
        "total": "0,00"
      };
    documents.docs.forEach((element) {
      total += element["totalPrice"];
      if (element["paymentType"] == "A Prazo") {
        valueTotalPrazo += element["totalPrice"];
      } else if (element["paymentType"] == "A Vista") {
        valueTotalVista += element["totalPrice"];
      }
    });
    return {
      "valueTotalVista": valueTotalVista.toStringAsFixed(2).replaceAll('.', ','),
      "valueTotalPrazo": valueTotalPrazo.toStringAsFixed(2).replaceAll('.', ','),
      "total": total.toStringAsFixed(2).replaceAll('.', ','),
      "countVista": valueTotalVista,
      "countPrazo": valueTotalPrazo
    };
  }

  Map<String, dynamic> quantProdSale(QuerySnapshot<Map<String, dynamic>>? documents){
    double totalVista = 0.0;
    double totalPrazo = 0.0;
    double totalProd = 0.0;
    if (documents == null)
      return {
        "totalVista": "0,00",
        "totalPrazo": "0,00"
      };
    documents.docs.forEach((element) {
      if (element["paymentType"] == "A Prazo") {
        element["products"].forEach((value){
          //Logger().e(value["quantity"]);
           totalPrazo += value["quantity"];
        });
      } else if (element["paymentType"] == "A Vista") {
        element["products"].forEach((value){
          //Logger().i(value["quantity"]);
          totalVista += value["quantity"];
        });
      }
    });
    totalProd = (totalVista + totalPrazo);

    return {
      "totalVista": totalVista.toStringAsFixed(0),
      "totalPrazo": totalPrazo.toStringAsFixed(0),
      "totalProd": totalProd.toStringAsFixed(0)
    };
  }
}
