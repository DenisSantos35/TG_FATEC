import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/controllers/edit_payment_controller.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/datas_class/report_sales_class.dart';
import 'package:tg_fatec/molecules/Tiles_molecules/detail._report_sales_molecules.dart';
import 'package:tg_fatec/molecules/edit_payment/edit_payment.dart';

import '../../screens/product_one_screen.dart';

class ReportSalesPrazoTile extends StatelessWidget {
  final ReportSalesClass product;

  ReportSalesPrazoTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "DATA: ${product!.date}",
                              style: const TextStyle(
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
                        const SizedBox(
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Text(
                      "NOME CLIENTE: ${product!.nameClient!.toUpperCase()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white),
                    ),
                    Text(
                      "PRODUTOS: ${product!.products!.map((e) => e["product"]["titulo"]).toString().replaceAll("(", "").replaceAll(")", "").toUpperCase()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.white),
                    ),
                    Text(
                      "PREÇO TOTAL: ${product!.totalPrice!.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "TIPO DE PAGAMENTO: ${product!.paymentType!.toUpperCase()}",
                        style: TextStyle(
                            color: ColorsApp.whiteColor(),
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorsApp.orangeColor(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.lazyPut(() => EditPaymentController());
                            Get.off(EditPayment(
                              product: product,
                              controller: EditPaymentController(),
                            ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "EDITAR PAGAMENTO",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(child: Icon(Icons.edit_note_sharp))
                            ],
                          ),
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
    );
  }
}
