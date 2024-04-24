import 'package:cloud_firestore/cloud_firestore.dart';

class ReportSalesClass{
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


  ReportSalesClass();

  ReportSalesClass.fromDocument(final snapshot){
    clienteId = snapshot["clienteId"];
    date = snapshot["date"];
    hour = snapshot["hour"];
    nameClient = snapshot["nameClient"];
    paymentType = snapshot["paymentType"];
    discount = snapshot["discount"];
    products = snapshot["products"];
    productsPrice = snapshot["productsPrice"];
    totalPrice = snapshot["totalPrice"];
    userId = snapshot["userId"];
  }



}