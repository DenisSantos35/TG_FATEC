
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/molecules/Client_pages_molecules/data_clientes_moleculres.dart';
import 'package:tg_fatec/molecules/View_Client_molecules/edit_client_molecules.dart';
import 'package:tg_fatec/molecules/View_Client_molecules/remove_client_molecules.dart';
import 'package:tg_fatec/molecules/View_Client_molecules/view_client_molecules.dart';

class DataClientesController extends GetxController{

  void acessPage({required Page page}){
    switch(page.name){
      case 'visualizar':
        Get.to(ViewClienteMolecules());
        break;
      case 'editar':
        Get.lazyPut(() => DataClientesController());
        Get.to(EditClienteMolecules(controller: DataClientesController()));
        break;
      case 'remover':
        Get.lazyPut(()=> DataClientesController());
        Get.to(RemoveClienteMolecules(controller: DataClientesController(),));
        Logger().e(page.name);
        break;
    }
  }

  Future<bool> deleteClient({required String reference})async{
    try{
      final firebase = FirebaseFirestore.instance;
      await firebase.collection("CLIENTES").doc(reference).delete();
      return true;
    }catch(err){
      rethrow;
    }
  }

  Future<bool> updateClient({required String reference, required Map<String, dynamic> data})async{
    try{
      final firebase = FirebaseFirestore.instance;
      await firebase.collection("CLIENTES").doc(reference).update(data);
      return true;
    }catch(err){
      rethrow;
    }
  }


}