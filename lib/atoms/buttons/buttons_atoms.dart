import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tg_fatec/screens/cart_screen.dart';
import 'package:tg_fatec/screens/product_screen.dart';

import '../../auth/Login/login_page.dart';
import '../../models/user_model.dart';


class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to(CartScreen());
      },
      child: Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
      backgroundColor: Colors.green,
    );
  }
}

class ReturnButton extends StatelessWidget {
  const ReturnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70),
      child: OutlinedButton(
        onPressed: () {
          Get.off(ProductScreen(title: "PRODUTOS"));

        },
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
        ),
        child:  Container(
          alignment: Alignment.center,
          height: Get.height * 0.03,
          width: Get.width,
          child: Text(
            UserModel.of(context).isLoggedIn()
                ? "SELECIONAR PRODUTOS".toUpperCase()
                : "Realize o Login Para Continuar",
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}


class buttonReturnLogin extends StatelessWidget {
  const buttonReturnLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.remove_shopping_cart,
            size: 80.0,
            color: Colors.red,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "Faca o login para adicionar produtos!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.0,
          ),
          OutlinedButton(
            onPressed: () => Get.offAll(Login()),
            child: Text(
              "Entrar",
              style: TextStyle(fontSize: 18.0),
            ),
            style: OutlinedButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }
}
