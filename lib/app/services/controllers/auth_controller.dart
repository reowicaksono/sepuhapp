import 'package:get/get.dart';

//firebase auth
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sepuhapp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  //Login User Auth
  void login(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      //isEmailVerified ?
      if (credential.user?.emailVerified == true) {
        Get.defaultDialog(title: "you login");
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(title: "youre not in logged");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //Create User Auth
  void register(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
