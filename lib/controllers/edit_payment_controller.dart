
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class EditPaymentController extends GetxController{

  final firebase = FirebaseFirestore.instance;

  Future<bool> editPaymentType({required String data, required String reference}) async{
    try{
      final updateData = {"paymentType": data};
      await firebase.collection("VENDAS").doc(reference).update(updateData);
      return true;
    }catch(err){
      return false;
    }

  }

}