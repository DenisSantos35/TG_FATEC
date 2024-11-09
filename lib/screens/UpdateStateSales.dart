import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/controllers/reporte_controller.dart';

import '../atoms/texts/texts_atoms.dart';
import '../datas_class/colors.dart';
import '../datas_class/report_sales_class.dart';
import '../molecules/Sales_page_molecules/report_sales_a_prazo.dart';
import '../molecules/Tiles_molecules/report_sales_tile.dart';

class UpdateStateSales extends StatefulWidget {
  ReportController controller;
  UpdateStateSales({super.key, required this.controller});

  @override
  State<UpdateStateSales> createState() => _UpdateStateSalesState();
}

class _UpdateStateSalesState extends State<UpdateStateSales> {
  //CRIAR CLASSE DE VENDAS
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
        backgroundColor: ColorsApp.blueColor(),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        toolbarHeight: 90,
        title: TextTitle(
            label: "STATUS CLIENTE",
            size: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        centerTitle: true,
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
      //buscar dados de vendas a prazo
      // fazer botao para acessar detalhado
      // atualizar status
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "PESQUISAR",
                    ),
                    suffixIcon: Icon(Icons.search)),
                onChanged: _updateSearch,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: Get.height * 0.04,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "PAGAMENTOS A PRAZO DE CLIENTES",
                style: TextStyle(
                    color: ColorsApp.whiteColor(),
                    fontWeight: FontWeight.w900,
                    fontSize: 14),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: widget.controller.getSalesPrazo(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<Map<String, dynamic>> filteredData =
                        snapshot.data!.where((doc) {
                      // Filtro por data ou nome de cliente;
                      String dataVenda = doc['date'];
                      String nomeCliente = doc['nameClient'].toUpperCase();
                      String payment = doc['paymentType'].toUpperCase();
                      List listProduct = doc['products']
                          .map((e) => e["product"]["titulo"].toUpperCase())
                          .toList();

                      return dataVenda.contains(_searchText) ||
                          nomeCliente.contains(_searchText.toUpperCase()) ||
                          payment.contains(_searchText.toUpperCase()) ||
                          listProduct.contains(_searchText.toUpperCase());
                    }).toList();
                    return ListView.builder(
                      padding: const EdgeInsets.all(4.0),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        return ReportSalesPrazoTile(
                            ReportSalesClass.fromDocument(filteredData[index]));
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
