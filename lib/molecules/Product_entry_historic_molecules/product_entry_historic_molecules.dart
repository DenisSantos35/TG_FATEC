import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/models/product_model.dart';
import 'package:tg_fatec/molecules/Product_entry_historic_molecules/historic_entry_unique_product.dart';

class ProductEntryHistory extends StatefulWidget {
  ProductEntryHistory({required this.title});

  String title;

  @override
  State<ProductEntryHistory> createState() => _ProductEntryHistoryState();
}

class _ProductEntryHistoryState extends State<ProductEntryHistory> {
  String _searchText = '';

  void _updateSearch(String newText) {
    setState(() {
      _searchText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(20, 20))),
        automaticallyImplyLeading: true,
        toolbarHeight: Get.height * 0.10,
        title: (Text(
          widget.title,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        )),
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.6),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "PESQUISAR",
                    ),
                    suffixIcon: Icon(Icons.search)),
                onChanged: _updateSearch,
              ),
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection("PRODUTOS").get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 160,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                        child: Image.network(
                                          snapshot.data!.docs[index]["images"],
                                          fit: BoxFit.cover,
                                          height: 250.0,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          String id = snapshot
                                              .data!.docs[index].reference.id;
                                          List response =
                                              await ProductModel.of(context)
                                                  .selectHistoricProduct();
                                          List historic = [];
                                          String nameProduct = "";
                                          List res = response
                                              .map((element) => {
                                                    if (element.data()["id"] ==
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                            .reference
                                                            .id)
                                                      {
                                                        historic.add(
                                                            element.data()),
                                                        nameProduct = element
                                                            .data()["images"].toString(),
                                                      }
                                                  })
                                              .toList();
                                          Get.to(HistoricEntryUniqueProduct(
                                              historicProduct: historic,
                                              title:
                                                  nameProduct));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.amber),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "VER MAIS",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  textAlign: TextAlign.center,
                                                ),
                                                flex: 2,
                                              ),
                                              Expanded(child: Icon(Icons.add)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data!.docs[index]["titulo"].toUpperCase()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "Valor: R\$ ${snapshot.data!.docs[index]["preco"].toStringAsFixed(2).replaceAll(".", ",")}",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "Estoque: ${snapshot.data!.docs[index]["quantidade"].toStringAsFixed(0)} Caixas",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
