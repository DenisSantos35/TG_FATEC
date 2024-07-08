import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tg_fatec/controllers/reporte_controller.dart';

import '../../atoms/containers/containers_atoms.dart';
import '../../atoms/texts/texts_atoms.dart';
import '../../datas_class/colors.dart';

class ProductPurchaseReport extends StatelessWidget {
  ProductPurchaseReport({Key? key}) : super(key: key);

  Map<String, dynamic> result = {};
  Map<String, dynamic> statusSales = {};
  Map<String, dynamic> resultSales = {};

  @override
  Widget build(BuildContext context) {
    ReportController controller = Get.put(ReportController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.blueColor(),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        toolbarHeight: 90,
        title: TextTitle(
            label: "RELATÓRIO DE\n COMPRAS",
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
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            TitleReport(title: 'RELATÓRIO DE PRODUTOS COMPRADOS'),
            const Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
              thickness: 3,
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("HISTORICO_ENTRADA_PRODUTOS")
                    .get(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    result = controller.generalPurchasingReport(snapshot.data);
                    return Column(
                      children: [
                        TotalReport(
                            quantProduct: result["quantProduct"],
                            totalProduc: result["totalValue"]),
                      ],
                    );
                  }
                }),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection("PRODUTOS").get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    statusSales = controller.status(snapshot: snapshot.data);
                    return SizedBox(
                      height: 190,
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        crossAxisCount: 2,
                        // Adjust childAspectRatio based on your card design
                        childAspectRatio: 1.2,
                        // Example aspect ratio (adjust as needed)
                        children: [
                          cardReport(
                            title:
                                "Maior Estoque: \n ${statusSales["max"]["titulo"]}",
                            subtitle:
                                'Quant.:     ${statusSales["max"]["quantidade"].toStringAsFixed(0)} CX',
                            message:
                                "Peço:      R\$ ${statusSales["max"]["preco"].toStringAsFixed(2)} ",
                            content:
                                'Total: R\$ ${controller.calculateEstoque(estoque: statusSales["max"]["quantidade"], preco: statusSales["max"]["preco"])}',
                          ),
                          cardReport(
                            title:
                                "Menor Estoque: \n ${statusSales["min"]["titulo"]}",
                            subtitle:
                                'Quant.:     ${statusSales["min"]["quantidade"].toStringAsFixed(0)} CX',
                            message:
                                "Peço:      R\$ ${statusSales["min"]["preco"].toStringAsFixed(2)} ",
                            content:
                                'Total: R\$ ${controller.calculateEstoque(estoque: statusSales["min"]["quantidade"], preco: statusSales["min"]["preco"])}',
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
            TitleReport(title: 'RELATÓRIO GERAL'),
            const Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
              thickness: 3,
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection("VENDAS").get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    resultSales = controller.getSales(snapshot: snapshot.data);
                    return ReportDetails(
                        titleComp: "Quant. Compras",
                        titleSale: "Quant. Vendas",
                        subtitle: "Total R\$",
                        totalProductComp: "${result["totalValue"]}",
                        quantProductComp: "${result["quantProduct"]}",
                        totalProductSales: "${resultSales["totalValue"]}",
                        quantProductSales: "${resultSales["quantProduct"]}",
                      subtitleDiscount: "(-) R\$ ${resultSales["discount"]}",
                      titleDiscount: "Descontos:",
                      titleSubTotal: "Sub-Total: ",
                      subTotal: "R\$ ${resultSales["subTotal"]}"
                    );
                  } else {
                    return SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget cardReport(
      {required String title,
      required String subtitle,
      required String message,
      required String content}) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              subtitle,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              message,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ),
          const Divider(
            color: Colors.green,
            indent: 8,
            endIndent: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    content,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
