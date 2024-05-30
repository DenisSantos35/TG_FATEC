import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/datas_class/colors.dart';
import '../atoms/text_field/text_field_atoms.dart';
import '../datas_class/report_sales_class.dart';
import '../molecules/Tiles_molecules/report_sales_tile.dart';

class SalesReportScreen extends StatefulWidget {
  SalesReportScreen({required this.title});

  String title;

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  //CRIAR CLASSE DE VENDAS
  String _searchText = '';

  void _updateSearch(String newText) {
    setState(() {
      _searchText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),

          title: (Text(
            widget.title,
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
        body: Padding(
          padding: EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            children: [
              Container(
                height: 50,
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
              SizedBox(height: 15,),
              Container(
                height: Get.height * 0.04,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "RELATÓRIOS DETALHADO POR VENDA",
                  style: TextStyle(
                      color: ColorsApp.whiteColor(), fontWeight: FontWeight.w900, fontSize: 14),
                ),
              ),
              Divider(color: Colors.black, thickness: 2,),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection("VENDAS").orderBy("date", descending: true).get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<QueryDocumentSnapshot> filteredData =
                          snapshot.data!.docs.where((doc) {
                        // Filtro por data ou nome de cliente
                        String dataVenda = doc['date'];
                        String nomeCliente = doc['nameClient'].toUpperCase();
                        String payment = doc['paymentType'].toUpperCase();
                        List listProduct =
                            doc['products'].map((e)=> e["product"]["titulo"].toUpperCase()).toList();

                        return dataVenda.contains(_searchText) ||
                            nomeCliente.contains(_searchText.toUpperCase()) ||
                            payment.contains( _searchText.toUpperCase()) || listProduct.contains(_searchText.toUpperCase());
                      }).toList();
                      return ListView.builder(
                        padding: EdgeInsets.all(4.0),
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          return ReportSalesTile(ReportSalesClass.fromDocument(
                              filteredData[index].data()));
                        },
                      );
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
