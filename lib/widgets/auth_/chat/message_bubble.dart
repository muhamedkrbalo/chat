import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.isMe,  required this.message,required this.username,required this.key,}) ;
final Key key;
final bool isMe;
 final String message;
final String username;


  @override
  Widget build(BuildContext context) {
    return Row(
      
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Colors.deepPurple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: isMe ? Radius.circular(0): Radius.circular(14),
              bottomRight: isMe ? Radius.circular(0): Radius.circular(14),
            )
          ),
          width: MediaQuery.of(context).size.width*0.4,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: Column(
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe ? Colors.black : Colors.white
                ),
              ),
              Text(
                message,
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe ? Colors.black : Colors.white
                ),
                textAlign:  isMe? TextAlign.end : TextAlign.start,
                
              )
            ],
          ),
        ),


      ],
    );
  }
}