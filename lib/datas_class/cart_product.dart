import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';

import '../models/client_model.dart';

class CartProduct{
  String? cid;
  String? category;
  String? pid;
  int quantity = 0;
  ProductDataClass? productData;
  ClienteModel? clienteModel;
  CartProduct();
  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.id;
    category = document["category"];
    pid = document["pid"];
    quantity = document["quantity"];
  }

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "product": productData?.toResumeMap(),
    };
  }
}