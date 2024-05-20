import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/models/user_model.dart';
import '../../atoms/containers/containers_atoms.dart';
import '../../atoms/sizedbox/SizedBox_atoms.dart';
import '../../auth/Login/login_page.dart';


class CreateUserPage extends StatefulWidget {
  CreateUserPage({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final formKeyUser = GlobalKey<FormState>();
  final name = TextEditingController();
  final cpf_cnpj = TextEditingController();
  final emailAdrress = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phoneNumber = TextEditingController();

  //fazer tratamento de senha e confirmar senha
  //buscar endereço na via cep
  //criar um cabeçalho
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffffffff),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.red,
            toolbarHeight: size.height * 0.1,
            title: showTextTitle(
                label: "CADASTRAR ${widget.title}",
                size: 20,
                color: Colors.white),
          ),
          body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if (model.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );
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
                                  inputController: name,
                                  type: TextInputType.text,
                                  label: "Nome",
                                  hint: "Digite o Nome",
                                  icon: Icons.person_outline_outlined),
                            ),
                            SizeHeight(height: size.width, multiplier: 0.04),
                            Card(
                              child: ContainerTextFieldFormated(
                                  inputController: cpf_cnpj,
                                  label: "CPF",
                                  type: TextInputType.number,
                                  hint: "Digite CPF/CNPJ",
                                  icon: Icons.document_scanner_outlined,
                                  inputFormater: CpfOuCnpjFormatter()),
                            ),
                            SizeHeight(height: size.width, multiplier: 0.04),
                            Card(
                              child: ContainerTextFieldEmail(
                                inputController: emailAdrress,
                                label: "E-mail",
                                type: TextInputType.emailAddress,
                                hint: "Digite o E-mail",
                                icon: Icons.alternate_email,
                              ),
                            ),
                            SizeHeight(height: size.width, multiplier: 0.04),
                            Card(
                              child: ContainerTextFieldFormated(
                                  inputController: phoneNumber,
                                  label: "Telefone",
                                  type: TextInputType.number,
                                  hint: "Digite o Telefone",
                                  icon: Icons.phone_android,
                                  inputFormater: TelefoneInputFormatter()),
                            ),
                            SizeHeight(height: size.width, multiplier: 0.04),
                            Card(
                              child: InputPassword(
                                  inputController: password,
                                  type: TextInputType.visiblePassword,
                                  label: "Senha",
                                  hint: "Digite a Senha"),
                            ),
                            SizeHeight(height: size.width, multiplier: 0.04),
                            Card(
                              child: InputPassword(
                                  inputController: confirmPassword,
                                  type: TextInputType.visiblePassword,
                                  label: "Confirmar Senha",
                                  hint: "Confirmação da Senha"),
                            ),
                            SizeHeight(height: size.width, multiplier: 0.08),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 0.5,
                        height: size.height * 0.04,
                        child: OutlinedButton(
                          onPressed: () {
                            Map<String, dynamic> userData = {
                              "name": name.text,
                              "cpf": cpf_cnpj.text,
                              "email": emailAdrress.text,
                              "telefone": phoneNumber.text,
                            };
                            model.signup(
                                userData: userData,
                                pass: password.text,
                                onSucess: _onSucess,
                                onFail: _onFail);
                          },
                          child: Text(
                            "CADASTRAR",
                            style: TextStyle(
                              color: Color(0xffffffff),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
    ;
  }

  void _onSucess() {
    Get.snackbar("Usuário criado com sucesso!", "",
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM);
    Future.delayed(Duration(seconds: 2)).then((_) {
      Get.back();
      Get.to(Login());
    });
  }

  void _onFail() {
    Get.snackbar("Falha ao criar usuário!", "Email já cadastrado",
        backgroundColor: Colors.red,
        colorText: Color(0xffffffff),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM);
    Future.delayed(Duration(seconds: 2)).then((_) {
      Get.back();
    });
  }
}
