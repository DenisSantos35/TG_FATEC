import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ReportSalesClass {
  String? id;
  String? clienteId;
  double? discount;
  List? products;
  double? productsPrice;
  double? totalPrice;
  String? userId;
  String? date;
  String? hour;
  String? nameClient;
  String? paymentType;
  String? image;
  String? reference;

  ReportSalesClass();

  ReportSalesClass.fromDocument(final snapshot) {
    reference = snapshot["reference"];
    clienteId = snapshot["clientId"];
    date = snapshot["date"];
    hour = snapshot["hour"];
    nameClient = snapshot["nameClient"];
    paymentType = snapshot["paymentType"];
    discount = snapshot["discount"];
    products = snapshot["products"];
    products = snapshot["products"];
    productsPrice = snapshot["productsPrice"];
    totalPrice = snapshot["totalPrice"];
    userId = snapshot["userId"];
    image = snapshot["images"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": reference,
      "clienteId": clienteId,
      "discount": discount,
      "products": products,
      "productsPrice": productsPrice,
      "totalPrice": totalPrice,
      "userId": userId,
      "date": date,
      "hour": hour,
      "nameClient": nameClient,
      "paymentType": paymentType,
      "image": image
    };
  }

  String totalParcial(Map<String, dynamic> product){
    double total = product["product"]["price"] * product["quantity"];
    return total.toStringAsFixed(2).replaceAll(".", ",");
  }

  String subTotal(List product) {
    Logger().i(product);
    double total = 0;
    product.forEach((element) {
      total += (element["product"]["price"] * element["quantity"]);    });
    return total.toStringAsFixed(2).replaceAll(".", ",");
  }

  String descount(ReportSalesClass desconto){
    String discount = desconto.discount!.toStringAsFixed(2).replaceAll(".", ",");
    return discount;
  }

  String typePayment(ReportSalesClass payment){
    String type = payment.paymentType!.toUpperCase();
    return type;
  }

  String total(List product, ReportSalesClass desconto){
    String subTot = subTotal(product);
    String desc = descount(desconto);
    double converSubTot = double.parse(subTot.replaceAll(",", "."));
    double convertDescount = double.parse(desc.replaceAll(",", "."));
    double valueTotal = converSubTot - convertDescount;
    String convertTotal = valueTotal.toStringAsFixed(2).replaceAll(".", ",");
    return convertTotal;
  }
}