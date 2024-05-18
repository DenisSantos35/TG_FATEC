import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/atoms/radio_button/radio_button.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';
import 'package:tg_fatec/models/product_model.dart';
import 'package:tg_fatec/models/user_model.dart';

import '../../atoms/containers/containers_atoms.dart';
import '../../atoms/sizedbox/SizedBox_atoms.dart';
import '../../atoms/texts/texts_atoms.dart';
import '../../helper/upload_image.dart';
import '../../screens/final_create_product_screen.dart';

class CreateProductMolecules extends StatefulWidget {
  const CreateProductMolecules({Key? key}) : super(key: key);

  @override
  State<CreateProductMolecules> createState() => _CreateProductMoleculesState();
}

class _CreateProductMoleculesState extends State<CreateProductMolecules> {
  final formKeyUser = GlobalKey<FormState>();
  final description = TextEditingController();
  final imageUpload = TextEditingController();
  final price = TextEditingController();
  final amount = TextEditingController();
  final title = TextEditingController();
  final typeMensurament = TextEditingController();

  ProductDataClass product = ProductDataClass();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        toolbarHeight: 90,
        title: textTitle(
            label: "CADASTRAR PRODUTOS",
            size: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  27, size.height * 0.03, 27, size.height * 0.03),
              child: Column(
                children: [
                  SizeHeight(height: size.width, multiplier: 0.08),
                  Form(
                    key: formKeyUser,
                    child: Column(
                      children: [
                        Card(
                          child: ContainerTextFieldText(
                              inputController: title,
                              type: TextInputType.text,
                              label: "Nome do Produto:",
                              hint: "Digite o Nome do Produto",
                              icon: Icons.apple),
                        ),
                        SizeHeight(height: size.width, multiplier: 0.04),
                        Card(
                          child: ContainerTextFieldFormated(
                              inputController: price,
                              label: "Preço do Produto:",
                              type: TextInputType.number,
                              hint: "Digite o Preço do Produto",
                              icon: Icons.monetization_on_outlined,
                              inputFormater: CentavosInputFormatter()),
                        ),
                        SizeHeight(height: size.width, multiplier: 0.04),
                        Card(
                          child: ContainerTextFieldInt(
                            inputController: amount,
                            label: "Quantidade de Produtos:",
                            type: TextInputType.number,
                            hint: "Digite a Quantidade de Produtos",
                            icon: Icons.bar_chart,
                          ),
                        ),
                        SizeHeight(height: size.width, multiplier: 0.04),
                        Card(
                          child: ContainerTextFieldDesc(
                            inputController: description,
                            label: "Descrição do Produto:",
                            type: TextInputType.text,
                            hint: "Digite uma Descrição",
                            icon: Icons.text_fields,
                          ),
                        ),
                        SizeHeight(height: size.width, multiplier: 0.04),
                        RadioButton(
                          label1: "CAIXA",
                          label2: "kg",
                          typeMensurament: typeMensurament,
                        ),
                        SizeHeight(height: size.width, multiplier: 0.04),
                        UploadImage(imageUpload),
                        SizeHeight(height: size.width, multiplier: 0.08),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 4,
                    height: size.height * 0.06,
                    child: OutlinedButton(
                      onPressed: () {
                        Logger().e(
                            "${description.text}, ${price.text}, ${amount.text}, ${title.text}, ${imageUpload.text}, ${typeMensurament.text}");
                        Logger().d(
                            "${description.text.isEmpty}, ${price.text.isEmpty}, ${amount.text.isEmpty}, ${title.text.isEmpty}, ${imageUpload.text.isEmpty}, ${typeMensurament.text.isEmpty}");
                        if (description.text.isEmpty ||
                            price.text.isEmpty ||
                            amount.text.isEmpty ||
                            title.text.isEmpty ||
                            imageUpload.text.isEmpty ||
                            typeMensurament.text.isEmpty) {
                          Get.snackbar("Campos vázios",
                              "Verifique o preencimento de todos os campos e tente novamente",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                        }else{
                          String valueAmount = amount.text.replaceAll(".", "").replaceAll(",", ".");
                          String valuePrice = price.text.replaceAll(".", "").replaceAll(",", ".");
                          ProductDataClass product = ProductDataClass(
                              titulo
                              : title.text.toUpperCase(),
                              description
                              : description.text,
                              price
                              :double.parse(valuePrice),
                              image
                              : imageUpload.text,
                              unidadeMedida
                              :typeMensurament.text,
                              quantidade
                              :double.parse(valueAmount),
                              status
                              :true);
                          ProductModel.of(context).saveProduct(product.toMap());
                          Get.to(FinalPage(label: "PRODUTO", title: "Produto Cadastrado com sucesso!", page: 1,));

                        }

                      },
                      child: Text(
                        "CADASTRAR",
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
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
