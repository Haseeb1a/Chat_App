import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatx/constrains/base_objects.dart';
import 'package:chatx/controllers/home_controller.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:chatx/model/message_model.dart';
import 'package:chatx/services/message_services.dart';
import 'package:chatx/services/service_operatiions.dart';
import 'package:chatx/views/chat_details/chats_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharUserCard extends StatelessWidget {
  final ChatUser userdata;
  const CharUserCard({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
     final userprovider = Provider.of<HomeController>(context);
    Message? message;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    user: userdata,
                  ),
                ));
          },
          child: StreamBuilder(
            stream: MessageServices.getLastMessage(userdata),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                message = list[list.length - 1];
              }
              return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      // width: mq.height * .055,
                      // height: mq.height * .055,
                      imageUrl: userdata.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                  title: Text(userdata.name),
                  subtitle: Text(
                    message != null ? message!.msg : userdata.about,
                    maxLines: 1,
                  ),
                  trailing: message == null
                      ? null
                      : message!.read.isEmpty
                          ? Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade400,
                                  borderRadius: BorderRadius.circular(16)),
                            )
                          : Text(
                              userprovider.getLastMessageTime(context: context, time: message!.sent),
                              style: TextStyle(color: Colors.black),
                            ));
            },
          )),
    );
  }
}
