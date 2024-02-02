import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharUserCard extends StatefulWidget {
  const CharUserCard({super.key});

  @override
  State<CharUserCard> createState() => _CharUserCardState();
}

class _CharUserCardState extends State<CharUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {},
          child: ListTile(

            leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
            title: Text('demouser'),
            subtitle: Text(
              'kjhdh',
              maxLines: 1,
              
            ),
            trailing: Text('12:00 PM',style: TextStyle(color: Colors.black),),
          )),
    );
  }
}
