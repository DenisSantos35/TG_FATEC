import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import '../auth/Login/login_page.dart';

class UserModel extends Model {
  bool isLoading = false;

  static UserModel of(BuildContext context) => ScopedModel.of(context);
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrenteUser();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser;

  Map<String, dynamic> userData = {};

  void signup(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSucess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      String id = user.user!.uid;

      await _saveUserData(userData, id);
      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signin(
      {required String email,
      required String pass,
      required VoidCallback onSucess,
      required VoidCallback onFail}) async {
    final _box = GetStorage();
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      await _loadCurrenteUser();
      onSucess();
      isLoading = true;
      Logger().e(user);
      _box.write("load", true);
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      _box.write("load", false);
      notifyListeners();
    });
  }

  void signOut() async {
    final _box = GetStorage();
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;
    _box.write("load", false);

    notifyListeners();
    Get.offAll(Login());
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData, String id) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection("USUARIO")
        .doc(id)
        .set(userData);
  }

  Future<Null> _loadCurrenteUser() async {
    final _box = GetStorage();
    if (firebaseUser == null) firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot<Map<String, dynamic>> docUser = await FirebaseFirestore
            .instance
            .collection("USUARIO")
            .doc(firebaseUser!.uid)
            .get();
        userData = docUser.data()!;
        Logger().e(userData);
        _box.write("dataUser", userData);
      }
    }
    notifyListeners();
  }
}
