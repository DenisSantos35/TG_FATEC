import 'package:flutter/material.dart';
import 'package:tg_fatec/datas_class/colors.dart';

import '../Login/login_page.dart';

class InitPage extends StatefulWidget {
  InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage>{

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorsApp.blueColor(),
      
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: size.width * 0.8,
            height: size.height * 0.8,
            decoration: BoxDecoration(
                color: ColorsApp.blueColor(),
                image: DecorationImage(
                  image: AssetImage('assets/images/tomate_desenho.png'),
                )
            )

          )
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    awaitPage(context);

  }

  Future<void> awaitPage(BuildContext context) async {
    // Aguarda 2 segundos (altere o valor do 'Duration' conforme necessário)
    await Future.delayed(Duration(seconds: 4));

    // Navegar para a próxima página
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
}
