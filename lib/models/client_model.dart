import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/data_source/client_data_source.dart';

import '../atoms/dialog/dialog_atoms.dart';

class ClienteModel extends Model implements ClientDataSource {
  static ClienteModel of(context) => ScopedModel.of<ClienteModel>(context);

  @override
  Future editClient() {
    // TODO: implement editClient
    throw UnimplementedError();
  }

  @override
  Future inactivateCliente() {
    // TODO: implement inactivateCliente
    throw UnimplementedError();
  }

  @override
  Future<bool> createClient({required Map<String, dynamic> data}) async {
    try {
      Logger().e("teste");
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("CLIENTES")
          .doc(DateTime.now().toString())
          .set(data)
          .onError((error, _) => Logger().e("Erro ao salvar dados $error"));
      notifyListeners();

      return true;
    } catch (err) {
      return false;
    }
  }
}
