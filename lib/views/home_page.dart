import 'package:chatx/constrains/base_objects.dart';
import 'package:chatx/widgets/char_user_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'ChatApp',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 19),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: StreamBuilder(
        stream: Base.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 5),
          itemCount: 20,
          itemBuilder: (context, index) {
            return CharUserCard();
          },
        );
        },
        
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.comment_bank_rounded),
        ),
      ),
    );
  }
}
