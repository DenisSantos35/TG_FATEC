// ignore_for_file: prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/helper/list_snapshot_status.dart';

import '../../atoms/message/message_atoms.dart';
import '../Tiles_molecules/product_tile.dart';

class InactiveHistoricProductScreen extends StatefulWidget {
  InactiveHistoricProductScreen({required this.title});

  String title;

  @override
  State<InactiveHistoricProductScreen> createState() =>
      _InactiveHistoricProductScreenState();
}

class _InactiveHistoricProductScreenState
    extends State<InactiveHistoricProductScreen> {
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
            widget.title,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
          centerTitle: true,
          backgroundColor: ColorsApp.blueColor(),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 50,
          color: ColorsApp.blueColor(),
          child: Container(
            alignment: Alignment.center,
            child: const Text(
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _data.data(snapshot.data!.docs, false).length == 0
                  ? MessageStatusProduct(
                      image: 'assets/images/tomate_desenho.png',
                      label: "Não há produtos cadastrados no momento",
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(4.0),
                      itemCount: _data.data(snapshot.data!.docs, false).length,
                      itemBuilder: (context, index) {
                        List data = _data.data(snapshot.data!.docs, false);
                        return ProductTile(
                          page: 6,
                          title:
                              "Você deseja reativar o produto ${data[index]["titulo"]} ?",
                          subtitle:
                              "Para inativa-lo, consulte o histórico de inativos!",
                          label: "Reativar",
                          color: Colors.green,
                          button: true,
                          "list",
                          ProductDataClass.fromDocument(data[index]),
                        );
                      });
            }
          },
        ),
      ),
    );
  }
}
