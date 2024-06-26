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
          style: TextStyle(color: Colors.white),
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
          child: Text("Legumes do Chicão", style: TextStyle(color: Colors.white)),
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
            return Container(
              height: Get.height,
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.7,
                children: snapshot.data!.docs
                    .map((e) => Card(
                      color: ColorsApp.blueColorOpacity2(),
                      child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                                                  children: [
                        Container(
                          padding: EdgeInsets.all(8),
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
                        SizedBox(height: 3,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Text(
                                  "Produto: ${e["titulo"].toUpperCase()}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600, color: ColorsApp.whiteColor()),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Divider(color: Colors.green,),
                              Container(
                                child: Text(
                                  "Preço Atual: R\$ ${e["preco"].toStringAsFixed(2).replaceAll('.', ',')}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600, color: ColorsApp.whiteColor()),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Divider(color: Colors.green,),
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
                                      dataProduct: e.data() as Map<String, dynamic>,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(8),
                                      color: Colors.amber),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "VER CUSTO",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight:
                                                  FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        flex: 2,
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
