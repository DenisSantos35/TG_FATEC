import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/models/product_model.dart';
import 'package:tg_fatec/molecules/Product_entry_historic_molecules/historic_entry_unique_product.dart';

class ProductEntryHistory extends StatefulWidget {
  const ProductEntryHistory({super.key, required this.title});

  final String title;

  @override
  State<ProductEntryHistory> createState() => _ProductEntryHistoryState();
}

class _ProductEntryHistoryState extends State<ProductEntryHistory> {
  void _updateSearch(String newText) {
    setState(() {});
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection("PRODUTOS").get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(4.0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: ColorsApp.blueColorOpacity2(),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
                                          List response =
                                              await ProductModel.of(context)
                                                  .selectHistoricProduct();
                                          List historic = [];
                                          String nameProduct = "";
                                          response
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
                                                            .data()["images"]
                                                            .toString(),
                                                      }
                                                  })
                                              .toList();
                                          if (historic.isEmpty) {
                                            Get.showSnackbar(const GetSnackBar(
                                              title:
                                                  "Não há histórico para este produto!",
                                              message:
                                                  "Cadastre um estoque para verificar o histórico.",
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 2),
                                            ));
                                            return;
                                          }
                                          Get.to(HistoricEntryUniqueProduct(
                                              historicProduct: historic,
                                              title: nameProduct));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.amber),
                                          child: const Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "VER MAIS",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Expanded(child: Icon(Icons.add)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    color: Colors.green,
                                    width: 3,
                                    height: 150,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "${snapshot.data!.docs[index]["titulo"].toUpperCase()}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        color: Colors.black,
                                        width: 200,
                                        height: 2,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Valor: R\$ ${snapshot.data!.docs[index]["preco"].toStringAsFixed(2).replaceAll(".", ",")}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Container(
                                        color: Colors.black,
                                        width: 200,
                                        height: 1,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Estoque: ${snapshot.data!.docs[index]["quantidade"].toStringAsFixed(0)} Caixas",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        color: Colors.green,
                                        width: 200,
                                        height: 3,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Total:   R\$ ${(snapshot.data!.docs[index]["quantidade"] * snapshot.data!.docs[index]["preco"]).toStringAsFixed(2).replaceAll('.', ',')} ",
                                        style: const TextStyle(
                                            color: Colors.black,
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
