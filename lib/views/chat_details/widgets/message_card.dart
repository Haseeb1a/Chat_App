import 'package:chatx/constrains/base_objects.dart';
import 'package:chatx/model/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    
    return Base.auth.currentUser!.uid == message.formId?
     anotherUserMessage(message.msg, message.sent):
         currentUserMessage(message.msg, message.sent);
        
  }
}

Widget currentUserMessage(String messages, String time) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Padding(padding: EdgeInsets.only(right: 0,left: 0)),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              // color: Colors.black.withOpacity(0.2)
            ),
            child: Text(
              messages,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            time,
            style:
                TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

Widget anotherUserMessage(String messages, String time) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
          horizontal: 5,
        )),

        Row(
          children: [
            Icon(
              Icons.done_all_outlined,
              color: Colors.blue,
              size: 17,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                time,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4), fontSize: 13),
              ),
            ),
          ],
        ),
        Spacer(),
        // SizedBox(
        //   width: 15,
        // ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsetsDirectional.symmetric(horizontal: 13),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              // color: Colors.black.withOpacity(0.2)
            ),
            child: Text(
              messages,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ),
      ],
    ),
  );
}
