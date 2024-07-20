import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../atoms/imagens/images_atoms.dart';
import '../../atoms/texts/texts_atoms.dart';
import '../../controllers/data_clientes_controllers.dart';
import '../../datas_class/client.dart';
import '../../datas_class/colors.dart';

class EditClientDetails extends StatefulWidget {
  final Client client;
  DataClientesController controller;
  String reference;

  EditClientDetails(
      {Key? key,
      required this.client,
      required this.controller,
      required this.reference});

  @override
  State<EditClientDetails> createState() => _EditClientDetailsState();
}

class _EditClientDetailsState extends State<EditClientDetails> {
  bool isEdit = false;

  String razaoSocial = "";
  String name = "";
  String phone = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.blueColor(),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        toolbarHeight: 90,
        title: Row(children: [
          Expanded(
            child: TextTitle(
                label: "${widget.client.razao_social!.toUpperCase()}",
                size: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          InkWell(
            onTap: () async {
              await updateData();
            },
            child: Icon(
              Icons.save,
              color: Colors.green,
            ),
          )
        ]),
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            imageDefault(
                context: context,
                image: "assets/images/tomate_desenho.png",
                opacity: 0.1),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 40),
              child: Column(
                children: [
                  titleContainer(
                      title: "DADOS DO CLIENTE", icon: Icons.person_pin),
                  divider(),
                  dataUserContainerRazao(
                      title: "Razão Social: ",
                      subtitle: widget.client.razao_social),
                  dataUserContainerName(
                      title: "Nome: ", subtitle: widget.client.nome),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  titleContainer(
                      title: "CONTATOS", icon: Icons.contact_mail_outlined),
                  divider(),
                  dataUserContainerPhone(
                      title: "Telefone: ", subtitle: widget.client.telefone),
                  dataUserContainerEmail(
                      title: "E-mail: ", subtitle: widget.client.email),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  titleContainer(
                      title: "ENDEREÇO", icon: Icons.cottage_outlined),
                  divider(),
                  dataUserContainer(
                      title: "Rua/Av: ", subtitle: widget.client.rua),
                  dataUserContainer(
                      title: "Bairro: ", subtitle: widget.client.bairro),
                  dataUserContainer(
                      title: "Complemento: ",
                      subtitle: widget.client.complemento),
                  dataUserContainer(
                      title: "Numero: ", subtitle: widget.client.numero),
                  dataUserContainer(
                      title: "Cidade: ", subtitle: widget.client.cidade),
                  dataUserContainer(
                      title: "CEP: ", subtitle: widget.client.cep),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      await updateData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Remove a borda circular
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "SALVAR DADOS",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),

                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.save,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
      color: Colors.black,
      thickness: 2,
    );
  }

  Widget titleContainer({required String title, required IconData icon}) {
    return Container(
      height: Get.height * 0.04,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: Get.width * 0.03,
          ),
          Text(
            title,
            style: TextStyle(
              color: ColorsApp.whiteColor(),
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget dataUserContainerRazao(
      {required String title, required String? subtitle}) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Container(
        width: Get.width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  textAlign: TextAlign.start,
                )),
            Container(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                initialValue: subtitle!.toUpperCase(),
                onChanged: (value) {
                  setState(() {
                    razaoSocial = value;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataUserContainerName(
      {required String title, required String? subtitle}) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Container(
        width: Get.width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  textAlign: TextAlign.start,
                )),
            Container(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                initialValue: subtitle!.toUpperCase(),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataUserContainerPhone(
      {required String title, required String? subtitle}) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Container(
        width: Get.width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  textAlign: TextAlign.start,
                )),
            Container(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                initialValue: subtitle!.toUpperCase(),
                inputFormatters: [
                  // obrigatório
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataUserContainerEmail(
      {required String title, required String? subtitle}) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Container(
        width: Get.width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  textAlign: TextAlign.start,
                )),
            Container(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                initialValue: subtitle!.toUpperCase(),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataUserContainer({required String title, required final subtitle}) {
    return Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Container(
        width: Get.width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  textAlign: TextAlign.start,
                )),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${subtitle.toUpperCase()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16),
                  textAlign: TextAlign.start,
                ))
          ],
        ),
      ),
    );
  }

  Future<void> updateData()async {
    final result = await widget.controller
        .updateClient(reference: widget.reference, data: {
      "razao_social": razaoSocial.isEmpty
          ? widget.client.razao_social
          : razaoSocial,
      "nome": name.isEmpty ? widget.client.nome : name,
      "telefone": phone.isEmpty ? widget.client.telefone : phone,
      "email": email.isEmpty ? widget.client.email : email
    });

    if (result) {
      Get.back();
      Get.showSnackbar(GetSnackBar(
        title: "Atualização de Dados",
        message: "Dados do Cliente atualizado com sucesso",
        backgroundColor: ColorsApp.orangeColor(),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
    } else {
      Get.back();
      Get.showSnackbar(GetSnackBar(
        title: "Erro ao atualizar Dados",
        message: "Verifique os dados e tente novamente",
        backgroundColor: ColorsApp.orangeColor(),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
    }
  }
}
