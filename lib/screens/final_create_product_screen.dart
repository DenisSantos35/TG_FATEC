import 'package:flutter/material.dart';
import 'package:tg_fatec/datas_class/colors.dart';
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
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        //atualizar página que vai ser redirecionada
        backgroundColor: ColorsApp.blueColor(),
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
                  Get.back();
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: ColorsApp.blueColor(),
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
      body: Center(
        child: Container(
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
      ),
    );
  }
}
