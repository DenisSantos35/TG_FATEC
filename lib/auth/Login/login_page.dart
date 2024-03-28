import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tg_fatec/atoms/imagens/images_atoms.dart';
import 'package:tg_fatec/atoms/texts/texts_atoms.dart';
import 'package:tg_fatec/screens/home_screen.dart';

import '../../atoms/containers/containers_atoms.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // ***************** formulario e controladores ****************************
  final formKey = GlobalKey<FormState>();
  final cpfController = TextEditingController();
  final senhaController = TextEditingController();
  bool security = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                27, size.height * 0.03, 27, size.height * 0.03),
            child: Column(
              children: [
                // ************* imagem inicial *************************
                imageLogin(context: context, image: "assets/images/tomate_desenho.png"),
                SizedBox(height: size.height * 0.03,),
                // *************** texto bemvindo*******************************
                showText("Bem-vindo", 25),
                SizedBox(
                  height: size.width * 0.02,
                ),
                showText("Legumes do Chicão", 20),
                SizedBox(
                  height: size.width * 0.02,
                ),
                showText(
                    "Para começar insira os dados de\n usuário e senha.", 16),
                SizedBox(
                  height: size.width * 0.12,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 37, right: 25),
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xfff5f5f5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextFormField(
                          controller: cpfController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Campo Obrigatório";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Color(0xffFFC4C4C4),
                            ),
                            suffixIcon: Icon(
                              Icons.person_outline_outlined,
                              color: Color(0xffff1717),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 37, right: 25),
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xfff5f5f5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextFormField(
                          controller: senhaController,
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
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Color(0xffFFC4C4C4),
                            ),
                            suffixIcon: security?IconButton(
                              onPressed: () { setState(() {
                                security = false;
                              });},
                              icon: Icon(Icons.visibility_off_outlined,
                                color: Color(0xffff1717),
                                size: 30,),
                            ): IconButton(
                              onPressed: () { setState(() {
                                security = true;
                              });},
                              icon: Icon(Icons.visibility_outlined,
                                color: Color(0xffff1717),
                                size: 30,),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.08,),
                Container(
                  width: size.width * 4,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(HomeScreen());
                      print("logar");
                    },
                    child: Text(
                      "ENTRAR",
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xffff1717),
                    ),
                  ),
                ),
                textTitle(label: "OU", size: 18, fontWeight: FontWeight.bold, color: Colors.black),
                Container(
                  width: size.width * 4,
                  child: OutlinedButton(
                    onPressed: () {

                      print('aqui');
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
        ),
      ),
    );
  }

  // *********** criacao de widget ********************************************

}
