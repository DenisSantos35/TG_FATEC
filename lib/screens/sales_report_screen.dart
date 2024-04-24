import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
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
          backgroundColor: Colors.red.withOpacity(0.6),
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
                        print(listProduct);
                      

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

                      // return ListView.builder(
                      //     padding: EdgeInsets.all(4.0),
                      //     itemCount: snapshot.data!.docs.length,
                      //     itemBuilder: (context, index) {
                      //       // Logger().e(ReportSalesClass.fromDocument(
                      //       //     snapshot.data!.docs[index].data()));
                      //       return ReportSalesTile(
                      //           ReportSalesClass.fromDocument(
                      //               snapshot.data!.docs[index].data()));
                      //     });
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
