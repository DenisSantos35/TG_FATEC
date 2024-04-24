import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/atoms/dialog/dialog_atoms.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/molecules/Edit_product_molecules/edit_product_molecules.dart';
import 'package:tg_fatec/screens/product_screen.dart';

import '../../auth/Login/login_page.dart';
import '../../datas_class/cart_product.dart';
import '../../models/cart_model.dart';
import '../../models/user_model.dart';
import '../../screens/cart_screen.dart';
import '../../screens/product_one_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductDataClass product;
  final bool? button;
  final String? label;
  final Color? color;
  final String? title;
  final String? subtitle;
  final int? page;

  ProductTile(
      this.type,
      this.product,
      {this.button,
      this.label,
      this.color,
      this.title,
      this.subtitle,
      this.page});
  ProductDataClass dataProduct = ProductDataClass();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        button != null ? null : addCart(context);
      },
      child: Card(
          shadowColor: Colors.black,
          child: type == 'grid'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product.titulo!.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "Preço ${product.unidadeMedida}:\n R\$ ${product.price!.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Color(0xff106910),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addCart(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15, bottom: 8),
                        alignment: Alignment.center,
                        height: Get.height * 0.06,
                        width: Get.width * 0.02,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          UserModel.of(context).isLoggedIn()
                              ? "Adicionar\n ao Carrinho".toUpperCase()
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
                      child: Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                        height: 250.0,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.titulo!.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "Estoque: ${product.quantidade!.toStringAsFixed(0)} ${product.unidadeMedida}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            button == null
                                ? Text(
                                    "Preço ${product.unidadeMedida}: \n R\$ ${product.price!.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Color(0xff106910),
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Preço ${product.unidadeMedida}: R\$ ${product.price!.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                            SizedBox(height: Get.height * .02),
                            button != null
                                ? Container(
                                    alignment: Alignment.center,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: color),
                                      onPressed: () {
                                        switch (page) {
                                          case 1:
                                          case 6:
                                            DialogDefault.of(context).GetDialog(
                                                page: page!,
                                                context: context,
                                                title: title!,
                                                subTitle: subtitle!,
                                                id: product.id,
                                                status:
                                                    page == 1 ? false : true);
                                            break;
                                          case 2:
                                            Logger().e(product.toMap());
                                            Get.to(EditProductMolecules(
                                              product: ProductDataClass.fromMap(
                                                  product.toMap(),),
                                              reference: product.references,
                                            ));
                                            break;
                                        }
                                      },
                                      child: Text(
                                        label!,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            button != null
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      addCart(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 15, right: 15, bottom: 8),
                                      alignment: Alignment.center,
                                      height: Get.height * 0.06,
                                      width: Get.width * 0.3,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        UserModel.of(context).isLoggedIn()
                                            ? "Adicionar\n ao Carrinho"
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
      cartProduct.quantity = 1;
      cartProduct.pid = product.id;
      cartProduct.category = "Legumes";

      CartModel.of(context).addCartItem(cartProduct);

      Get.to(CartScreen());
    } else {
      Get.to(Login());
    }
  }
}
