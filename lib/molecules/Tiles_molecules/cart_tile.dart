import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tg_fatec/datas_class/cart_product.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  const CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              cartProduct.productData!.image!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cartProduct.productData!.titulo!.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),),
                  Text("Estoque: ${cartProduct.productData!.quantidade!.toStringAsFixed(0)} Caixas", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17.0),),
                  Text("Preço Caixa: R\$ ${cartProduct.productData!.price!}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.green),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: cartProduct.quantity > 1? (){
                            CartModel.of(context).decProduct(cartProduct);
                          } : null,
                          icon: Icon(Icons.remove), color: Colors.red,),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                          onPressed: (){
                            CartModel.of(context).incProduct(cartProduct);
                          },
                          icon: Icon(Icons.add), color: Color(0xff10039F)),
                      TextButton(onPressed: (){
                        CartModel.of(context).removeCartItem(cartProduct);
                      }, child: Text("Remover"),)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("PRODUTOS")
                  .doc(cartProduct.pid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct.productData =
                      ProductDataClass.fromDocument(snapshot.data!);
                  return _buildContent();
                } else {
                  return Container(
                    height: 70.0,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : _buildContent(),
    );
  }
}
