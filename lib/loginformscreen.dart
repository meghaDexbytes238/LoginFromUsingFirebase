import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'authentication.dart';
class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 // ValueNotifier userCredential = ValueNotifier('');
   signInWithGoogle() async {
     final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if(googleUser != null){
        final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
        final AuthCredential crediential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await _firebaseAuth.signInWithCredential(crediential);
      }
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(children: [
          TextFormField(decoration: InputDecoration(border: OutlineInputBorder(),
          hintText: 'email'
          ),),
            TextFormField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'password'),
          ),
ElevatedButton(
    onPressed: () async {
      signInWithGoogle();
},
    child: Text('Sing with google'),
)
        ],),
      ),
    );
  }

}
