import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/atoms/message/message_atoms.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/helper/list_snapshot_status.dart';
import '../Tiles_molecules/product_tile.dart';


class ListProductAll extends StatelessWidget {
  ListProductAll({required this.title});

  String title;

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
                  return snapshot.data!.docs.length == 0
                      ? MessageStatusProduct(image: 'assets/images/tomate_desenho.png', label: "Não há produtos cadastrados no momento",)
                      : ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          page: 2,
                          title: "",
                          subtitle: "",
                          label: "Editar",
                          color: Colors.green,
                          button: true,
                          "list",
                          ProductDataClass.fromDocument(snapshot.data!.docs[index]),);
                      });
                }
              },
            )));
  }
}
