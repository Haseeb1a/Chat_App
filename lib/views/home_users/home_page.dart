
import 'package:chatx/controllers/home_controller.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:chatx/services/service_operatiions.dart';
import 'package:chatx/views/profile_screen/proflle_page.dart';
import 'package:chatx/widgets/char_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: () =>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home),
          elevation: 1,
          centerTitle: true,
          title: userprovider.is_serching
              ? TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
                  ),
                  onChanged: (value) {
                      userprovider.searcheduser(value);
             
                  },
                  style: TextStyle(letterSpacing: 0.5, fontSize: 17),
                )
              : Text(
                  'ChatApp',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 19),
                ),
          actions: [
            IconButton(
                onPressed: () {
                  userprovider.isSearching();
                },
                icon: Icon(userprovider.is_serching
                    ? CupertinoIcons.clear
                    : Icons.search)),
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
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 5),
                itemCount: userprovider.is_serching
                    ? userprovider.searchuser.length
                    : userprovider.users.length,
                itemBuilder: (context, index) {
                  return CharUserCard(
                    userdata: userprovider.is_serching
                        ? userprovider.searchuser[index]
                        : userprovider.users[index],
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
      ),
    );
  }
}
