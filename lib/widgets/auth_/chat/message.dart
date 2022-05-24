import 'package:chat/widgets/auth_/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
        builder: (ctx,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          final doc = snapshot.data!.docs;
          return ListView.builder(
            
            reverse: true,
            itemCount: doc.length,
              itemBuilder: (ctx , index)=>MessageBubble(
                message: doc[index]['text'],
                username: doc[index]['username'],
                isMe: false,
                key: ValueKey('mm'),

               //isMe:doc[index]['userId'] == FirebaseAuth.instance.currentUser?.uid,
                //key: ValueKey('m1'),
              )
          );
        }
      );
  }
}