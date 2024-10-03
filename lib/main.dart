import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/atoms/dialog/dialog_atoms.dart';
import 'package:tg_fatec/models/cart_model.dart';
import 'package:tg_fatec/models/client_model.dart';
import 'package:tg_fatec/models/product_model.dart';
import 'package:tg_fatec/models/report_model.dart';
import 'package:tg_fatec/models/user_model.dart';
import 'auth/introduction_page/introduction_page.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize localization for date formatting
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inicialize a formatação de data para pt_BR
  // await initializeDateFormatting('pt_BR',"");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: ScopedModel<ProductModel>(
                  model: ProductModel(),
                  child: ScopedModel<DialogDefault>(
                      model: DialogDefault(),
                      child: ScopedModel<ClienteModel>(
                          model: ClienteModel(),
                          child: ScopedModel<ReportModel>(
                            model: ReportModel(),
                            child: GetMaterialApp(
                              title: 'Flutter Demo',
                              theme: ThemeData(
                                appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
                                colorScheme:
                                    ColorScheme.fromSeed(seedColor: Colors.red),
                                primaryColor: Colors.red,
                                useMaterial3: true,
                              ),
                              home: InitPage(),
                              //HomeScreen()
                            ),
                          )))),
            );
          },
        ));
  }
}
