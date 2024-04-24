import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/datas_class/report_sales_class.dart';

import '../../screens/product_one_screen.dart';

class ReportSalesTile extends StatelessWidget {
  final ReportSalesClass? product;

  ReportSalesTile(this.product);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        //Get.to(ProductOneScreen(product));
      },
      child: Card(
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
                            child: Text(
                          "DATA: ${product!.date}",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        )),
                        Expanded(
                            child: Text(
                          "HORARIO: ${product!.hour}",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        )),
                      ],
                    ),
                    Text(
                      "NOME CLIENTE: ${product!.nameClient!.toUpperCase()}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "PRODUTOS: ${product!.products!.map((e) => e["product"]["titulo"]).toString().replaceAll("(", "").replaceAll(")", "").toUpperCase()}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "PREÇO TOTAL: ${product!.totalPrice!.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "TIPO DE PAGAMENTO: ${product!.paymentType!.toUpperCase()}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
