import 'package:chatapp/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;


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
        title:const Text(
          "HomePage"
        ),
        actions: [
          // signOut button
          IconButton(
            onPressed: signOut, 
            icon: const Icon(Icons.logout)
            )
        ],
      ),
      body: _builderUserList(),
    );
  }
}

Widget _builderUserList(DocumentSnapshot document){
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
     builder: (context,snapshot){
      if (snapshot.hasError) {
        return const Text("Error");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("loading...");
      }
      return ListView(
        children:snapshot.data!.docs.
        map<Widget>((doc)=> _builderUserList(doc)).toList(),
      );
     }
    );
}