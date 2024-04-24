import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDataClass {
  String? id;
  String? titulo;
  String? description;
  double? price;
  String? image;
  String? unidadeMedida;
  double? quantidade;
  bool? status;
  String? categoria;
  DocumentReference<Object?>? references;

  ProductDataClass(
      {this.titulo,
      this.description,
      this.price,
      this.image,
      this.unidadeMedida,
      this.quantidade,
      this.status,
      this.categoria});

  ProductDataClass.edit({
    required this.description,
    required this.price,
    required this.image,
  });

  ProductDataClass.cancel({required this.id, required this.status});

  ProductDataClass.fromDocument(DocumentSnapshot snapshot) {
    references = snapshot.reference;
    id = snapshot.id;
    titulo = snapshot["titulo"];
    description = snapshot["description"];
    price = snapshot["preco"] + 0.0;
    image = snapshot["images"];
    unidadeMedida = snapshot["unidade_medida"];
    quantidade = snapshot["quantidade"] + 0.0;
  }

  ProductDataClass.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    titulo = map["titulo"];
    description = map["description"];
    price = map["preco"] + 0.0;
    image = map["images"];
    unidadeMedida = map["unidade_medida"];
    quantidade = map["quantidade"] + 0.0;
  }

  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "images": image,
      "preco": price,
      "quantidade": quantidade,
      "titulo": titulo,
      "unidade_medida": unidadeMedida,
      "status": status
    };
  }
  Map<String, dynamic> editProductMap(){
    return {
      "description": description,
      "images": image,
      "preco": price,
    };
  }

  Map<String, dynamic> canelProductMap() {
    return {"status": status};
  }

  Map<String, dynamic> toResumeMap() {
    return {"titulo": titulo, "description": description, "price": price};
  }
}
