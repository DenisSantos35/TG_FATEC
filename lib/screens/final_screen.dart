import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;
  const OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.6),
        title: Text("Pedido Realizado".toUpperCase(), ),
        centerTitle: true,
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
