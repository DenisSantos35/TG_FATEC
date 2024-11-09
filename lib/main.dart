import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tg_fatec/atoms/dialog/dialog_atoms.dart';
import 'package:tg_fatec/models/cart_model.dart';
import 'package:tg_fatec/models/client_model.dart';
import 'package:tg_fatec/models/product_model.dart';
import 'package:tg_fatec/models/report_model.dart';
import 'package:tg_fatec/models/user_model.dart';
import 'package:tg_fatec/screens/home_screen.dart';
import 'auth/introduction_page/introduction_page.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize localization for date formatting
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  // Inicialize a formatação de data para pt_BR
  // await initializeDateFormatting('pt_BR',"");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// This widget is the root of your application.
  final _box = GetStorage();
  bool _isLoad = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoad = _box.read("load") ?? false;
  }

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
                                appBarTheme: AppBarTheme(
                                    iconTheme:
                                        IconThemeData(color: Colors.white)),
                                colorScheme:
                                    ColorScheme.fromSeed(seedColor: Colors.red),
                                primaryColor: Colors.red,
                                useMaterial3: true,
                              ),
                              home: _isLoad ? HomeScreen() : InitPage(),
                              //HomeScreen()
                            ),
                          )))),
            );
          },
        ));
  }
}
