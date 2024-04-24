import 'package:flutter/material.dart';
import 'package:tg_fatec/screens/home_screen.dart';
import 'package:tg_fatec/screens/product_screen.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;
  const OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //atualizar página que vai ser redirecionada
        backgroundColor: Colors.red.withOpacity(0.6),
        title: Text("Pedido Realizado".toUpperCase(), style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(onPressed: (){Get.offAll(HomeScreen());}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 80.0,),
            Text("Pedido realizado com sucesso!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
            Text("Código do pedido\n $orderId", style: TextStyle(fontSize: 16.0),)
          ],
        ),
      ),
    );
  }
}
