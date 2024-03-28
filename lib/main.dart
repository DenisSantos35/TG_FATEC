import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tg_fatec/screens/home_screen.dart';
import 'auth/introduction_page/introduction_page.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
  // FirebaseFirestore db = FirebaseFirestore.instance;
  //
  // db.collection("Teste").doc().set({
  //   "Salvando": "Savando"
  // });
}

class MyApp extends StatelessWidget {
MyApp({super.key});

// This widget is the root of your application.
@override
Widget build(BuildContext context) {
  return GetMaterialApp(
      title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      primaryColor: Colors.red,
      useMaterial3: true,
    ),
    home:InitPage(),
    //HomeScreen()
  );
}
}