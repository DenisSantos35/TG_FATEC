import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/datas_class/report_sales_class.dart';
import 'package:tg_fatec/molecules/Tiles_molecules/detail._report_sales_molecules.dart';

import '../../screens/product_one_screen.dart';

class ReportSalesTile extends StatelessWidget {
  final ReportSalesClass? product;

  ReportSalesTile(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DetailsReportSales(
          product: product,
        ));
      },
      child: Card(
        color: ColorsApp.blueColorOpacity2(),
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                "DATA: ${product!.date}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "HORARIO: ${product!.hour}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black, thickness: 2,),
                      Text(
                        "NOME CLIENTE: ${product!.nameClient!.toUpperCase()}",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "PRODUTOS: ${product!.products!.map((e) => e["product"]["titulo"]).toString().replaceAll("(", "").replaceAll(")", "").toUpperCase()}",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "PREÇO TOTAL: ${product!.totalPrice!.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                      Divider(color: Colors.black, thickness: 2,),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "TIPO DE PAGAMENTO: ${product!.paymentType!.toUpperCase()}",
                          style: TextStyle(
                              color: ColorsApp.whiteColor(), fontWeight: FontWeight.w900),
                        ),
                      ),
                      Divider(color: Colors.black, thickness: 2,),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 180,
                          decoration: BoxDecoration(
                            color: ColorsApp.orangeColor(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "VER RELATÓRIO +",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
