import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/atoms/cards/cards.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/models/cart_model.dart';
import 'package:tg_fatec/models/user_model.dart';
import 'package:tg_fatec/screens/final_screen.dart';
import 'package:tg_fatec/screens/home_screen.dart';
import '../atoms/buttons/buttons_atoms.dart';
import '../molecules/Tiles_molecules/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsApp.blueColor(),
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
                  style: TextStyle(
                      color: ColorsApp.orangeColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: ColorsApp.blueColor(),
        child: Container(
          alignment: Alignment.center,
          child:const Text(
            "Legumes do Chicão",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
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
              SizedBox(height: 16),
              ReturnButton(),
              SizedBox(height: 25),
              Divider(thickness: 3, color: Colors.black, indent: 16, endIndent: 16,),
              Padding(
                padding: EdgeInsets.only(left: 16, right:16),
                child: Container(
                  height: Get.height * 0.04,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "Finalizar pedido".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorsApp.whiteColor()),
                  ),
                ),
              ),
              Divider(thickness: 3, color: Colors.black, indent: 16, endIndent: 16,),
              SizedBox(height: 3),
              SelectClient(),
              DiscountCard(),
              SelectPayment(),
              Divider(thickness: 3, color: Colors.black, indent: 16, endIndent: 16,),
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
