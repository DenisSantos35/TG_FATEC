import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/atoms/dialog/dialog_atoms.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/molecules/Create_product_pages_molecules/edit_stock_product_molecules.dart';
import 'package:tg_fatec/molecules/Edit_product_molecules/edit_product_molecules.dart';
import 'package:tg_fatec/screens/product_screen.dart';

import '../../auth/Login/login_page.dart';
import '../../datas_class/cart_product.dart';
import '../../models/cart_model.dart';
import '../../models/user_model.dart';
import '../../screens/cart_screen.dart';
import '../../screens/product_one_screen.dart';

class ProductTile extends StatefulWidget {
  final String type;
  final ProductDataClass product;
  final bool? button;
  final String? label;
  final Color? color;
  final String? title;
  final String? subtitle;
  final int? page;

  ProductTile(this.type, this.product,
      {this.button,
      this.label,
      this.color,
      this.title,
      this.subtitle,
      this.page});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  ProductDataClass dataProduct = ProductDataClass();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
          shadowColor: Colors.black,
          child: widget.type == 'grid'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        widget.product.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              widget.product.titulo!.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Text(
                              widget.product.quantidade! <= 0
                                  ? "Adicione produto\npara realizar venda! "
                                  : "Preço ${widget.product.unidadeMedida}:\n R\$ ${widget.product.price!.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Color(0xff106910),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.product.quantidade! <= 0
                            ? Get.showSnackbar(GetSnackBar(
                                title: "Saldo insuficiente!",
                                message:
                                    "Produto não pode ser adicionado ao carrinho.",
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.red,
                              ))
                            : addCart(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15, bottom: 8),
                        alignment: Alignment.center,
                        height: Get.height * 0.06,
                        width: Get.width * 0.02,
                        decoration: BoxDecoration(
                            color: widget.product.quantidade! <= 0
                                ? Colors.red
                                : Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          UserModel.of(context).isLoggedIn()
                              ? widget.product.quantidade! <= 0
                                  ? "Saldo\ninsuficiente".toUpperCase()
                                  : "Adicionar\n ao Carrinho".toUpperCase()
                              : "Realize o Login Para Continuar",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.network(
                          widget.product.image!,
                          fit: BoxFit.cover,
                          height: 110.0,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.green,
                      height: 110,
                      width: 3,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.titulo!.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 14),
                            ),
                            Text(
                              "Estoque: ${widget.product.quantidade!.toStringAsFixed(0)} ${widget.product.unidadeMedida}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                            widget.button == null
                                ? Text(
                                    widget.product.quantidade! <= 0
                                        ? "Adicione produto\npara realizar venda! "
                                        : "Preço ${widget.product.unidadeMedida}: R\$ ${widget.product.price!.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Color(0xff106910),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                : Text(
                                    "Preço ${widget.product.unidadeMedida}: R\$ ${widget.product.price!.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                  ),
                            Divider(
                              color: Colors.green,
                              thickness: 2,
                            ),
                            widget.button != null
                                ? Container(
                                    width: 150,
                                    height: 25,
                                    alignment: Alignment.center,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: widget.color,
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      onPressed: () {
                                        switch (widget.page) {
                                          case 1:
                                          case 6:
                                            DialogDefault.of(context).GetDialog(
                                                page: widget.page!,
                                                context: context,
                                                title: widget.title!,
                                                subTitle: widget.subtitle!,
                                                id: widget.product.id,
                                                status: widget.page == 1
                                                    ? false
                                                    : true);
                                            break;
                                          case 2:
                                            Get.to(EditProductMolecules(
                                              product: ProductDataClass.fromMap(
                                                widget.product.toMap(),
                                              ),
                                              reference:
                                                  widget.product.references,
                                            ));
                                            break;
                                          case 3:
                                            Get.to(EditStockProductMolecules(
                                              product: ProductDataClass.fromMap(
                                                  widget.product.toMap()),
                                              reference:
                                                  widget.product.references,
                                            ));
                                        }
                                      },
                                      child: Text(
                                        widget.label!,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            widget.button != null
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      Logger().i(context);
                                      widget.product.quantidade! <= 0
                                          ? null
                                          : addCart(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 2, right: 2, bottom: 8),
                                      alignment: Alignment.center,
                                      height: Get.height * 0.04,
                                      width: Get.width * 0.5,
                                      decoration: BoxDecoration(
                                          color: widget.product.quantidade! <= 0
                                              ? Colors.red
                                              : Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        UserModel.of(context).isLoggedIn()
                                            ? widget.product.quantidade! <= 0
                                                ? "Saldo insuficiente"
                                                    .toUpperCase()
                                                : "Adicionar ao Carrinho"
                                                    .toUpperCase()
                                            : "Realize o Login Para Continuar",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }

  void addCart(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      //adicionar produto ao carrinho
      CartProduct cartProduct = CartProduct();
      ProductDataClass dataProduct = ProductDataClass();
      cartProduct.estoque = widget.product.quantidade;
      cartProduct.quantity = 1;
      cartProduct.pid = widget.product.id;
      cartProduct.category = "Legumes";
      dataProduct.titulo = widget.product.titulo;
      dataProduct.quantidade = widget.product.quantidade;
      dataProduct.description = widget.product.description;
      dataProduct.price = widget.product.price;
      dataProduct.image = widget.product.image;
      Logger().e(dataProduct.toResumeMap());

      CartModel.of(context).addCartItem(cartProduct, dataProduct);

      Get.to(CartScreen());
    } else {
      Get.to(Login());
    }
  }
}
