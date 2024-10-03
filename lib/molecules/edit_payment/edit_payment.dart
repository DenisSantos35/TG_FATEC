import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/atoms/imagens/images_atoms.dart';
import 'package:tg_fatec/atoms/texts/texts_atoms.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/datas_class/report_sales_class.dart';

import '../../atoms/cards/cards.dart';
import '../../atoms/dialog/dialog_atoms.dart';
import '../../controllers/edit_payment_controller.dart';
import '../../controllers/reporte_controller.dart';
import '../../models/cart_model.dart';
import '../../screens/UpdateStateSales.dart';

class EditPayment extends StatelessWidget {
  ReportSalesClass product;
  final EditPaymentController controller;

  EditPayment({required this.product, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.blueColor(),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        toolbarHeight: 90,
        title: TextTitle(
            label: "LEGUMES DO CHICÃO",
            size: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff)),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorsApp.blueColor(),
        height: 50,
        child: Container(
          alignment: Alignment.center,
          child:
              Text("Legumes do Chicão", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              Container(
                height: Get.height * 0.04,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  "EDITAR STATUS DO PAGAMENTO",
                  style: TextStyle(
                      color: ColorsApp.whiteColor(),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: 32,
                endIndent: 32,
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: EditTypePayment(
                  type: product.typePayment(product),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              InkWell(
                onTap: () async {
                  final res = await DialogDefault.of(context).GetUpdate(
                      context: context,
                      title: "Deseja alterar o status de pagamento?",
                      subTitle:
                          "Ao confirmar os dados serão a ação não podera ser desfeita.");
                  if (res) {
                    await controller.editPaymentType(
                        data: CartModel.of(context).paymentType,
                        reference: product.reference ?? "");
                    Get.showSnackbar(
                      GetSnackBar(
                        snackPosition: SnackPosition.BOTTOM,
                        title: "Status de pagamento alterado com sucesso!",
                        message: "Realize novas alterações",
                        backgroundColor: ColorsApp.blueColor(),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    Get.lazyPut(()=> ReportController());
                    Get.off(UpdateStateSales(controller: ReportController(),));



                  } else {
                    Get.showSnackbar(GetSnackBar(
                        snackPosition: SnackPosition.BOTTOM,
                        title: "Erro ao salvar dados",
                        message: "Tente novamente.",
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3)));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.save_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "SALVAR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: 32,
                endIndent: 32,
                thickness: 2,
              ),
              Container(
                height: Get.height * 0.04,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  "RELATÓRIO DE VENDAS",
                  style: TextStyle(
                      color: ColorsApp.whiteColor(),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Text(
                  "CLIENTE: ${product!.nameClient!.toUpperCase()} ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: 32,
                endIndent: 32,
                thickness: 2,
              ),
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                color: Colors.black,
                child: Container(
                  width: Get.width,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "PRODUTOS",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "QUANT. VENDA",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: product!.toMap()["products"].length,
                  itemBuilder: (BuildContext context, int index) {
                    int lastValue = product!.toMap()["products"].length;

                    return Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                product!.products![index]["product"]["titulo"]
                                    .toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                              padding: EdgeInsets.only(left: 60),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          Expanded(
                              child: Text(
                            "${product!.products![index]["quantity"]} Caixas",
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                      Row(children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "Preço Cx: R\$ ${product!.products![index]["product"]["price"].toStringAsFixed(2).replaceAll(".", ",")} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                  fontSize: 10),
                              textAlign: TextAlign.left,
                            ),
                            padding: EdgeInsets.only(left: 60),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              "Total: R\$ ${product?.totalParcial(product!.products![index])} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  fontSize: 10),
                              textAlign: TextAlign.right,
                            ),
                            padding: EdgeInsets.only(left: 60),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ]),
                      lastValue - 1 == index
                          ? SizedBox(
                              height: 20,
                            )
                          : Container(
                              child: Divider(
                                color: Colors.black.withOpacity(0.3),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 40),
                            ),
                    ]);
                  }),
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                color: Colors.black,
                child: Container(
                  width: Get.width,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "RESUMO DA VENDA",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: 32,
                endIndent: 32,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        "Data: ${product!.date} ",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                      ),
                      padding: EdgeInsets.only(left: 60),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Hora: ${product!.hour}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                margin: EdgeInsets.symmetric(horizontal: 40),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        "Pagamento: ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                      padding: EdgeInsets.only(left: 60),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${product!.typePayment(product!)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                margin: EdgeInsets.symmetric(horizontal: 40),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        "Sub-Total: ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                      padding: EdgeInsets.only(left: 60),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "R\$ ${product!.subTotal(product!.products!)}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                margin: EdgeInsets.symmetric(horizontal: 40),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        "Desconto: ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                      padding: EdgeInsets.only(left: 60),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    "- R\$ ${product!.descount(product!)}",
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                margin: EdgeInsets.symmetric(horizontal: 40),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        "Total: ",
                        style: TextStyle(fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                      ),
                      padding: EdgeInsets.only(left: 60),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    "R\$ ${product!.total(product!.products!, product!)}",
                    style: TextStyle(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                margin: EdgeInsets.symmetric(horizontal: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
