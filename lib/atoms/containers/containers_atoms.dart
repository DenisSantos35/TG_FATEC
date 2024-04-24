import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/molecules/Edit_product_molecules/edit_product_molecules.dart';
import 'package:tg_fatec/molecules/Edit_product_molecules/list_product_all_molecules.dart';
import 'package:tg_fatec/molecules/Inactivate_product_molecules/inactivate_product_molecule.dart';
import 'package:tg_fatec/molecules/Inactive_historic_molecules/inactive_historic_molecules.dart';

import '../../molecules/Create_product_pages_molecules/create_product_molecules.dart';
import '../imagens/images_atoms.dart';
import '../texts/texts_atoms.dart';

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
        borderRadius: BorderRadius.circular(10),
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
  return GestureDetector(
    onTap: () {
      switch (page) {
        case 0:
          Get.to(const CreateProductMolecules());
        case 1:
          Get.to(ListProductAll(title: "EDITAR PRODUTOS"));
        case 2:
          Get.to(InactivateProductScreen(title: "INATIVAR PRODUTOS"));
        case 6:
          Get.to(InactiveHistoricProductScreen(
              title: "HISTÓRICO PRODUTOS\nINATIVOS"));
      }
    },
    child: Card(
      shadowColor: Colors.black,
      color: color,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: width * 0.85,
        height: height * 0.11,
        child: Row(
          children: [
            imageCard(context: context, image: image, opacity: 1),
            SizedBox(
              width: width * 0.03,
            ),
            Expanded(
                child: textTitle(
                    label: label,
                    size: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white))
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
      borderRadius: BorderRadius.circular(30),
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
      borderRadius: BorderRadius.circular(30),
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
      borderRadius: BorderRadius.circular(30),
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
    height: 70,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            product.toUpperCase(),
            style:
            TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Divider(),
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
      borderRadius: BorderRadius.circular(20),
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
      borderRadius: BorderRadius.circular(20),
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
      borderRadius: BorderRadius.circular(30),
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
        border: InputBorder.none,
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
      borderRadius: BorderRadius.circular(30),
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
        border: InputBorder.none,
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
      borderRadius: BorderRadius.circular(30),
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
      borderRadius: BorderRadius.circular(30),
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
        borderRadius: BorderRadius.circular(30),
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
          border: InputBorder.none,
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
