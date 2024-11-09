import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/controllers/product_controlers.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import 'package:tg_fatec/molecules/Custo_medio_produtos_molecules/Details_historic_cost_molecules.dart';

class AverageCostProductsMolecules extends StatelessWidget {
  AverageCostProductsMolecules({required this.title});

  ProductController controller = Get.put(ProductController());

  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(20, 20))),
        automaticallyImplyLeading: true,
        toolbarHeight: Get.height * 0.10,
        title: (Text(
          title,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        )),
        centerTitle: true,
        backgroundColor: ColorsApp.blueColor(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorsApp.blueColor(),
        height: 50,
        child: Container(
          alignment: Alignment.center,
          child: const Text("Legumes do Chicão",
              style: TextStyle(color: Colors.white)),
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
            return Container(
              height: Get.height,
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.7,
                children: snapshot.data!.docs
                    .map((e) => Card(
                          color: ColorsApp.blueColorOpacity2(),
                          child: Container(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  height: 150,
                                  width: Get.width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.network(
                                    e["images"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Produto: ${e["titulo"].toUpperCase()}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: ColorsApp.whiteColor()),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.green,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Preço Atual: R\$ ${e["preco"].toStringAsFixed(2).replaceAll('.', ',')}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: ColorsApp.whiteColor()),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final listHistorics =
                                              await controller.selectPrice(
                                                  context: context,
                                                  id: e.reference.id);
                                          Get.to(
                                            DetailsHistoricoCost(
                                              title: "RELATÓRIO MÉDIA\n CUSTO",
                                              historics: listHistorics,
                                              dataProduct: e.data()
                                                  as Map<String, dynamic>,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.amber),
                                          child: const Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "VER CUSTO",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Icon(Icons
                                                      .description_outlined)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
