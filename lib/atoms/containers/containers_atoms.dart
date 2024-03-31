import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
    ),
  );
}


Widget menuContainer({required String image,
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

Widget cardProducts({required BuildContext context,
  required double width,
  required double height,
  required Color color,
  required String image,
  required String label,
  required int page}) {
  return GestureDetector(
    onTap: () {
      print(page);
    },
    child: Card(
      shadowColor: Colors.black,
      color: color,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: width * 0.85,
        height: height * 0.15,
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
    ),
  );
}

Widget ContainerTextFieldText({
  required TextEditingController inputController,
  required TextInputType type,
  required String label,
  required String hint,
  required IconData icon}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 80,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(50),
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
        labelStyle: TextStyle(
            color: Color(0xff000000),
            fontWeight: FontWeight.bold
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

Widget ContainerTextFieldFormated(
    {required TextEditingController inputController,
      required TextInputType type,
      required String label,
      required String hint,
      required IconData icon,
      required var inputFormater
    }) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 80,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(50),
    ),
    child: TextFormField(
      controller: inputController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        inputFormater
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
            color: Color(0xffFF000000),
            fontWeight: FontWeight.bold
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

Widget ContainerTextFieldNumber({
  required TextEditingController inputController,
  required TextInputType type,
  required String label,
  required String hint,
  required IconData icon
}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 80,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(50),
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

Widget ContainerTextFieldEmail({required TextEditingController inputController,
  required TextInputType type,
  required String label,
  required String hint,
  required IconData icon
}) {
  return Container(
    padding: EdgeInsets.only(left: 37, right: 25),
    height: 80,
    decoration: BoxDecoration(
      color: Color(0xfff5f5f5),
      borderRadius: BorderRadius.circular(50),
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
  const InputPassword({Key? key, required this.inputController,
    required this.type,
    required this.label,
    required this.hint }) : super(key: key);

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
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(50),
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