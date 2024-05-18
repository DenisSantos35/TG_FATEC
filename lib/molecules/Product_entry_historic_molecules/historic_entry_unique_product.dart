import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HistoricEntryUniqueProduct extends StatelessWidget {
  HistoricEntryUniqueProduct(
      {required this.historicProduct, required this.title});

  List historicProduct;
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HISTÓRICO",
          style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black.withOpacity(0.6),
      ),
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: 230,
            child: Image.network(
              title,
              fit: BoxFit.fitWidth,
              height: 230.0,
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Container(
            child: Text(
              "Histórico de entrada de produtos".toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
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
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                              child: Text(
                            "Hora: ${historicProduct[index]["hora"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ))
                        ],
                      ),
                      const Divider(),
                      Row(children: [
                        Expanded(
                          child: Text(
                            "Quantidade:",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${historicProduct[index]["quantidade"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 14),
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
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "R\$ ${historicProduct[index]["preco"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 14),
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
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "R\$ ${(historicProduct[index]["preco"] * historicProduct[index]["quantidade"]).toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
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
    ));
  }
}
