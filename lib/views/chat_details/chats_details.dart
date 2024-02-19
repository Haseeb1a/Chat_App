import 'package:chatx/controllers/details_page.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:chatx/model/message_model.dart';
import 'package:chatx/services/message_services.dart';
import 'package:chatx/views/chat_details/widgets/message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final ChatUser user;

  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatController = Provider.of<ChatController>(context);
    final TextEditingController text = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        // leading:  IconButton(onPressed: (), icon: icon),
        title: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  user.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Text('Last seen not available', style: TextStyle(fontSize: 15))
              ],
            ),
          ],
        ),

        automaticallyImplyLeading: false,
        // flexibleSpace: _appBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: MessageServices.getAllMessages(user),
              builder: (context, snapshot) {
                List<String> ss = [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  // List<String> demy = ["hi", "how are you"];
                  final data = snapshot.data?.docs;
                  final users =
                      data?.map((e) => Message.fromJson(e.data())).toList() ??
                          [];
                  // chatController.messages.clear();
                  // chatController.messages.add(Message(
                  //     told: 'xxx',
                  //     msg: 'hikkkk',
                  //     read: '',
                  //     type: Type.text,
                  //     formId: Base.auth.currentUser!.uid,
                  //     sent: "12.00 AM"));
                  // chatController.messages.add(Message(
                  //     told: Base.auth.currentUser!.uid,
                  //     msg: "hello",
                  //     read: '',
                  //     type: Type.text,
                  //     formId: "xyz",
                  //     sent: "12:05 AM"));
                  return users.isNotEmpty
                      ? ListView.builder(
                          itemCount: users.length,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 5),
                          // itemCount: userprovider.is_serching
                          //     ? userprovider.searchuser.length
                          //     : userprovider.users.length,
                          itemBuilder: (context, index) {
                            final data = users[index];
                            // return Center(
                            //   child: Card(
                            //     child: Text(
                            //       data.msg,
                            //       style: TextStyle(color: Colors.black),
                            //     ),
                            //   ),
                            // );
                            return MessageCard(message: users[index]);
                          },
                        )
                      : Center(child: Text('hi'));
                }
                return Text('somethiing went wrong');
              },
            ),
          ),
          chatInput(text, user, chatController),
        ],
      ),
    );
  }
}

Widget chatInput(
    TextEditingController text, ChatUser user, ChatController chatController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      chatController.checkFlip();
                    },
                    icon: Icon(
                      Icons.emoji_emotions,
                      color: Colors.blue,
                    )),
                Expanded(
                    child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: text,
                  decoration: InputDecoration(
                      hintText: 'Type here..',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none),
                )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.image,
                      color: Colors.blue,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
        ),
        MaterialButton(
            onPressed: () {
              if (text.text.isNotEmpty) {
                MessageServices.sendMessage(user, text.text);
                text.text = '';
              }
            },
            child: Icon(Icons.send),
            shape: CircleBorder(),
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10)),
      ],
    ),
  );
}
