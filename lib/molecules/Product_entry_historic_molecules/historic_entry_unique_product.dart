import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tg_fatec/datas_class/colors.dart';

class HistoricEntryUniqueProduct extends StatelessWidget {
  HistoricEntryUniqueProduct(
      {required this.historicProduct, required this.title});

  List historicProduct;
  String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "HISTÓRICO",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorsApp.blueColor(),
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
        bottomSheet: Stack(children: [
          Container(
              height: 520,
              decoration: BoxDecoration(
                  color: ColorsApp.blueColorOpacity2(),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32))),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Histórico de entrada de produtos".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 3,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 20),
                    ListView.separated(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: Get.height * 0.01,
                      ),
                      itemCount: historicProduct.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Data: ${historicProduct[index]["data"]}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Hora: ${historicProduct[index]["hora"]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ))
                                  ],
                                ),
                                const Divider(),
                                Row(children: [
                                  const Expanded(
                                    child: Text(
                                      "Quantidade:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${historicProduct[index]["quantidade"]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ]),
                                const Divider(),
                                Row(children: [
                                  const Expanded(
                                    child: Text(
                                      "Preço:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "R\$ ${historicProduct[index]["preco"]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ]),
                                const Divider(),
                                Row(children: [
                                  const Expanded(
                                    child: Text(
                                      "Valor Total:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "R\$ ${(historicProduct[index]["preco"] * historicProduct[index]["quantidade"]).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
        ]),
        // Tela roxa
        body: Container(
          alignment: Alignment.topCenter,
          child: Image.network(
            title,
            fit: BoxFit.cover,
            height: 260,
            width: Get.width,
          ),
        ),
      ),
    );
  }
}
