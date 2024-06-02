import 'package:flutter/material.dart';
import 'package:tg_fatec/screens/home_screen.dart';
import 'package:tg_fatec/screens/product_screen.dart';
import 'package:get/get.dart';

import '../datas_class/colors.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;
  const OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        //atualizar página que vai ser redirecionada
        backgroundColor: ColorsApp.blueColor(),
        title: Text("Pedido Realizado".toUpperCase(), style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(onPressed: (){Get.offAll(HomeScreen());}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 80.0,),
              Text("Pedido realizado com sucesso!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              Text("Código do pedido:", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
              Text("$orderId", style: TextStyle(fontSize: 16.0,color: Colors.green),textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }
}
