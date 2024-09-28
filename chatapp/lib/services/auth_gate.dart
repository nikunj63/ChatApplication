import 'package:chatapp/pages/home_pag.dart';
import 'package:chatapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context,snapshot){
          // user is loggrd in
          if (snapshot.hasData) {
            return const HomePage();
          }
          // user is not logged in
          else{
            return const LoginOrRegister(); 
          }

         }
         ),
    );
  }
}