import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/models/report_model.dart';
import 'package:intl/intl.dart';

import '../atoms/graficos/line_chart.dart';

class ReportController extends GetxController {
  ReportModel model = Get.put(ReportModel());

  final touchedLabel = ''.obs;
  final touchedValue = 0.0.obs;

  void updateTouchedData(ChartData point){
    touchedLabel.value = point.label;
    touchedValue.value = point.y;
  }

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
    double maxPrice = 0;
    double minPrice = 0;
    bool flag = true;
    Map<String,dynamic> maxSales = {};
    Map<String,dynamic> minSales = {};
    documents.docs.forEach((element) {
      if(element.data()["totalPrice"] > maxPrice){
        maxPrice = element.data()["totalPrice"];
        maxSales = element.data();
      }
      if(flag){
        minPrice = element.data()["totalPrice"];
        flag = false;
      }
      if(element.data()["totalPrice"] < minPrice){
        minPrice = element.data()["totalPrice"];
        minSales = element.data();
      }
      total += element["totalPrice"];
      if (element["paymentType"] == "A Prazo") {
        valueTotalPrazo += element["totalPrice"];
      } else if (element["paymentType"] == "A Vista") {
        valueTotalVista += element["totalPrice"];
      }
    });
    double median = (total / documents.docs.length);
    return {
      "valueTotalVista": valueTotalVista.toStringAsFixed(2).replaceAll('.', ','),
      "valueTotalPrazo": valueTotalPrazo.toStringAsFixed(2).replaceAll('.', ','),
      "total": total.toStringAsFixed(2).replaceAll('.', ','),
      "countVista": valueTotalVista,
      "countPrazo": valueTotalPrazo,
      "maxPrice": maxPrice,
      "maxSale": maxSales,
      "minPrice": minPrice,
      "minSale": minSales,
      "median": median
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
           totalPrazo += value["quantity"];
        });
      } else if (element["paymentType"] == "A Vista") {
        element["products"].forEach((value){
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

  Map<String, dynamic> salesMounth(QuerySnapshot<Map<String, dynamic>>? documents){

    Map<String, double> monthlySales = {};

    documents!.docs.forEach((element) {
      DateTime date = DateFormat('dd/MM/yyyy').parse(element.data()["date"]);
      String month = DateFormat('MMM/yyyy').format(date);

      if (monthlySales.containsKey(month)) {
        monthlySales[month] = monthlySales[month]! + element.data()["totalPrice"];
      } else {
        monthlySales[month] = element.data()["totalPrice"];
      }
    });

    // Converter o mapa para uma lista de pares chave-valor
    List<MapEntry<String, double>> sortedEntries = monthlySales.entries.toList();

    // Ordenar a lista com base nas chaves (strings de mês/ano convertidas para datas)
    sortedEntries.sort((a, b) => DateFormat('MMM/yyyy').parse(a.key).compareTo(DateFormat('MMM/yyyy').parse(b.key)));

    // Converter a lista ordenada novamente em um mapa
    Map<String, double> sortedMonthlySales = Map.fromEntries(sortedEntries);
    Logger().e("Sorted ${sortedMonthlySales}");

    return sortedMonthlySales;
  }


}
