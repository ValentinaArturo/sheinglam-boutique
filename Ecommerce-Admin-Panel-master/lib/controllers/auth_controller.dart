import 'package:ecommerce_admin_panel/models/UserModel.dart';
import 'package:ecommerce_admin_panel/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthController extends ChangeNotifier {
  // login with email and password
  bool isloadingSignIn = false;
  String errorMessage = "";

  UserModel? currentuserModel;


  Future<UserModel?> signIn(String email, String password) async {
    UserModel? userModel;
    isloadingSignIn = true;
    notifyListeners();
    try {

    } catch (e) {
      isloadingSignIn = false;

      errorMessage = e.toString();
      notifyListeners();
      //  print(e.toString());
    }
    return currentuserModel;
  }

  bool showpassword = false;
  onchangepasswordvisibility() {
    showpassword = !showpassword;
    notifyListeners();
  }

  Future SignOut() async {
    currentuserModel = null;
    notifyListeners();
  }
}
