
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class ClienteModel{
  String? id;
  String? razao_social;
  String? bairro;
  String? categoria;
  String? cep;
  String? cidade;
  String? cpfCnpj;
  String? email;
  String? nome;
  String? numero;
  String? rua;
  String? telefone;
  ClienteModel();

  ClienteModel.fromDocument(DocumentSnapshot document){
    id = document.id;
    razao_social = document["razao_social"];
    bairro = document["bairro"];
    categoria = document["categoria"];
    cep = document["cep"];
    cidade = document["cidade"];
    cpfCnpj = document["cpfCnpj"];
    email = document["email"];
    nome = document["nome"];
    numero = document["numero"];
    rua = document["rua"];
    telefone = document["telefone"];
  }

  Map<String, dynamic> dataClient(){
    return {
      "razao_social": razao_social,
      "telefone": telefone
    };
  }


}