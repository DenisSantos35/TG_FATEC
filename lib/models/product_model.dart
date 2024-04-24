
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';

class ProductModel extends Model{
  //final ProductDataClass product;

  //ProductModel(this.product);

  static ProductModel of(context) => ScopedModel.of(context);

  Future<bool> saveProduct(Map<String, dynamic> product)async{
    FirebaseFirestore firebase = await FirebaseFirestore.instance;
    var response = firebase.collection("PRODUTOS").doc(DateTime.now().toString()).set(product);
    notifyListeners();
    return true;
  }

  Future<bool> editProduct(Map<String, dynamic> product, String reference)async{
    try{
      FirebaseFirestore firebase = await FirebaseFirestore.instance;
      var response = firebase.collection("PRODUTOS").doc(reference).update(product);
      notifyListeners();
      return true;
    }catch(err){
      return false;
    }
  }

  Future<Map<String, dynamic>> inactivateProduct(
      {required Map<String, dynamic> product, required String id})async{
   try{
     FirebaseFirestore firebase = await FirebaseFirestore.instance;
     var response = await firebase.collection("PRODUTOS").doc(id).update(product);
     notifyListeners();
     QuerySnapshot data = await firebase.collection("PRODUTOS").get();
     List updateData = data.docs;
     return {'res': true, 'data': updateData};
   }catch(err){
     return {'res': false};
   }
  }

}