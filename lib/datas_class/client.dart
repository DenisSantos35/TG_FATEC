import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

class Client extends Model {
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
  String? complemento;

  Client();

  Client.data(
      {required this.nome,
      required this.razao_social,
      required this.cpfCnpj,
      required this.email,
      required this.telefone,
      required this.cep,
      required this.rua,
      required this.bairro,
      required this.complemento,
      required this.numero,
      required this.cidade,
      required this.categoria});

  Client.fromDocument(DocumentSnapshot document) {
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
    complemento = document["complemento"];
  }

  Map<String, dynamic> dataClient() {
    return {"razao_social": razao_social, "telefone": telefone};
  }

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "razao_social": razao_social,
      "cpfCnpj": cpfCnpj,
      "email": email,
      "telefone": telefone,
      "cep": cep,
      "rua": rua,
      "bairro": bairro,
      "complemento": complemento,
      "numero": numero,
      "cidade": cidade,
      "categoria": categoria
    };
  }
}
