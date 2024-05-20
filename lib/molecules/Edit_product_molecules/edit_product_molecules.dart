import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/helper/edit_image_helper.dart';
import 'package:tg_fatec/models/user_model.dart';

import '../../atoms/containers/containers_atoms.dart';
import '../../atoms/imagens/images_atoms.dart';
import '../../atoms/sizedbox/SizedBox_atoms.dart';
import '../../atoms/texts/texts_atoms.dart';
import '../../models/product_model.dart';
import '../../screens/final_create_product_screen.dart';

class EditProductMolecules extends StatefulWidget {
  EditProductMolecules({required this.product, this.reference});

  ProductDataClass product;
  DocumentReference<Object?>? reference;

  @override
  State<EditProductMolecules> createState() => _CreateProductMoleculesState();
}

class _CreateProductMoleculesState extends State<EditProductMolecules> {
  final formKeyUser = GlobalKey<FormState>();
  final description = TextEditingController();
  final imageUpload = TextEditingController();
  final price = TextEditingController();
  final title = TextEditingController();
  TextEditingController typeMensurament = TextEditingController();

  @override
  void initState() {
    Logger().e(widget.product.titulo.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        toolbarHeight: 90,
        title: TextTitle(
            label: "EDITAR PRODUTOS",
            size: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black.withOpacity(0.6),
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
      body: Stack(
        children: [
          imageDefault(
              context: context,
              image: "assets/images/tomate_desenho.png",
              opacity: 0.2),
          ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    27, 0, 27, size.height * 0.03),
                child: Column(
                  children: [
                    SizeHeight(height: size.width, multiplier: 0.08),
                    Form(
                      key: formKeyUser,
                      child: Column(
                        children: [
                          ContainerTextFieldTextEdit(
                              titulo: title,
                              product: widget.product.titulo.toString(),
                              type: TextInputType.text,
                              label: "Nome do Produto:",
                              hint: "Digite o Nome do Produto",
                              icon: Icons.apple),
                          SizeHeight(height: size.width, multiplier: 0.04),
                          Card(
                            child: ContainerTextFieldFormatedEdit(
                                preco: price,
                                product: widget.product.price.toString(),
                                label: "Preço do Produto:",
                                type: TextInputType.number,
                                hint: "Digite o Preço do Produto",
                                icon: Icons.monetization_on_outlined,
                                inputFormater: CentavosInputFormatter()),
                          ),
                          SizeHeight(height: size.width, multiplier: 0.04),
                          Card(
                            child: ContainerTextFieldDescEdit(
                              descripition: description,
                              product: widget.product.description.toString(),
                              label: "Descrição do Produto:",
                              type: TextInputType.text,
                              hint: "Digite uma Descrição",
                              icon: Icons.text_fields,
                            ),
                          ),
                          SizeHeight(height: size.width, multiplier: 0.04),
                          EditUploadImage(
                              inputController: imageUpload,
                              image: widget.product.image.toString()),
                          SizeHeight(height: size.width, multiplier: 0.01),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.30,
                      height: size.height * 0.05,
                      child: OutlinedButton(
                        onPressed: () async{
                          String reference = widget.reference!.id;
                          description.text = (description.text.isEmpty
                              ? widget.product.description
                              : description.text)!;
                          imageUpload.text = (imageUpload.text.isEmpty
                              ? widget.product.image
                              : imageUpload.text)!;
                          price.text = (price.text.isEmpty
                              ? widget.product.price.toString()
                              : price.text
                                  .replaceAll(".", "")
                                  .replaceAll(",", "."));
                          double finalPrice = double.parse(price.text);

                          ProductDataClass product = ProductDataClass.edit(
                              description: description.text,
                              price: finalPrice,
                              image: imageUpload.text);
                          Logger().i("${product.editProductMap()} ${reference} ");
                          bool res = await ProductModel.of(context).editProduct(product.editProductMap(), reference);
                          if(res){
                            Get.to(FinalPage(label: "PRODUTO", title: "Produto atualizado com sucesso!", page: 2,));
                          }else{
                            Logger().e("Erro ao salvar ");
                          }
                        },
                        child: Text(
                          "SALVAR",
                          style: TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),],
      ),
    );
  }
}
