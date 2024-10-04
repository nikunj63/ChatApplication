import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatServices extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // send message
  Future<void> sendMessage(String receiverId, String message)async{
    // get current user Info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create new message

    Message newMessage = Message(
      senderId: currentUserId, 
      senderEmail: currentUserEmail, 
      message: message,
       timestamp: timestamp, 
       receiverId: receiverId,
       );

    // construct chat room id from current user id and receiver id
    List<String> ids= [currentUserId ,receiverId];
    ids.sort(); // sort the ids(this ensures that chat room id is always these same for any pair of people )
    String chatRoomId = ids.join("_");// combines the ids into single string to use as a chatroomID

    // add new message to database
    await _firestore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('messages')
    .add(newMessage.toMap());
  }

  // get massage
  Stream<QuerySnapshot> getMesssages(String userId , String otheruserId){
    // copy chatroomId from user ids(sorted to ensure it matches the id used when sending messages)
    List<String> ids = [userId ,otheruserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('message')
    .orderBy('timestamp' , descending: false)
    .snapshots();
  }
}