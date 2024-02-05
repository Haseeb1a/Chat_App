import 'package:chatx/constrains/base_objects.dart';
import 'package:chatx/controllers/home_controller.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:chatx/services/service_operatiions.dart';
import 'package:chatx/views/profile_screen/proflle_page.dart';
import 'package:chatx/widgets/char_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServices.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<HomeController>(context);
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
          IconButton(
              onPressed: () {
                // Future<void> signOut() async {
                // await GoogleSignIn().signOut();
                // await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Profile_page(user: ApiServices.currentUser),
                    ));
                // await _auth.signOut();
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: StreamBuilder(
        stream: ApiServices.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData) {
            final data = snapshot.data?.docs;
            userprovider.users =
                data?.map((e) => CharUser.fromJson(e.data())).toList() ?? [];
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 5),
              itemCount: userprovider.users.length,
              itemBuilder: (context, index) {
                return CharUserCard(
                  userdata: userprovider.users[index],
                );
              },
            );
          }
          return Text('somethiing went wrong');
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
