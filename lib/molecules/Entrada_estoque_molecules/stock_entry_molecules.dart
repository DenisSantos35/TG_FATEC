import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tg_fatec/datas_class/colors.dart';

import '../../atoms/message/message_atoms.dart';
import '../../datas_class/product_data_class.dart';
import '../Tiles_molecules/product_tile.dart';

class StockEntryMolecules extends StatelessWidget {
   StockEntryMolecules({required this.title});

   String title;
   bool isCreated = false;

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
             backgroundColor: ColorsApp.blueColor(),
           ),
           bottomNavigationBar: BottomAppBar(
             height: 50,
             color: ColorsApp.blueColor(),
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
                         page: 3,
                         title: "",
                         subtitle: "",
                         label: "CADASTRAR",
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
