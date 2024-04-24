import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/datas_class/client.dart';
import 'package:tg_fatec/models/client_model.dart';
import 'package:tg_fatec/screens/final_create_product_screen.dart';
import '../../atoms/containers/containers_atoms.dart';
import '../../atoms/sizedbox/SizedBox_atoms.dart';

class TemplateCadastroPagesMolecules extends StatefulWidget {
  TemplateCadastroPagesMolecules({Key? key, required this.title, required this.page})
      : super(key: key);

  String title;
  double page;

  @override
  State<TemplateCadastroPagesMolecules> createState() =>
      _TemplateCadastroPagesMoleculesState();
}

class _TemplateCadastroPagesMoleculesState
    extends State<TemplateCadastroPagesMolecules> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final corporateReason = TextEditingController();
  final cpf_cnpj = TextEditingController();
  final cep = TextEditingController();
  final street = TextEditingController();
  final neighborhood = TextEditingController();
  final complemento = TextEditingController();
  final city = TextEditingController();
  final number = TextEditingController();
  final phoneNumber = TextEditingController();
  final emailAdrress = TextEditingController();

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
                showTextTitle(
                    label: "CADASTRAR ${widget.title}",
                    size: 20,
                    color: Colors.red),
                SizeHeight(height: size.width, multiplier: 0.07),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ContainerTextFieldText(
                          inputController: name,
                          type: TextInputType.text,
                          label: "Nome",
                          hint: "Digite o Nome",
                          icon: Icons.person_outline_outlined),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldText(
                          inputController: corporateReason,
                          type: TextInputType.text,
                          label: "Razão Social",
                          hint: "Digite a Razão Social",
                          icon: Icons.corporate_fare),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldFormated(
                          inputController: cpf_cnpj,
                          label: "CPF/CNPJ",
                          type: TextInputType.number,
                          hint: "Digite CPF/CNPJ",
                          icon: Icons.document_scanner_outlined,
                          inputFormater: CpfOuCnpjFormatter()),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldEmail(
                        inputController: emailAdrress,
                        label: "E-mail",
                        type: TextInputType.emailAddress,
                        hint: "Digite o E-mail",
                        icon: Icons.alternate_email,
                      ),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldFormated(
                          inputController: phoneNumber,
                          label: "Telefone",
                          type: TextInputType.number,
                          hint: "Digite o Telefone",
                          icon: Icons.phone_android,
                          inputFormater: TelefoneInputFormatter()),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldFormated(
                          inputController: cep,
                          label: "CEP",
                          type: TextInputType.number,
                          hint: "Digite o CEP",
                          icon: Icons.location_on_outlined,
                          inputFormater: CepInputFormatter()),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldText(
                        inputController: street,
                        label: "Rua",
                        type: TextInputType.text,
                        hint: "Digite o Nome da Rua",
                        icon: Icons.maps_home_work_outlined,
                      ),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldText(
                        inputController: neighborhood,
                        label: "Bairro",
                        type: TextInputType.text,
                        hint: "Digite o Nome do Bairro",
                        icon: Icons.maps_home_work_outlined,
                      ),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldText(
                        inputController: complemento,
                        label: "Complemento",
                        type: TextInputType.text,
                        hint: "Digite o Complemento",
                        icon: Icons.maps_home_work_outlined,
                      ),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldNumber(
                        inputController: number,
                        label: "Número/Apartamento",
                        type: TextInputType.text,
                        hint: "Digite o Numero",
                        icon: Icons.numbers,
                      ),
                      SizeHeight(height: size.width, multiplier: 0.04),
                      ContainerTextFieldText(
                        inputController: city,
                        label: "Cidade",
                        type: TextInputType.text,
                        hint: "Digite a Cidade",
                        icon: Icons.location_city_sharp,
                      ),
                      SizeHeight(height: size.width, multiplier: 0.08),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 4,
                  child: OutlinedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        Client client = Client.data(
                            nome: name.text,
                            razao_social: corporateReason.text,
                            cpfCnpj: cpf_cnpj.text,
                            email: emailAdrress.text,
                            telefone: phoneNumber.text,
                            cep: cep.text,
                            rua: street.text,
                            bairro: neighborhood.text,
                            complemento: complemento.text,
                            numero: number.text,
                            cidade: city.text,
                            categoria: widget.page == 0? "cliente" : "fornecedor");
                        Logger().e(client.toMap());
                        bool res = await ClienteModel.of(context)
                            .createClient(data: client.toMap());
                        if (res) {
                          Get.to(FinalPage(
                              label: widget.page == 0? "CLIENTE": "FORNECEDOR",
                              title:
                                  "O ${corporateReason.text} foi cadastrado com sucesso", page: 0,));
                        } else {
                          Get.showSnackbar(const GetSnackBar(
                            title: "Erro ao salvar Cliente",
                            message: "Tente Novamente",
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
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
}
