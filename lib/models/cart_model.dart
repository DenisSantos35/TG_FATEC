import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/datas_class/client.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';

import 'package:tg_fatec/models/payment_model.dart';
import 'package:tg_fatec/models/user_model.dart';

import '../datas_class/cart_product.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];
  List<Client> clientes = [];
  List<String> payment = [];
  bool isLoading = false;
  double discount = 0.0;
  String idClient = "";
  String nameClient = "";
  String paymentType = "";

  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCardItems();
      _loadClientes();
    }
    ;
  }

  static CartModel of(context) => ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    FirebaseFirestore.instance
        .collection("USUARIO")
        .doc(user.firebaseUser!.uid)
        .collection("CART")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.id;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance
        .collection("USUARIO")
        .doc(user.firebaseUser!.uid)
        .collection("CART")
        .doc(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    FirebaseFirestore.instance
        .collection("USUARIO")
        .doc(user.firebaseUser!.uid)
        .collection("CART")
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    FirebaseFirestore.instance
        .collection("USUARIO")
        .doc(user.firebaseUser!.uid)
        .collection("CART")
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void setClients(String idCliente, String nameCliente) {
    this.idClient = idCliente;
    this.nameClient = nameCliente;
    notifyListeners();
  }

  void setPayment(String payment) {
    this.paymentType = payment;
    notifyListeners();
  }

  void setDiscount(double discount) {
    this.discount = discount;
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct prod in products) {
      if (prod.productData != null) {
        price += prod.quantity * prod.productData!.price!;
      }
    }
    return price;
  }

  double getDiscount() {
    return this.discount;
  }

  void updatePrices() {
    _loadClientes();
    notifyListeners();
  }

  double getShipPrice() {
    //caso coloque frete
    return 9.99;
  }

  Future<String> finishOrder() async {
    DateTime date = DateTime.now();
    String dataFormatada = DateFormat('dd/MM/yyyy').format(date);
    String horaFormatada = DateFormat('HH:mm').format(date);
    if (products.length == 0) return "";
    if (idClient.isEmpty || idClient == null) {
      Get.snackbar("Dados incorretos", "Selecione o cliente para finalizar",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return "";
    }
    if (this.paymentType.isEmpty || this.paymentType == null) {
      Get.snackbar(
          "Dados incorretos", "Selecione a forma de pagamento para finalizar",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return "";
    }

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder =
        await FirebaseFirestore.instance.collection("VENDAS").add({
      "userId": user.firebaseUser!.uid,
      "date": dataFormatada,
      "hour": horaFormatada,
      "paymentType": paymentType,
      "nameClient": nameClient,
      "clientId": idClient,
      "products": products.map((cartPoduct) => cartPoduct.toMap()).toList(),
      "productsPrice": productsPrice,
      "discount": discount,
      "totalPrice": productsPrice - discount,
    });

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("USUARIO")
        .doc(user.firebaseUser!.uid)
        .collection("CART")
        .get();
    for (DocumentSnapshot doc in query.docs) {

      doc.reference.delete();
    }
    products.clear();
    this.discount = 0.0;
    idClient = "";
    isLoading = false;
    notifyListeners();
    return refOrder.id;
  }

  void _loadCardItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("USUARIO")
        .doc(user.firebaseUser!.uid)
        .collection("CART")
        .get();
    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }

  void _loadClientes() async {
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection("CLIENTES").get();
    PaymentModel payments = PaymentModel();
    clientes = query.docs.map((doc) => Client.fromDocument(doc)).toList();
    payment = payments.typePyment;
    notifyListeners();
  }
}
