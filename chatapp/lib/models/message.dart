import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String senderEmail;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.message,
    required this.timestamp,
    required this.receiverId,
  });
  // convert to a map
  Map<String , dynamic> toMap(){
    return{
      'senderId':senderId,
      'senderEmail': senderEmail,
      'receiverID':receiverId,
      'message':message,
      'timestamp':timestamp,

    };
  }
}