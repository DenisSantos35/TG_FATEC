import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../atoms/cards/cards.dart';
import '../../atoms/containers/containers_atoms.dart';
import '../../controllers/product_controlers.dart';

class DetailsHistoricoCost extends StatelessWidget {
  DetailsHistoricoCost(
      {required this.title,
      required this.historics,
      required this.dataProduct});

  String title;
  List historics;
  Map<String, dynamic> dataProduct;
  ProductController controller = Get.put(ProductController());



  @override
  Widget build(BuildContext context) {
    double priceMedian = controller.calculatePiceMedian(historicProduct: historics);
    return Scaffold(
      appBar: AppBar(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(20, 20))),
        automaticallyImplyLeading: true,
        toolbarHeight: Get.height * 0.10,
        title: (Text(
          title,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        )),
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.6),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black.withOpacity(0.6),
        height: Get.height * 0.10,
        child: Container(
          alignment: Alignment.center,
          child: Text("Legumes do Chicão", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      dataProduct["images"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Container(
                  height: 120,
                  width: 5,
                  color: Colors.green,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Container(
                  width: Get.width * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      descripiontProduct(
                          title: "Produto:",
                          subTitle: dataProduct["titulo"].toUpperCase()),
                      descripiontProduct(
                          title: "Estoque: ",
                          subTitle:
                              dataProduct["quantidade"].toStringAsFixed(0)),
                      descripiontProduct(
                          title: "Unid. Med.:",
                          subTitle: dataProduct["unidade_medida"]),
                      descripiontProduct(
                          title: "Preco: ",
                          subTitle:
                              "R\$ ${dataProduct["preco"].toStringAsFixed(2).replaceAll(".", ", ")}"),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              height: Get.height * 0.03,
              indent: 8,
              endIndent: 8,
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(height: Get.height * 0.05,),
            containerTitles(title: "RELATÓRIO DETALHADO CUSTO MÉDIO", width: 0.85, height: 0.03),
            Divider(
              height: Get.height * 0.03,
              indent: 8,
              endIndent: 8,
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(height: Get.height * 0.01,),
            containerRelatorio(title: "Preço Atual:", subtitle: "R\$ ${dataProduct["preco"].toStringAsFixed(2).replaceAll(".", ", ")}"),
            const Divider(indent: 30, endIndent: 30,),
            containerRelatorio(title: "Estoque:", subtitle: "${dataProduct["quantidade"].toStringAsFixed(0)} Caixas"),
            const Divider(indent: 30, endIndent: 30, thickness: 2, color: Colors.black,),
            containerRelatorio(title: "Valor Total:", subtitle: "R\$ ${(dataProduct["quantidade"] * dataProduct["preco"]).toStringAsFixed(2).replaceAll(".", ", ")}"),
            const Divider(indent: 30, endIndent: 30, thickness: 2,color: Colors.black,),
            SizedBox(height: Get.height * 0.02,),
            containerTitles(title: "CUSTO MÉDIO", width: 0.65, height: 0.03),
            SizedBox(height: Get.height * 0.01,),
            const Divider(indent: 30, endIndent: 30, thickness: 2,color: Colors.black,),
            containerRelatorio(title: "Preço Médio:", subtitle: "R\$ ${priceMedian==0.0?dataProduct["preco"].toStringAsFixed(2).replaceAll(".", ", ") : priceMedian.toStringAsFixed(2).replaceAll('.', ',')}"),
            const Divider(indent: 30, endIndent: 30,),
            containerRelatorio(title: "Estoque:", subtitle: "${dataProduct["quantidade"].toStringAsFixed(0)} Caixas"),
            const Divider(indent: 30, endIndent: 30, thickness: 2, color: Colors.black,),
            containerRelatorio(title: "Valor Total:", subtitle: "R\$ ${priceMedian == 0.0 ? (dataProduct["quantidade"] * dataProduct["preco"]).toStringAsFixed(2).replaceAll(".", ", ") :(dataProduct["quantidade"] * priceMedian).toStringAsFixed(2).replaceAll(".", ", ")}"),
            const Divider(indent: 30, endIndent: 30, thickness: 2,color: Colors.black,),
            SizedBox(height: Get.height * 0.05,),
            Divider(
              height: Get.height * 0.03,
              indent: 8,
              endIndent: 8,
              thickness: 2,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }


}
