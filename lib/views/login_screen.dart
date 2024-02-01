import 'package:chatx/controllers/login_controllers.dart';
import 'package:chatx/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimated = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 500), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size dd = MediaQuery.of(context).size;
    final loginProvider = Provider.of<LoginController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: dd.height * .15,
              left: _isAnimated ? dd.width * .25 : dd.width * 5,
              width: dd.width * .5,
              child: Image.asset('assets/chat (1).png')),
          Positioned(
              bottom: dd.height * .15,
              left: dd.width * .05,
              width: dd.width * .9,
              height: dd.height * .07,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const StadiumBorder(),
                    elevation: 1),
                onPressed: () async {
                 await loginProvider.singingWithGoogle(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/2048px-Google_%22G%22_logo.svg.png',
                    height: 30),
                label: const Text(
                  'Sign With Google',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
