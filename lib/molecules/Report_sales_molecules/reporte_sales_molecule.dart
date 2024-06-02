import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/atoms/graficos/line_chart.dart';
import 'package:tg_fatec/atoms/graficos/piechart.dart';
import 'package:tg_fatec/controllers/reporte_controller.dart';

import '../../atoms/graficos/bar_graphic.dart';
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
  Map<String, dynamic> result = {};

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMM/yyyy').format(now);
    DateTime lastMonth = DateTime(now.year, now.month - 1, now.day);
    String lastMonthFormatted = DateFormat('MMM/yyyy').format(lastMonth);
    double lastMonthValue = 0.0;
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                height: Get.height * 0.04,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: const Center(
                  child: Text(
                    'DASHBORD DE VENDAS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              indent: 16,
              endIndent: 16,
              thickness: 3,
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection("VENDAS").get(),
                builder: (BuildContext context, snapshot) {
                  final chartDataList = chartData(result: result);
                  final labels = result.keys.toList()
                    ..sort((a, b) => DateFormat('MMM/yyyy')
                        .parse(a)
                        .compareTo(DateFormat('MMM/yyyy').parse(b)));
                  Logger().e(chartDataList);
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    result = controller.typeSales(snapshot.data);
                    Map<String, dynamic> resultProd =
                        controller.quantProdSale(snapshot.data);
                    List keyValues = controller.salesMounth(snapshot.data).keys.toList();
                    List values = controller.salesMounth(snapshot.data).values.toList();
                    String lastMonthInData = keyValues.last;
                    if (keyValues.contains(lastMonthFormatted)) {
                      // O mapa contém o valor do mês anterior
                      lastMonthValue = controller.salesMounth(snapshot.data)[lastMonthFormatted];
                    } else {
                      // O mapa não contém o valor do mês anterior, então retornamos 0.0
                      lastMonthValue = 0.0;
                    }
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: Get.height * 0.16,
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: Card(
                            color: ColorsApp.blueColorOpacity2(),
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.only(
                                  left: 32, right: 32, top: 16, bottom: 16),
                              child: Column(
                                children: [
                                  const Row(children: [
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
                                  const Divider(
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Row(children: [
                                    Expanded(
                                      child: Text(
                                        "${resultProd["totalProd"]} Caixas",
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "R\$ ${result["total"]}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ]),
                                  const Divider(
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
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(left: 16, right: 16),
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
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Tipo Venda:    Á Vista',
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Quant.',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${resultProd["totalVista"]} CX',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.green,
                                      indent: 8,
                                      endIndent: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Total',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'R\$ ${result["valueTotalVista"]}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
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
                              ),
                              Card(
                                color: ColorsApp.blueColorOpacity2(),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Tipo Venda:    Á Prazo',
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Quant.',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${resultProd["totalPrazo"]} CX',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.green,
                                      indent: 8,
                                      endIndent: 8,
                                      thickness: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Total',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'R\$ ${result["valueTotalPrazo"]}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
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
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          indent: 16,
                          endIndent: 16,
                        ),
                        Container(
                          height: Get.height * 0.35,
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: Card(
                            color: ColorsApp.blueColorOpacity2(),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  containerTitle(
                                      title:
                                          "Total Vendas:  R\$${result["total"]}"),
                                  const Divider(
                                    color: Colors.green,
                                    indent: 16,
                                    endIndent: 16,
                                    thickness: 3,
                                  ),
                                  PieChartGraphic(result: result)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LegendItem(
                                color: Color(0xff79EB3B),
                                text:
                                    "À vista: R\$ ${result["countVista"].toStringAsFixed(0)}"),
                            const SizedBox(width: 16),
                            LegendItem(
                                color: Colors.cyan,
                                text:
                                    "À Prazo: R\$ ${result["countPrazo"].toStringAsFixed(0)}"),
                          ],
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            //TODO: 'Bt p detalhes compra a vista e a prazo'
                            Logger().i('RELATÓRIO DETALHADO');
                          },
                          child: Container(
                            height: Get.height * 0.06,
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: const Card(
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
                        const Divider(
                          color: Colors.black,
                          indent: 16,
                          endIndent: 16,
                          thickness: 5,
                        ),
                        SizedBox(
                          height: 95,
                          child: GridView.count(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              crossAxisCount: 2,
                              // Adjust childAspectRatio based on your card design
                              childAspectRatio: 2,
                              // Example aspect ratio (adjust as needed)
                              children: [
                                cardMaxMinSales(
                                    result: result["maxPrice"]
                                        .toStringAsFixed(2)
                                        .replaceAll(".", ","),
                                    label: "Maior Venda:"),
                                cardMaxMinSales(
                                    result: result["minPrice"]
                                        .toStringAsFixed(2)
                                        .replaceAll(".", ","),
                                    label: "Menor Venda:"),
                              ]),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: cardMaxMinSales(
                                result: result["median"]
                                    .toStringAsFixed(2)
                                    .replaceAll(".", ","),
                                label: "Valo Médio de vendas")),
                        const Divider(
                          color: Colors.black,
                          indent: 16,
                          endIndent: 16,
                        ),
                        Container(
                          height: Get.height * 0.35,
                          padding: EdgeInsets.only(right: 16, left: 16),
                          child: Card(
                            color: ColorsApp.blueColorOpacity2(),
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 16, left: 16, right: 16),
                                      child: containerTitle(
                                          title: "Comparativo de Vendas")),
                                  const Divider(
                                    color: Colors.green,
                                    indent: 16,
                                    endIndent: 16,
                                    thickness: 3,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 16, left: 16, right: 16),
                                    child: BarChartSample3(
                                      result: result,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //TODO: 'Bt para relatorio de maior menor detalhado'

                            Logger().i(
                                'Bt para relatorio de maior menor detalhado');
                          },
                          child: Container(
                            height: Get.height * 0.06,
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: const Card(
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
                        const Divider(
                          color: Colors.black,
                          indent: 16,
                          endIndent: 16,
                          thickness: 5,
                        ),
                        SizedBox(
                          height: 95,
                          child: GridView.count(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            crossAxisCount: 2,
                            // Adjust childAspectRatio based on your card design
                            childAspectRatio: 2,
                            // Example aspect ratio (adjust as needed)
                            children: [
                              cardMaxMinSales(result: "${currentMonth == lastMonthInData? values.last.toStringAsFixed(2).replaceAll('.',','): '0,00'}", label: "Vendas Mês Atual"),
                              cardMaxMinSales(result: lastMonthValue.toStringAsFixed(2).replaceAll(".", ","), label: "Vendas Mês Atrerior"),
                            ],
                          ),
                        ),
                        Container(

                          height: Get.height * 0.5,
                          padding: const EdgeInsets.only(
                              right: 16, left: 16),
                          child: Card(
                              color: ColorsApp.blueColorOpacity2(),
                              child: MyLineChart(
                                  chartData(
                                    result: controller.salesMounth(snapshot.data),
                                  ),
                                  labels),
                              ),
                        ),
                        InkWell(
                          onTap: () {
                            //TODO: 'Botao para relatorio detalhes por periodo'
                            Logger()
                                .i('Botao para relatorio detalhes por periodo');
                            controller.salesMounth(snapshot.data);
                          },
                          child: Container(
                            height: Get.height * 0.06,
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: const Card(
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
                        const Divider(
                          color: Colors.black,
                          indent: 16,
                          endIndent: 16,
                          thickness: 5,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget containerTitle({required String title}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      width: Get.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget cardMaxMinSales({required String? result, required String label}) {
    return Card(
        color: ColorsApp.blueColorOpacity2(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const Divider(
              color: Colors.green,
              indent: 8,
              endIndent: 8,
            ),
            Text(
              "R\$ ${result ?? ""}",
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ));
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
