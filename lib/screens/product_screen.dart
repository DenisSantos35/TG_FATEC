import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';

import '../molecules/Tiles_molecules/product_tile.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: (Text(title, style: TextStyle(color: Colors.white),)),
              centerTitle: true,
              backgroundColor: Colors.red.withOpacity(0.6),
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(icon: Icon(Icons.grid_on, color: Colors.white, size: 30,)),
                  Tab(
                    icon: Icon(Icons.list, color: Colors.black,size: 35,),
                  )
                ],
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
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                          padding: EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: 0.65),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ProductTile(
                                "grid",
                                ProductDataClass.fromDocument(
                                    snapshot.data!.docs[index]));
                          }),
                      ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ProductTile(
                                "list",
                                ProductDataClass.fromDocument(
                                    snapshot.data!.docs[index]));
                          }),
                    ],
                  );
                }
              },
            )));
  }
}
