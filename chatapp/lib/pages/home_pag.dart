import 'package:chatapp/pages/chat_page.dart';
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
  void signOut() {
    // get auth service
    final authServices = Provider.of<AuthServices>(context, listen: false);
    authServices.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        title: const Text("HomePage"),
        actions: [
          // signOut button
          IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: _buildUserList(), // Updated this line
    );
  }

  // build a list of users except for the current logged-in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading...");
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(context, doc)) // Updated this line
              .toList(),
        );
      },
    );
  }

  // build individual user list items
  Widget _buildUserListItem(BuildContext context, DocumentSnapshot document) { // Renamed and passed context
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users except current user
    if (_auth.currentUser!.email != data["email"]) { // Use _auth here, as it's part of the class
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          // pass the user's UID to the chatPage
          Navigator.push(
            context, // Pass the context here
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      // return empty container
      return Container();
    }
  }
}
