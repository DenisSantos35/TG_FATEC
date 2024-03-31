import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/screens/product_screen.dart';

import '../../screens/product_one_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductDataClass product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(ProductOneScreen(product));
      },
      child: Card(
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
                            Text(product.titulo!.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w900),),
                            Text("Preço ${product.unidadeMedida}:\n R\$ ${product.price!.toStringAsFixed(2)}", style: TextStyle(color: Color(
                                0xff106910),  fontWeight: FontWeight.bold),),
                          ],
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
                      Text(product.titulo!.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w900),),
                      Text("Estoque: ${product.quantidade!.toStringAsFixed(0)} ${product.unidadeMedida}", style: TextStyle(fontWeight: FontWeight.w500),),
                      Text("Preço ${product.unidadeMedida}: \n R\$ ${product.price!.toStringAsFixed(2)}", style: TextStyle(color: Color(
                          0xff106910), fontWeight: FontWeight.bold),),
                      Text("Preco Total: \n R\$ ${(product.price! * product.quantidade!).toStringAsFixed(2)}", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),

            ],
          )),
    );
  }
}
