import 'package:flutter/material.dart';
import 'package:tg_fatec/molecules/Edit_product_molecules/list_product_all_molecules.dart';
import 'package:tg_fatec/screens/home_screen.dart';
import 'package:tg_fatec/screens/product_screen.dart';
import 'package:get/get.dart';

class FinalPage extends StatelessWidget {
  FinalPage({required this.label, required this.title, required this.page});

  String label;
  String title;
  int page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //atualizar página que vai ser redirecionada
        backgroundColor: Colors.red.withOpacity(0.6),
        title: Text(
          label.toUpperCase(),
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              switch (page) {
                case 0:
                case 1:
                Get.offAll(HomeScreen());
                break;
                case 2:
                  Get.back();
                  Get.back();
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80.0,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
