import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gif/gif.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/atoms/imagens/images_atoms.dart';
import 'package:tg_fatec/atoms/sizedbox/SizedBox_atoms.dart';
import 'package:tg_fatec/atoms/texts/texts_atoms.dart';
import 'package:tg_fatec/models/user_model.dart';
import 'package:tg_fatec/molecules/Create_user_pages_molecules/create_user_pages_molecules.dart';
import 'package:tg_fatec/screens/home_screen.dart';

import '../../atoms/containers/containers_atoms.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  // ***************** formulario e controladores ****************************
  final formKey = GlobalKey<FormState>();
  final cpfEmailController = TextEditingController();
  final passwordController = TextEditingController();
  late GifController gifController;
  final _box = GetStorage();

  @override
  void initState() {
    gifController = GifController(
      vsync: this,
    );
    gifController.repeat(
      max: 1,
      min: 1,
      period: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
            backgroundColor: const Color(0xffffffff),
            body: ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                if (model.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        27, size.height * 0.03, 27, size.height * 0.03),
                    child: Column(
                      children: [
                        // ************* imagem inicial *************************
                        imageLogin(
                            context: context,
                            image: "assets/images/tomate_desenho.png"),
                        // Gif(
                        //   autostart: Autostart.loopdenis
                        //   placeholder: (context) =>
                        //   const Center(child: CircularProgressIndicator()),
                        //   image: const AssetImage('assets/images/tomato.gif'),
                        // ),
                        SizeHeight(height: size.height, multiplier: 0.03),
                        // *************** texto bemvindo*******************************
                        showTextTitle(
                            label: "Bem-vindo",
                            size: 25,
                            color: const Color(0xff000000)),
                        SizeHeight(height: size.width, multiplier: 0.02),
                        showTextTitle(
                            label: "LEGUMES DO CHICÃO",
                            size: 20,
                            color: Colors.red),
                        SizeHeight(height: size.width, multiplier: 0.02),
                        showText(
                            "Para começar insira os dados de\n usuário e senha.",
                            16),
                        SizeHeight(height: size.width, multiplier: 0.06),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Card(
                                child: ContainerTextFieldEmail(
                                    inputController: cpfEmailController,
                                    type: TextInputType.emailAddress,
                                    label: "E-mail",
                                    hint: "Digite o E-mail",
                                    icon: Icons.alternate_email),
                              ),
                              SizeHeight(height: size.height, multiplier: 0.02),
                              Card(
                                child: InputPassword(
                                    inputController: passwordController,
                                    type: TextInputType.visiblePassword,
                                    label: "Senha",
                                    hint: "Digite a Senha"),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    if (cpfEmailController.text.isEmpty) {
                                      _onEmailIsEmpry();
                                    } else {
                                      model
                                          .recoverPass(cpfEmailController.text);
                                      _onEmailIsSucess();
                                    }
                                  },
                                  child: const Text(
                                    "Esqueci minha senha",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              SizeHeight(height: size.height, multiplier: 0.04),
                            ],
                          ),
                        ),

                        Container(
                          width: size.width * 0.90,
                          height: size.height * 0.05,
                          child: OutlinedButton(
                            onPressed: () {
                              model.signin(
                                  email: cpfEmailController.text,
                                  pass: passwordController.text,
                                  onSucess: _onSucess,
                                  onFail: _onFail);
                            },
                            child: const Text(
                              "ENTRAR",
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                        TextTitle(
                            label: "OU",
                            size: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        Container(
                          width: size.width * 0.9,
                          height: size.height * 0.05,
                          child: OutlinedButton(
                            onPressed: () {
                              Get.to(CreateUserPage(
                                title: "USUÁRIO",
                              ));
                            },
                            child: const Text(
                              "CADASTRE-SE",
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xffFA8F00),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  void _onSucess() {
    Get.offAll(HomeScreen());
  }

  void _onFail() {
    Get.snackbar("Falha ao Logar Usuário",
        "Verifique seu email e senha e tente novamente",
        backgroundColor: Colors.red,
        colorText: const Color(0xffffffff),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM);
  }

  void _onEmailIsEmpry() {
    Get.snackbar("Campo de Email vázio", "Insira seu email para recuperação",
        backgroundColor: Colors.red,
        colorText: const Color(0xffffffff),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM);
  }

  void _onEmailIsSucess() {
    Get.snackbar("Verifique seu email", "Enviamos a redefinição para seu email",
        backgroundColor: Colors.red,
        colorText: const Color(0xffffffff),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM);
  }
}
