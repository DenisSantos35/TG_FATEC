import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/controllers/product_controlers.dart';

import '../../atoms/containers/containers_atoms.dart';
import '../../atoms/show_snack_bars/ShowSnacksBars.dart';
import '../../atoms/sizedbox/SizedBox_atoms.dart';
import '../../atoms/texts/texts_atoms.dart';
import '../../datas_class/product_data_class.dart';
import '../../helper/edit_image_helper.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../screens/final_create_product_screen.dart';

class EditStockProductMolecules extends StatefulWidget {
  EditStockProductMolecules({required this.product, this.reference});

  ProductDataClass product;
  DocumentReference<Object?>? reference;

  @override
  State<EditStockProductMolecules> createState() =>
      _EditStockProductMoleculesState();
}

class _EditStockProductMoleculesState extends State<EditStockProductMolecules> {
  final formKeyUser = GlobalKey<FormState>();
  final quantProduct = TextEditingController();
  final imageUpload = TextEditingController();
  final price = TextEditingController();
  final title = TextEditingController();
  TextEditingController typeMensurament = TextEditingController();
  ProductController controller = Get.put(ProductController());

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
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  27, 0, 27, size.height * 0.03),
              child: Column(
                children: [
                  SizeHeight(height: size.width, multiplier: 0.01),
                  Form(
                    key: formKeyUser,
                    child: Column(
                      children: [
                        ContainerTextFieldTextEdit(
                            titulo: title,
                            product: widget.product.titulo.toString(),
                            type: TextInputType.text,
                            label: "",
                            hint: "",
                            icon: Icons.apple),
                        SizeHeight(height: size.width, multiplier: 0.04),
                        EditUploadImage(
                          inputController: imageUpload,
                          image: widget.product.image.toString(),
                          editProduct: true,
                        ),
                        SizeHeight(height: size.width, multiplier: 0.01),
                        Card(
                          child: ContainerTextFieldFormatedEditProduct(
                              isInteger: false,
                              preco: price,
                              product: widget.product.price!.toStringAsFixed(2),
                              label: "Preço do Produto:",
                              type: TextInputType.number,
                              hint: "Digite o Preço do Produto",
                              icon: Icons.monetization_on_outlined,
                              inputFormater: CentavosInputFormatter()),

                        ),
                        SizeHeight(height: size.width, multiplier: 0.04),
                        Card(
                          child: ContainerTextFieldFormatedEditProduct(
                              isInteger: true,
                              preco: quantProduct,
                              product:
                              widget.product.quantidade!.toStringAsFixed(0),
                              label: "Quantidade de Produto:",
                              type: TextInputType.number,
                              hint: "Digite a quantidade do produto",
                              icon: Icons.production_quantity_limits_outlined,
                              inputFormater: CentavosInputFormatter()),
                        )
                      ],
                    ),
                  ),
                  SizeHeight(height: size.width, multiplier: 0.04),
                  Container(
                    width: size.width * 0.50,
                    height: size.height * 0.04,
                    child: OutlinedButton(
                      onPressed: () async {

                        String reference = widget.reference!.id;
                        price.text = controller.replace(price.text);
                        if (price.text.isEmpty) {
                          SnackBars.ErrorPrice(
                              title: "Erro ao salvar produto!",
                              message:
                                  "Digite o valor do produto para continuar");
                          return;
                        }

                        double finalPrice = double.parse(price.text);
                        quantProduct.text =
                            controller.replace(quantProduct.text);
                        if (quantProduct.text.isEmpty) {
                          SnackBars.ErrorPrice(
                              title: "Erro ao salvar produto!",
                              message:
                                  "Digite a quantidade a ser adicionada ao estoque");
                          return;
                        }

                        int totalQuantProduct = controller.calculateStock(
                            quantProduct.text,
                            widget.product.quantidade!.toStringAsFixed(0));

                        ProductDataClass product = ProductDataClass(
                          description: widget.product.description,
                          image: widget.product.image,
                          price: finalPrice,
                          quantidade: totalQuantProduct.toDouble(),
                          status: true,
                          titulo: widget.product.titulo,
                          unidadeMedida: widget.product.unidadeMedida
                        );
                        //atualizar estoque aqui
                        Map<String,dynamic> res = await ProductModel.of(context).updateProduct(product: product.addStockMap(), id: reference);

                        product.id = reference;
                        product.quantidade = double.parse(quantProduct.text);
                        product.data = controller.dateTime(typeData: "dd/MM/yyyy");
                        product.hora = controller.dateTime(typeData: "HH:mm");

                        //salvar historico aqui
                        bool resHistoric = await ProductModel.of(context).saveHistoricProduct(product: product.historicToMap());

                        setState(() {
                          //widget.product = res["data"];
                        });

                        if(res["res"]){
                           Get.to(FinalPage(label: "CADASTRAR ESTOQUE", title: "Estoque atualizado com sucesso!", page: 2,));
                        }else{
                          SnackBars.ErrorPrice(title: "Erro ao salvar dados!", message: "Tente cadastrar o estoque novamente");
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
