import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/molecules/View_Client_molecules/remove_client_tile.dart';
import 'package:tg_fatec/molecules/View_Client_molecules/view_client_tile.dart';
import '../../atoms/imagens/images_atoms.dart';
import '../../atoms/texts/texts_atoms.dart';
import '../../controllers/data_clientes_controllers.dart';
import '../../datas_class/client.dart';
import '../../datas_class/colors.dart';

class RemoveClienteMolecules extends StatefulWidget {
  DataClientesController controller ;
  RemoveClienteMolecules({Key? key, required this.controller}) : super(key: key);

  @override
  State<RemoveClienteMolecules> createState() => _RemoveClienteMoleculesState();
}

class _RemoveClienteMoleculesState extends State<RemoveClienteMolecules> {
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
            label: "CLIENTES",
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
      body: Stack(
        children: [
          imageDefault(
              context: context,
              image: "assets/images/tomate_desenho.png",
              opacity: 0.2),
          Padding(
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
                SizedBox(
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
                    "DADOS DOS CLIENTES CADASTRADOS",
                    style: TextStyle(
                        color: ColorsApp.whiteColor(),
                        fontWeight: FontWeight.w900,
                        fontSize: 14),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("CLIENTES")
                        .orderBy("razao_social", descending: true)
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List<QueryDocumentSnapshot> filteredData =
                        snapshot.data!.docs.where((doc) {
                          String razaoSocial = doc['razao_social'];
                          String nomeCliente = doc['nome'].toUpperCase();
                          String cpfCnpj = doc['cpfCnpj'].toUpperCase();
                          String email = doc['email'].toUpperCase();
                          return razaoSocial.contains(_searchText) ||
                              nomeCliente.contains(_searchText.toUpperCase()) ||
                              cpfCnpj.contains(_searchText.toUpperCase()) ||
                              email.contains(_searchText.toUpperCase());
                        }).toList();
                        return ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: filteredData.length,
                          itemBuilder: (context, index) {
                            return RemoveClientTile(
                              data: Client.fromDocument(
                                  filteredData[index].data()),contoller: widget.controller,
                              reference: filteredData[index].reference.id,

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
        ],
      ),
    );
  }
}
