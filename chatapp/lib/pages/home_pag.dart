import 'package:chatapp/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // sign User out
  void signOut(){
    // get auth service
    final authServices = Provider.of<AuthServices>(context,listen: false);
    authServices.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        title: Text("HomePage"
        ),
        actions: [
          // signOut button
          IconButton(
            onPressed: signOut, 
            icon: Icon(Icons.logout)
            )
        ],
      ),
    );
  }
}