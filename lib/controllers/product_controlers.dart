import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

}