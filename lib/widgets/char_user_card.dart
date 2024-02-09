import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharUserCard extends StatelessWidget {
  final ChatUser userdata;
  const CharUserCard({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {},
          child: ListTile(
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
              ),),
    //         CachedNetworkImage(
    //     imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN_O2hyzHQi-0hFB8z-4rbSzCwMPKruXrDBQ&usqp=CAU',
    //     placeholder: (context, url) => CircularProgressIndicator(),
    //     errorWidget: (context, url, error) => Icon(Icons.error),
    //  ),
            
            title: Text(userdata.name),
            subtitle: Text(
              userdata.about,
              maxLines: 1,
            ),
             trailing: Container(
              width:15 ,
              height: 15 ,
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade400,
                borderRadius: BorderRadius.circular(16)

              ),
             )
             
            // trailing: Text(
            //   '12:00 PM',
            //   style: TextStyle(color: Colors.black),
            // ),
          )),
    );
  }
}
