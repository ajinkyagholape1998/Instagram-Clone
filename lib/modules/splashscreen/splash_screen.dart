import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meme_lord/modules/login/login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: const [
              Text("Splash Screen")
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
      ),
    );
  }
}
