import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/models/product_model.dart';

class ProductController extends GetxController{

  int calculateStock(String newValue, String oldValue ){
    int intNewValue = int.parse(newValue);
    int intOldValue = int.parse(oldValue);
    int total = intNewValue + intOldValue;
    return total;
  }

  String replace(String text){
    return text.replaceAll(".", ",").replaceAll(",", ".");
  }

  String dateTime({required String typeData}){
    DateTime date = DateTime.now();
    DateFormat dateFormat = DateFormat(typeData);
    String newDate = dateFormat.format(date);
    return newDate;
  }

  Future selectPrice({required BuildContext context, required String id}){
    final res = ProductModel.of(context).selectHistoricMedia(id: id);
    return res;
  }

  double calculatePiceMedian({required List historicProduct}){
    if(historicProduct.isEmpty){
      return 0.0;
    }
    double sum = 0.0;
    double median = 0.0;
    historicProduct.forEach((element) {
      sum += element["preco"];
    });
    median = sum / historicProduct.length;

    return median;
  }

}