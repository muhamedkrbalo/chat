import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _contrller = TextEditingController();
  String _enteredMessages ='';
  _sendMessage()async{
    //FocusScope.of(context).unfocus();
    final user =  FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    FirebaseFirestore.instance
                .collection('chat').add({'text': _enteredMessages,'createdAt':Timestamp.now(),
                'username': userData['username'],
                'userId':user?.uid,
                });
    _contrller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(child: TextField(
            controller: _contrller,
            decoration: InputDecoration(labelText: 'Send a message'),
            onChanged: (val){
              setState(() {
                //val =_enteredMessages;
                _enteredMessages = val;
              });
            },
          ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon:Icon (Icons.send),
            onPressed: _enteredMessages.trim().isEmpty ? null : _sendMessage,
            )
        ],
      ),
    );
  }
}