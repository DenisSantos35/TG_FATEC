import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tg_fatec/screens/cart_screen.dart';

import '../../auth/Login/login_page.dart';

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
