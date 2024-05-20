import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/atoms/imagens/images_atoms.dart';
import 'package:tg_fatec/atoms/message/message_atoms.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/helper/list_snapshot_status.dart';
import '../Tiles_molecules/product_tile.dart';


class InactivateProductScreen extends StatelessWidget {
  InactivateProductScreen({required this.title, this.product});

  String title;
  List? product;
  ListSnapshotStatus _data = ListSnapshotStatus();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              toolbarHeight: Get.height * 0.10,
              title: (Text(
                title,
                style: TextStyle(color: Colors.white),
              )),
              centerTitle: true,
              backgroundColor: Colors.black.withOpacity(0.6),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.black.withOpacity(0.6),
              child: Container(
                alignment: Alignment.center,
                child:const Text(
                  "Legumes do Chicão",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            body: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("PRODUTOS").get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return _data.data(snapshot.data!.docs, true).length == 0
                      ? MessageStatusProduct(image: 'assets/images/tomate_desenho.png', label: "Não há produtos cadastrados no momento",)
                      : ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: product == null
                              ? _data.data(snapshot.data!.docs, true).length
                              : product!.length,
                          itemBuilder: (context, index) {
                            List data = _data.data(
                                product == null
                                    ? snapshot.data!.docs
                                    : product!,
                                true);
                            return ProductTile(
                              page: 1,
                              title: "Você deseja inativar o produto ${data[index]["titulo"]} ?",
                              subtitle: "Para reativá-lo, consulte o histórico de inativos!",
                              label: "Inativar",
                                color: Colors.red,
                                button: true,
                                "list",
                                ProductDataClass.fromDocument(data[index]),);
                          });
                }
              },
            )));
  }
}
