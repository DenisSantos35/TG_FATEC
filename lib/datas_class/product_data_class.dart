
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductDataClass{
  String? id;
  String? titulo;
  String? description;
  double? price;
  String? image;
  String? unidadeMedida;
  double? quantidade;
  bool? status;
  String? categoria;

  ProductDataClass.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    titulo = snapshot["titulo"];
    description = snapshot["description"];
    price = snapshot["preco"] + 0.0;
    image = snapshot["images"];
    unidadeMedida = snapshot["unidade_medida"];
    quantidade = snapshot["quantidade"] + 0.0;
  }

  Map<String, dynamic> toResumeMap(){
    return{
      "titulo": titulo,
      "description": description,
      "price": price
    };
  }


}