import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/controllers/reporte_controller.dart';

import '../../atoms/texts/texts_atoms.dart';
import '../../datas_class/colors.dart';

class ReportSaleFinancialMolecules extends StatefulWidget {
  ReportSaleFinancialMolecules({Key? key}) : super(key: key);

  @override
  State<ReportSaleFinancialMolecules> createState() =>
      _ReportSaleFinancialMoleculesState();
}

class _ReportSaleFinancialMoleculesState
    extends State<ReportSaleFinancialMolecules> {
  ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    List<String> situacao = ["maior", 'menor', "media"];
    List<String> vendasAtual = ["mes atual", "mes anterior"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.blueColor(),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        toolbarHeight: 90,
        title: TextTitle(
            label: "RELATÓRIO DE VENDAS",
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
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Container(
                height: Get.height * 0.04,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.only(right: 16, left: 16),
                child: Center(
                  child: Text(
                    'DASHBORD DE VENDAS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
              thickness: 3,
            ),
            // FutureBuilder(
            //     future: FirebaseFirestore.instance
            //         .collection("HISTORICO_ENTRADA_PRODUTOS")
            //         .get(),
            //     builder: (BuildContext context, snapshot) {
            //       if (!snapshot.hasData) {
            //         return CircularProgressIndicator();
            //       } else {
            //         Map<String, dynamic> result =
            //             controller.totalStock(snapshot.data);
            //         return Container(
            //           alignment: Alignment.centerLeft,
            //           height: Get.height * 0.16,
            //           padding: EdgeInsets.only(right: 16, left: 16),
            //           child: Card(
            //             color: ColorsApp.blueColorOpacity2(),
            //             child: Container(
            //               width: Get.width,
            //               padding: EdgeInsets.only(
            //                   left: 32, right: 32, top: 16, bottom: 16),
            //               child: Column(
            //                 children: [
            //                   Container(
            //                     child: Row(children: [
            //                       Expanded(
            //                         child: Text(
            //                           "Quant. Produto ",
            //                           style: TextStyle(
            //                               color: Colors.white,
            //                               fontWeight: FontWeight.bold),
            //                           textAlign: TextAlign.left,
            //                         ),
            //                       ),
            //                       Expanded(
            //                         child: Text(
            //                           "Total",
            //                           style: TextStyle(
            //                               color: Colors.white,
            //                               fontWeight: FontWeight.bold),
            //                           textAlign: TextAlign.center,
            //                         ),
            //                       ),
            //                     ]),
            //                   ),
            //                   Divider(
            //                     color: Colors.green,
            //                   ),
            //                   SizedBox(
            //                     height: Get.height * 0.01,
            //                   ),
            //                   Container(
            //                     child: Row(children: [
            //                       Expanded(
            //                         child: Text(
            //                           "${result["total"]} Caixas",
            //                           style: TextStyle(color: Colors.white),
            //                           textAlign: TextAlign.left,
            //                         ),
            //                       ),
            //                       Expanded(
            //                         child: Text(
            //                           "R\$ ${result["valueTotal"]}",
            //                           style: TextStyle(color: Colors.white),
            //                           textAlign: TextAlign.center,
            //                         ),
            //                       ),
            //                     ]),
            //                   ),
            //                   Divider(
            //                     color: Colors.green,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       }
            //     }),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection("VENDAS").get(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  } else {
                    Map<String, dynamic> result =
                        controller.typeSales(snapshot.data);
                    Map<String, dynamic> resultProd =
                        controller.quantProdSale(snapshot.data);
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: Get.height * 0.16,
                          padding: EdgeInsets.only(right: 16, left: 16),
                          child: Card(
                            color: ColorsApp.blueColorOpacity2(),
                            child: Container(
                              width: Get.width,
                              padding: EdgeInsets.only(
                                  left: 32, right: 32, top: 16, bottom: 16),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          "Quant. Produtos ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Total R\$",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Divider(
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Container(
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          "${resultProd["totalProd"]} Caixas",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "R\$ ${result["total"]}",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Divider(
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 127,
                          child: GridView.count(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(left: 16, right: 16),
                            crossAxisCount: 2,
                            // Adjust childAspectRatio based on your card design
                            childAspectRatio: 1.5,
                            // Example aspect ratio (adjust as needed)
                            children: [
                              Card(
                                color: ColorsApp.blueColorOpacity2(),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: Text(
                                        'Tipo Venda:    Á Vista',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(
                                              'Quant.',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              '${resultProd["totalVista"]} CX',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                    Divider(
                                      color: Colors.green,
                                      indent: 8,
                                      endIndent: 8,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(
                                              'Total',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'R\$ ${result["valueTotalVista"]}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: ColorsApp.blueColorOpacity2(),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: Text(
                                        'Tipo Venda:    Á Prazo',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(
                                              'Quant.',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              '${resultProd["totalPrazo"]} CX',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                    Divider(
                                      color: Colors.green,
                                      indent: 8,
                                      endIndent: 8,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(
                                              'Total',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'R\$ ${result["valueTotalPrazo"]}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //TODO: 'Bt p detalhes compra a vista e a prazo'
                            Logger().i('RELATÓRIO DETALHADO');
                          },
                          child: Container(
                            height: Get.height * 0.06,
                            padding: EdgeInsets.only(right: 16, left: 16),
                            child: Card(
                              color: Colors.green,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          'RELATÓRIO DETALHADO',
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Icon(
                                        Icons.edit_document,
                                        color: Colors.white,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          indent: 16,
                          endIndent: 16,
                        ),
                        Container(
                          height: Get.height * 0.25,
                          padding: EdgeInsets.only(right: 16, left: 16),
                          child: Card(
                            color: ColorsApp.blueColorOpacity2(),
                            child: Padding(
                              child: Stack(
                                children: [
                                  Text("Total R\$:\n ${result["total"]}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  PieChart(
                                    PieChartData(sections: [
                                      PieChartSectionData(
                                          title:
                                              "Á vista: R\$ ${result["countVista"].toStringAsFixed(0)}",
                                          titleStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                          titlePositionPercentageOffset:
                                              BorderSide.strokeAlignOutside,
                                          value: result["countVista"],
                                          color: Colors.yellow),
                                      PieChartSectionData(
                                          title:
                                              "Á Prazo: R\$${result["countPrazo"].toStringAsFixed(0)}",
                                          titleStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          titlePositionPercentageOffset:
                                              BorderSide.strokeAlignOutside,
                                          value: result["countPrazo"],
                                          color: Colors.orange),
                                    ]),
                                    swapAnimationDuration:
                                        const Duration(milliseconds: 750),
                                    swapAnimationCurve: Easing.linear,
                                  ),
                                ],
                                alignment: Alignment.center,
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),

            Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(
              height: 130,
              child: GridView.count(
                padding: EdgeInsets.only(left: 16, right: 16),
                crossAxisCount: 3,
                // Adjust childAspectRatio based on your card design
                childAspectRatio: 1,
                // Example aspect ratio (adjust as needed)
                children: List.generate(
                    3,
                    (index) => Card(
                          color: ColorsApp.blueColorOpacity2(),
                          child: Center(
                            child: Text('${situacao[index]} \nVendas '),
                          ),
                        )),
              ),
            ),
            Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
            ),
            Container(
              height: Get.height * 0.25,
              padding: EdgeInsets.only(right: 16, left: 16),
              child: Card(
                color: ColorsApp.blueColorOpacity2(),
                child: Center(
                  child: Text(
                      'Grafico de colunas comparando maior venda menor venda e media'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                //TODO: 'Bt para relatorio de maior menor detalhado'
                Logger().i('Bt para relatorio de maior menor detalhado');
              },
              child: Container(
                height: Get.height * 0.06,
                padding: EdgeInsets.only(right: 16, left: 16),
                child: Card(
                  color: Colors.green,
                  child: Center(
                    child: Text('Bt para relatorio de maior menor detalhado'),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(
              height: 95,
              child: GridView.count(
                padding: EdgeInsets.only(left: 16, right: 16),
                crossAxisCount: 2,
                // Adjust childAspectRatio based on your card design
                childAspectRatio: 2,
                // Example aspect ratio (adjust as needed)
                children: List.generate(
                    2,
                    (index) => Card(
                          color: ColorsApp.blueColorOpacity2(),
                          child: Center(
                            child: Text('Vendas\n${vendasAtual[index]}  '),
                          ),
                        )),
              ),
            ),
            Container(
              height: Get.height * 0.25,
              padding: EdgeInsets.only(right: 16, left: 16),
              child: Card(
                color: ColorsApp.blueColorOpacity2(),
                child: Center(
                  child: Text('Grafico de barras vendas mes a mes'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                //TODO: 'Botao para relatorio detalhes por periodo'
                Logger().i('Botao para relatorio detalhes por periodo');
              },
              child: Container(
                height: Get.height * 0.06,
                padding: EdgeInsets.only(right: 16, left: 16),
                child: Card(
                  color: Colors.green,
                  child: Center(
                    child: Text('Botao para relatorio detalhes por periodo'),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
              thickness: 3,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
