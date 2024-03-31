import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tg_fatec/atoms/sizedbox/SizedBox_atoms.dart';
import 'package:tg_fatec/datas_class/cart_product.dart';
import 'package:tg_fatec/models/cart_model.dart';
import 'package:tg_fatec/models/user_model.dart';
import 'package:tg_fatec/screens/cart_screen.dart';

import '../auth/Login/login_page.dart';
import '../datas_class/product_data_class.dart';

class ProductOneScreen extends StatefulWidget {
  final ProductDataClass product;

  ProductOneScreen(this.product);

  @override
  State<ProductOneScreen> createState() => _ProductOneScreenState(product);
}

class _ProductOneScreenState extends State<ProductOneScreen> {
  final ProductDataClass product;

  _ProductOneScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.6),
        toolbarHeight: 80,
        title: Text(
          product.titulo!.toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Container(
                  child: Image.network(
                    product.image!,
                    fit: BoxFit.cover,
                  ),
                  height: size.height * 0.58,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        product.titulo!.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        "Estoque: ${product.quantidade!.toStringAsFixed(0)} ${product.unidadeMedida}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizeHeight(height: size.height, multiplier: 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Preço por ${product.unidadeMedida}: \n R\$ ${product.price!.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Color(0xff106910),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizeHeight(height: size.height, multiplier: 0.03),
                      OutlinedButton(
                          onPressed: () {
                            if(UserModel.of(context).isLoggedIn()){
                              //adicionar produto ao carrinho
                              CartProduct cartProduct = CartProduct();
                              cartProduct.quantity = 1;
                              cartProduct.pid = product.id;
                              cartProduct.category = "Legumes";
                              CartModel.of(context).addCartItem(cartProduct);

                              Get.to(CartScreen());

                            }else{
                              Get.to(Login());
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * 0.06,
                            width: size.width,
                            child: Text(UserModel.of(context).isLoggedIn()? "Adicionar ao Carrinho".toUpperCase(): "Realize o Login Para Continuar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ), style: OutlinedButton.styleFrom(backgroundColor: Colors.green),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
