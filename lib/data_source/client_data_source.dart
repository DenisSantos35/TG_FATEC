
import 'package:tg_fatec/models/client_model.dart';

abstract class ClientDataSource {

  Future<bool> createClient({required Map<String, dynamic> data});

  Future editClient();

  Future inactivateCliente();

}