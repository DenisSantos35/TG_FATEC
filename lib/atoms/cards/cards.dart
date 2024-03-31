import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/models/cart_model.dart';
import 'package:tg_fatec/models/client_model.dart';
import 'package:tg_fatec/screens/product_screen.dart';

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
    child: GestureDetector(
      onTap: () {
        _pages(page: page, title: title);
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 300),
        curve: Curves.easeInOut,
        child: Card(
          elevation: 20,
          shadowColor: Colors.black,
          color: color,
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            width: width * 0.85,
            height: height * 0.3,
            child: Column(
              children: [
                textTitle(
                    label: label,
                    size: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                SizedBox(
                  height: height * 0.03,
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

_pages({required int page, String? title}) {
  switch (page) {
    case 0:
      Get.to(ProductScreen(
        title: title!,
      ));
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          model.updatePrices();
          List<ClienteModel> cliente = model.clientes;
          ClienteModel? _selectedItem;

          return Center(
            child: DropdownButton<ClienteModel>(
              padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              value: _selectedItem,
              hint: Text(hint!),
              dropdownColor: Colors.green,
              elevation: 15,
              isExpanded: true,
              alignment: Alignment.centerLeft,
              iconSize: 40,
              onChanged: (newValue) {
                setState(() {
                  _selectedItem = newValue;
                  id = newValue?.id.toString() ?? "";
                  CartModel.of(context).setClients(id!);
                  hint = _selectedItem?.razao_social.toString();
                });
              },
              items: cliente
                  .map<DropdownMenuItem<ClienteModel>>((ClienteModel value) {
                return DropdownMenuItem<ClienteModel>(
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

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Desconto",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(),
              ],
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite o desconto"),
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
                Text(
                  "Resumo do Pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal"),
                    Text("R\$ ${price.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Desconto"),
                    Text("- R\$ ${discount.toStringAsFixed(2)}")
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
                          color: Colors.black,
                          fontSize: 16.0),
                    ),
                    Text("R\$ ${(price - discount).toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff10039F),
                            fontSize: 16.0))
                  ],
                ),
                SizedBox(
                  height: 35.0,
                ),
                OutlinedButton(
                  onPressed: buy,
                  child: Text(
                    "FINALIZAR PEDIDO",
                    style: TextStyle(color: Colors.white),
                  ),
                  style:
                      OutlinedButton.styleFrom(backgroundColor: Colors.green),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
