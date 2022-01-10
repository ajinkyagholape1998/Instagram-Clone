import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meme_lord/modules/dashboard/dashboard_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<int> feeds = [1,2,3,4];
  late DateTime currentBackPressTime;

  void onLoginClick (context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: onWillPop,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Log in", style: TextStyle(fontSize: 18)),
                Container(
                  child:  const TextField(
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 28),
                ),

                const TextField(
                  decoration: InputDecoration(
                      hintText: "Password"
                  ),
                ),
                Container(
                  child:  ElevatedButton(onPressed: () => onLoginClick(context), child: const Text("LOGIN")),
                  margin: const EdgeInsets.only(top: 28),
                  width: double.maxFinite,
                ),
                Container(
                  child:  const ElevatedButton(onPressed: null, child: Text("Forgot Password ?")),
                  margin: const EdgeInsets.only(top: 28),
                ),
                Container(
                  child:  Column(
                    children: const [
                      Text("Don't have an account"),
                      Text("Sign Up", style: TextStyle(
                          color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(top: 28),
                ),
              ],
            ),
          ),
        )
      );
  }
}
