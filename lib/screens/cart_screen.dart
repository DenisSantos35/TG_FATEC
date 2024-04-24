import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/atoms/cards/cards.dart';
import 'package:tg_fatec/models/cart_model.dart';
import 'package:tg_fatec/models/user_model.dart';
import 'package:tg_fatec/screens/final_screen.dart';
import 'package:tg_fatec/screens/home_screen.dart';
import 'package:tg_fatec/tabs/home_tab.dart';
import '../atoms/buttons/buttons_atoms.dart';
import '../molecules/Tiles_molecules/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red.withOpacity(0.6),
        toolbarHeight: 90,
        leading: IconButton(
            onPressed: () {
              Get.offAll(HomeScreen());
            },
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 30,
            )),
        title: Text(
          "Meu Carrinho".toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 40.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int quantProduct = model.products.length;
                return Text(
                  "${quantProduct ?? 0} ${quantProduct == 1 ? "ITEM" : "ITENS"}",
                  style: const TextStyle(
                      color: Color(0xff10039F),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return const buttonReturnLogin();
          } else if (model.products == null || model.products.length == 0) {
            return Center(
              child: Text("Nenhum produto no carrinho!"),
            );
          } else {
            return ListView(children: [
              Column(
                  children: model.products.map((product) {
                return CartTile(product);
              }).toList()),
              ReturnButton(),
              SelectClient(),
              DiscountCard(),
              SelectPayment(),
              CardPrice(() async {
                String orderId = await model.finishOrder();
                if (orderId == "") return;
                if (orderId != null)
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OrderScreen(orderId)));
              }),
            ]);
          }
        },
      ),
    );
  }
}
