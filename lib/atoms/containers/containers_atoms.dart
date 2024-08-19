import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/molecules/Edit_product_molecules/edit_product_molecules.dart';
import 'package:tg_fatec/molecules/Edit_product_molecules/list_product_all_molecules.dart';
import 'package:tg_fatec/molecules/Entrada_estoque_molecules/stock_entry_molecules.dart';
import 'package:tg_fatec/molecules/Inactivate_product_molecules/inactivate_product_molecule.dart';
import 'package:tg_fatec/molecules/Inactive_historic_molecules/inactive_historic_molecules.dart';
import 'package:tg_fatec/molecules/Product_entry_historic_molecules/product_entry_historic_molecules.dart';

import '../../datas_class/colors.dart';
import '../../molecules/Create_product_pages_molecules/create_product_molecules.dart';
import '../../molecules/Custo_medio_produtos_molecules/average_cost_of_products_molecules.dart';
import '../imagens/images_atoms.dart';
import '../texts/texts_atoms.dart';

Widget TitleReport({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: Container(
      height: Get.height * 0.04,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget ReportDetails(
    {required String titleComp,
    required String subtitle,
    required String titleSale,
    required String totalProductComp,
    required String quantProductComp,
    required String quantProductSales,
    required String totalProductSales,
    required String titleDiscount,
    required String subtitleDiscount,
    required String titleSubTotal,
    required String subTotal}) {
  return Container(
    alignment: Alignment.centerLeft,
    height: Get.height * 0.63,
    padding: const EdgeInsets.only(right: 16, left: 16),
    child: Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Container(
        width: Get.width,
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
        child: Column(
          children: [
            TitleReport(title: 'COMPRAS'),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(children: [
              Expanded(
                flex: 2,
                child: Text(
                  titleComp,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Divider(
              color: Colors.green,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(children: [
              Expanded(
                child: Text(
                  "${quantProductComp} Caixas",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  "R\$ ${totalProductComp}",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            TitleReport(title: 'VENDAS'),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            Row(children: [
              Expanded(
                flex: 2,
                child: Text(
                  titleSale,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Divider(
              color: Colors.green,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(children: [
              Expanded(
                child: Text(
                  "${quantProductSales} Caixas",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  "R\$ ${totalProductSales}",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Divider(
              color: Colors.green,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(children: [
              Expanded(
                child: Text(
                  titleDiscount,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  subtitleDiscount,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(children: [
              Expanded(
                child: Text(
                  titleSubTotal,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  subTotal,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(children: [
              Expanded(
                child: Text(
                  "Total: ",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  subTotal,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget TotalReport(
    {required String totalProduc, required String quantProduct}) {
  return Container(
    alignment: Alignment.centerLeft,
    height: Get.height * 0.16,
    padding: const EdgeInsets.only(right: 16, left: 16),
    child: Card(
      color: ColorsApp.blueColorOpacity2(),
      child: Container(
        width: Get.width,
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
        child: Column(
          children: [
            const Row(children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Produtos Comprados ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  "Total R\$",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Divider(
              color: Colors.green,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(children: [
              Expanded(
                child: Text(
                  "${quantProduct} Caixas",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  "R\$ ${totalProduc}",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Divider(
              color: Colors.green,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ContainerDegradee({required Color color1, required Color color2}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
    ),
  );
}

Widget containerRelatorio({required String title, required final subtitle}) {
  return Container(
      padding: EdgeInsets.only(left: 32, right: 32),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
          Expanded(
              child: Text(
            subtitle,
            textAlign: TextAlign.end,
          )),
        ],
      ));
}

Widget containerTitles(
    {required String title, required double width, required double height}) {
  return Container(
    width: Get.width * width,
    height: Get.height * height,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );
}

Widget showText(String label, double size) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xff000000),
        fontSize: size,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget showTextTitle(
    {required String label, required double size, required Color color}) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      label,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}

Widget menuContainer(
    {required String image,
    required String label,
    required int page,
    required Color color}) {
  return GestureDetector(
    onTap: () => print(page),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        image: DecorationImage(image: AssetImage(image), scale: 5),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget cardProducts(
    {required BuildContext context,
    required double width,
    required double height,
    required Color color,
    required String image,
    required String label,
    required int page}) {
  return InkWell(
    onTap: () {
      switch (page) {
        case 0:
          Get.to(const CreateProductMolecules());
          break;
        case 1:
          Get.to(ListProductAll(title: "EDITAR PRODUTOS"));
          break;
        case 2:
          Get.to(InactivateProductScreen(title: "INATIVAR PRODUTOS"));
          break;
        case 3:
          Get.to(StockEntryMolecules(title: "CADASTRAR ESTOQUE"));
          break;
        case 4:
          Get.to(AverageCostProductsMolecules(
            title: "CUSTO MÉDIO",
          ));
          break;
        case 5:
          Get.to(
              ProductEntryHistory(title: "HISTÓRICO DE ENTRADA\n DE PRODUTOS"));

        case 6:
          Get.to(InactiveHistoricProductScreen(
              title: "HISTÓRICO PRODUTOS\nINATIVOS"));
      }
    },
    child: Card(
      color: color,
      elevation: 3,
      shadowColor: Colors.black,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Cor da sombra com opacidade
              spreadRadius: 0, // Não espalha a sombra
              blurRadius: 15, // Define a intensidade da sombra
              offset: Offset(0, 4), // Define a posição da sombra
            ),
          ],
        ),
        child: Column(
          children: [
            imageCard(context: context, image: image, opacity: 1),
            SizedBox(
              height: width * 0.01,
            ),
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: TextTitle(
                      label: label,
                      size: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    ).animate().fade(duration: 1000.ms).scale(delay: 500.ms),
  );
}

Widget ContainerTextFieldInt(
    {required TextEditingController inputController,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      controller: inputController,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))],
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle:
            TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

// edit
Widget ContainerTextFieldIntEdit(
    {required TextEditingController quantidade,
    required String product,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      initialValue: product,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))],
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      onChanged: (value) {
        quantidade.text = value;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: label,
        hintText: hint,
        labelStyle:
            TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

Widget ContainerTextFieldText(
    {required TextEditingController inputController,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      controller: inputController,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ú\s\-]'))
      ],
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle:
            TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

// container edição
Widget ContainerTextFieldTextEdit(
    {required TextEditingController titulo,
    required String product,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25, top: 20),
    alignment: Alignment.center,
    height: 85,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(
          color: Colors.black,
          thickness: 3,
        ),
        Expanded(
          child: Text(
            product.toUpperCase(),
            style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        Divider(
          color: Colors.black,
          thickness: 3,
        ),
      ],
    ),
  );
}

Widget ContainerTextFieldDesc(
    {required TextEditingController inputController,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      minLines: 3,
      maxLines: 5,
      controller: inputController,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ú\s\-]'))
      ],
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: label,
        hintText: hint,
        labelStyle:
            TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

// edit
Widget ContainerTextFieldDescEdit(
    {required TextEditingController descripition,
    required String product,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      minLines: 3,
      maxLines: 5,
      initialValue: product,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ú\s\-]'))
      ],
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      onChanged: (value) {
        descripition.text = value;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: label,
        hintText: hint,
        labelStyle:
            TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

Widget ContainerTextFieldFormated(
    {required TextEditingController inputController,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon,
    required var inputFormater}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      controller: inputController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, inputFormater],
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle:
            TextStyle(color: Color(0xffFF000000), fontWeight: FontWeight.bold),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

// edit
Widget ContainerTextFieldFormatedEdit(
    {required TextEditingController preco,
    required String product,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon,
    required var inputFormater}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      initialValue: product,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, inputFormater],
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      onChanged: (value) {
        preco.text = value;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle:
            TextStyle(color: Color(0xffFF000000), fontWeight: FontWeight.bold),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

Widget ContainerTextFieldFormatedEditProduct(
    {required TextEditingController preco,
    required String product,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon,
    required var inputFormater,
    required bool isInteger}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      controller: preco,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        isInteger
            ? FilteringTextInputFormatter.allow(RegExp(r'^\d*$'))
            : inputFormater
      ],
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      onChanged: (value) {
        preco.text = value;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle:
            TextStyle(color: Color(0xffFF000000), fontWeight: FontWeight.bold),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

Widget ContainerTextFieldNumber(
    {required TextEditingController inputController,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      controller: inputController,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]+')),
      ],
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

Widget ContainerTextFieldEmail(
    {required TextEditingController inputController,
    required TextInputType type,
    required String label,
    required String hint,
    required IconData icon}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      controller: inputController,
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty || !value.contains("@")) {
          return "E-mail inválido";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(
          color: Color(0xffFFC4C4C4),
        ),
        suffixIcon: Icon(
          icon,
          color: Color(0xffff1717),
          size: 30,
        ),
      ),
    ),
  );
}

class InputPassword extends StatefulWidget {
  const InputPassword(
      {Key? key,
      required this.inputController,
      required this.type,
      required this.label,
      required this.hint})
      : super(key: key);

  final TextEditingController inputController;
  final TextInputType type;
  final String label;
  final String hint;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool security = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 37, right: 25),
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: widget.inputController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: security,
        validator: (value) {
          if (value!.isEmpty) {
            return "Campo Obrigatório";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          labelStyle: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
          ),
          hintStyle: TextStyle(
            color: Color(0xffFFC4C4C4),
          ),
          suffixIcon: security
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      security = false;
                    });
                  },
                  icon: Icon(
                    Icons.visibility_off_outlined,
                    color: Color(0xffff1717),
                    size: 30,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      security = true;
                    });
                  },
                  icon: Icon(
                    Icons.visibility_outlined,
                    color: Color(0xffff1717),
                    size: 30,
                  ),
                ),
        ),
      ),
    );
  }
}
