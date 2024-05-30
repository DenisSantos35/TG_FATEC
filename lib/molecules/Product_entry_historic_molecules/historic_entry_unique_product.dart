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
      title: Text("HISTÓRICO",
        style: TextStyle(color: Colors.white),),
      backgroundColor: ColorsApp.blueColor(),
        ),
          bottomNavigationBar: BottomAppBar(
            height: 50,
          color: ColorsApp.blueColor(),
          child: Container(
            alignment: Alignment.center,
            child:const Text(
              "Legumes do Chicão",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        bottomSheet: Stack(
          children: [
            Container(
              height: 520,
              decoration: BoxDecoration(
                  color:ColorsApp.blueColorOpacity2(),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32))),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      width: Get.width * 0.9,
                      child: Text(
                        "Histórico de entrada de produtos".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Divider(color: Colors.black, thickness: 3, indent: 16, endIndent: 16, ),
                    SizedBox(height: 20),
                    ListView.separated(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: Get.height * 0.01,
                      ),
                      itemCount: historicProduct.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Data: ${historicProduct[index]["data"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                        child: Text(
                                          "Hora: ${historicProduct[index]["hora"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ))
                                  ],
                                ),
                                const Divider(),
                                Row(children: [
                                  Expanded(
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ]),
                                const Divider(),
                                Row(children: [
                                  Expanded(
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ]),
                                const Divider(),
                                Row(children: [
                                  Expanded(
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
                                      style: TextStyle(
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
              )),]
        ),
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
