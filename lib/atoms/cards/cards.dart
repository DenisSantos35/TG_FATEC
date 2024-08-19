import 'dart:ui';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/datas_class/client.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/models/cart_model.dart';
import 'package:tg_fatec/molecules/Report_sales_molecules/Product_purchase_report_molecules.dart';
import 'package:tg_fatec/molecules/Report_sales_molecules/reporte_sales_molecule.dart';
import 'package:tg_fatec/screens/UpdateStateSales.dart';
import 'package:tg_fatec/screens/product_screen.dart';
import 'package:tg_fatec/screens/sales_report_screen.dart';

import '../../controllers/reporte_controller.dart';
import '../imagens/images_atoms.dart';
import '../texts/texts_atoms.dart';

Widget cardSales(
    {required BuildContext context,
    required String image,
    required double width,
    required double height,
    required String label,
    required Color color,
    required int page,
    String? title}) {
  bool toque = false;
  return Center(
    child: InkWell(
      onTap: () {
        _pages(page: page, title: title);
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 300),
        curve: Curves.easeInOut,
        child: Card(
          elevation: 3,
          shadowColor: Colors.black,
          color: color,
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),

            child: Column(
              children: [
                TextTitle(
                    label: label,
                    size: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                SizedBox(
                  height: height * 0.01,
                ),
                imageCardSale(context: context, image: image, opacity: 1),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget viewCardSales(
    {required BuildContext context,
      required String image,
      required double width,
      required double height,
      required String label,
      required Color color,
      required int page,
      String? title}) {
  bool toque = false;
  return Center(
    child: InkWell(
      onTap: () {
        _pages(page: page, title: title);
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 300),
        curve: Curves.easeInOut,
        child: Card(
          elevation: 3,
          shadowColor: Colors.black,
          color: color,
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),

            child: Column(
              children: [
                TextTitle(
                    label: label,
                    size: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                SizedBox(
                  height: height * 0.01,
                ),
                viewImageCardSale(context: context, image: image, opacity: 1),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// card personalizado do relatorio de média de custo
Widget descripiontProduct({required String title, required String subTitle}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      SizedBox(
        width: Get.width * 0.03,
      ),
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            subTitle,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
          ),
        ),
      )
    ],
  );
}

Widget descripiontRelatorio(
    {required String title,
    required String subTitle,
    required TextAlign text}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      SizedBox(
        width: Get.width * 0.03,
      ),
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            subTitle,
            textAlign: TextAlign.left,
          ),
        ),
      )
    ],
  );
}

_pages({required int page, String? title}) {
  switch (page) {
    case 0:
      Get.to(ProductScreen(
        title: title!,
      ));
      break;
    case 1:
      Get.to(SalesReportScreen(
        title: title!,
      ));
      break;
    case 2:
      Get.to(ReportSaleFinancialMolecules());
      break;
    case 3:
      Get.to(ProductPurchaseReport());
      break;
    case 4:
      Get.lazyPut(()=> ReportController());
      Get.to(UpdateStateSales(controller: ReportController(),));
      Logger().i("criar a atualização de vendas");
      break;
  }
}

class SelectClient extends StatefulWidget {
  SelectClient({Key? key}) : super(key: key);

  @override
  State<SelectClient> createState() => _SelectClientState();
}

class _SelectClientState extends State<SelectClient> {
  String? hint = "Selecione um cliente";
  String? id;
  String? nameClient;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          model.updatePrices();
          List<Client> client = model.clientes;
          Client? _selectedItem;

          return Center(
            child: DropdownButton<Client>(
              iconEnabledColor: ColorsApp.whiteColor(),
              padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              value: _selectedItem,
              hint: Text(
                hint!,
                style: TextStyle(color: Colors.white),
              ),
              dropdownColor: ColorsApp.blueColor(),
              elevation: 15,
              isExpanded: true,
              alignment: Alignment.centerLeft,
              iconSize: 40,
              onChanged: (newValue) {
                setState(() {
                  _selectedItem = newValue;
                  id = newValue?.id.toString() ?? "";
                  nameClient = newValue!.razao_social.toString() ?? "";
                  CartModel.of(context).setClients(id!, nameClient!);
                  hint = _selectedItem?.razao_social.toString();
                });
              },
              items: client.map<DropdownMenuItem<Client>>((Client value) {
                return DropdownMenuItem<Client>(
                    value: value,
                    child: Text(
                      "Razão Social: ${value.razao_social.toString()}",
                      style: TextStyle(color: Colors.white),
                    ));
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class EditTypePayment extends StatefulWidget {
  final String type;
  EditTypePayment({required this.type}) ;

  @override
  State<EditTypePayment> createState() => _EditTypePaymentState(type: type);
}

class _EditTypePaymentState extends State<EditTypePayment> {


  String type;
  _EditTypePaymentState({required this.type});
  late String? hint = type;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          model.updatePrices();
          List<String> pyment = model.payment;
          String? _selectedItem;

          return Center(
            child: DropdownButton<String>(
              iconEnabledColor: ColorsApp.whiteColor(),
              padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              value: _selectedItem,
              hint: Text(
                hint!,
                style: TextStyle(color: ColorsApp.whiteColor()),
              ),
              dropdownColor: ColorsApp.blueColor(),
              elevation: 15,
              isExpanded: true,
              alignment: Alignment.centerLeft,
              iconSize: 40,
              onChanged: (newValue) {
                setState(() {
                  _selectedItem = newValue;
                  CartModel.of(context).setPayment(_selectedItem!.toString());
                  hint = _selectedItem?.toString();
                });
              },
              items: pyment.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      "${value.toString()}",
                      style: TextStyle(color: Colors.white),
                    ));
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}



class SelectPayment extends StatefulWidget {
  SelectPayment({Key? key}) : super(key: key);

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  String? hint = "Selecione Forma de Pagamento";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          model.updatePrices();
          List<String> pyment = model.payment;
          String? _selectedItem;

          return Center(
            child: DropdownButton<String>(
              iconEnabledColor: ColorsApp.whiteColor(),
              padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              value: _selectedItem,
              hint: Text(
                hint!,
                style: TextStyle(color: ColorsApp.whiteColor()),
              ),
              dropdownColor: ColorsApp.blueColor(),
              elevation: 15,
              isExpanded: true,
              alignment: Alignment.centerLeft,
              iconSize: 40,
              onChanged: (newValue) {
                setState(() {
                  _selectedItem = newValue;
                  CartModel.of(context).setPayment(_selectedItem!.toString());
                  hint = _selectedItem?.toString();
                });
              },
              items: pyment.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      "${value.toString()}",
                      style: TextStyle(color: Colors.white),
                    ));
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorsApp.whiteColor()),
        ),
        leading: Icon(
          Icons.card_giftcard,
          color: ColorsApp.orangeColor(),
        ),
        trailing: Icon(
          Icons.add,
          color: ColorsApp.whiteColor(),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(color: ColorsApp.whiteColor()),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(),
              ],
              decoration: InputDecoration(
                fillColor: ColorsApp.whiteColor(),
                labelStyle: TextStyle(color: ColorsApp.whiteColor()),
                hintStyle: TextStyle(color: ColorsApp.whiteColor()),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: "Digite o desconto",
              ),
              onFieldSubmitted: (text) {
                if (text.isNotEmpty) {
                  try {
                    String value =
                        text.replaceAll('.', "").replaceAll(",", ".");
                    double discount = double.parse(value);
                    if (discount > CartModel.of(context).getProductsPrice()) {
                      Get.snackbar("Disconto inválido",
                          "Valor do disconto maior que valor da compra",
                          colorText: Color(0xffffffff),
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM);
                      CartModel.of(context).setDiscount(0.0);
                    } else {
                      CartModel.of(context).setDiscount(discount);
                      Get.snackbar("Desconto atribuido com sucesso",
                          "Quantidade de desconto na compra de\n R\$: ${text}",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: Duration(seconds: 2));
                    }
                  } catch (err) {
                    CartModel.of(context).setDiscount(0.0);
                    Get.snackbar("Desconto inválido",
                        "Verifique o valor do disconto e tente novamente",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: Duration(seconds: 2));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardPrice extends StatelessWidget {
  final VoidCallback buy;

  CardPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double ship = model.getShipPrice();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: Get.height * 0.04,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "Resumo do Pedido".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorsApp.whiteColor()),
                  ),
                ),
                Divider(
                  thickness: 3,
                  color: Colors.black,
                  indent: 8,
                  endIndent: 8,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal", style: TextStyle(color: ColorsApp.whiteColor()),),
                    Text("R\$ ${price.toStringAsFixed(2)}", style: TextStyle(color: ColorsApp.whiteColor()),)
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Desconto", style: TextStyle(color: ColorsApp.whiteColor()),),
                    Text("- R\$ ${discount.toStringAsFixed(2)}", style: TextStyle(color: ColorsApp.whiteColor()),)
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorsApp.whiteColor(),
                          fontSize: 16.0),
                    ),
                    Text("R\$ ${(price - discount).toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorsApp.orangeColor(),
                            fontSize: 16.0))
                  ],
                ),
                Divider(
                  thickness: 3,
                  color: Colors.black,
                  indent: 8,
                  endIndent: 8,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: OutlinedButton(
                    onPressed: buy,
                    child: Text(
                      "FINALIZAR PEDIDO",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffF5AA02),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
