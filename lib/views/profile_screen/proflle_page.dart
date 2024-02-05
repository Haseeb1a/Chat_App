import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatx/constrains/base_objects.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:chatx/services/service_operatiions.dart';
import 'package:chatx/widgets/alretbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profile_page extends StatelessWidget {
  final CharUser user;
  const Profile_page({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _formkey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          // width: mq.height * .055,
                          // height: mq.height * .055,
                          imageUrl: user.image,
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            child: Icon(CupertinoIcons.person),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () {},
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      // onSaved:(newValue) =>,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'pleace enter name ';
                        } else {
                          return null;
                        }
                      },
                      // validator: ,
                      initialValue: user.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'User Name',
                          label: const Text('User')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'please fil he bio';
                        } else {
                          return null;
                        }
                      },
                      initialValue: user.about,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'User about',
                          label: const Text('About')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        // maximumSize: Size(50, 50))
                      ),
                      onPressed: () {
                        if (_formkey.currentState?.validate() ?? false) {
                          ApiServices().updateProfile(  );
                        }
                      },
                      icon: Icon(Icons.edit),
                      label: Text("UPDATE"),
                    )
                  ]),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Dialogs.showSnackbar(context, msg)
          await GoogleSignIn().signOut();
          await Base.auth.signOut();
        },
        label: Text('LOGOUT'),
        icon: Icon(Icons.logout),
      ),
    );
  }
}
