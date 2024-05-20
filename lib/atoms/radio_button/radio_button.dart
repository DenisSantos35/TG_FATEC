import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/atoms/texts/texts_atoms.dart';

import '../containers/containers_atoms.dart';

enum UnitOfMensurement { caixa, kg }

class RadioButton extends StatefulWidget {
  RadioButton({required this.label1, required this.label2, required this.typeMensurament });

  String label1;
  String label2;
  TextEditingController typeMensurament;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  UnitOfMensurement _unitOfMeasurement = UnitOfMensurement.caixa;

  @override
  Widget build(BuildContext context) {
    widget.typeMensurament.text = _unitOfMeasurement.toString().replaceAll("UnitOfMensurement.", "");
    return Column(
      children: [
        Divider(
          height: Get.height * 0.03,
          indent: 8,
          endIndent: 8,
          thickness: 2,
          color: Colors.black,
        ),
        containerTitles(
            title: "ESCOLHA Á UNIDADE DE MEDIDA:",
            width: 0.85,
            height: 0.03),
        Divider(
          height: Get.height * 0.03,
          indent: 8,
          endIndent: 8,
          thickness: 2,
          color: Colors.black,
        ),
        Card(
          child: Container(
            padding: EdgeInsets.only(left: 37, right: 25),
          
            decoration: BoxDecoration(
              color: Color(0xfff5f5f5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              horizontalTitleGap: 0.1,
              title: Text(
                widget.label1,
                style: const TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              leading: Radio<UnitOfMensurement>(
                visualDensity: VisualDensity.comfortable,
                value: UnitOfMensurement.caixa,
                groupValue: _unitOfMeasurement,
                onChanged: (UnitOfMensurement? value) {
                  setState(() {
                    _unitOfMeasurement = value!;
                    widget.typeMensurament.text = _unitOfMeasurement.toString().replaceAll("UnitOfMensurement.", "");
                  });
                },
                fillColor: MaterialStateProperty.resolveWith((Set states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.black;
                  }
                  return Colors.black;
                }),
              ),
            ),
          ),
        ),
        SizedBox(height: 2,),
        Card(
          child: Container(
            padding: EdgeInsets.only(left: 37, right: 25),
          
            decoration: BoxDecoration(
              color: Color(0xfff5f5f5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              horizontalTitleGap: 0.1,
              title: Text(
                widget.label2,
                style: const TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              leading: Radio<UnitOfMensurement>(
                visualDensity: VisualDensity.comfortable,
                value: UnitOfMensurement.kg,
                groupValue: _unitOfMeasurement,
                onChanged: (UnitOfMensurement? value) {
                  setState(() {
                    _unitOfMeasurement = value!;
                    widget.typeMensurament.text = _unitOfMeasurement.toString().replaceAll("UnitOfMensurement.", "");
                    Logger().e(_unitOfMeasurement);
                  });
                },
                fillColor: MaterialStateProperty.resolveWith((Set states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.black;
                  }
                  return Colors.black;
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
