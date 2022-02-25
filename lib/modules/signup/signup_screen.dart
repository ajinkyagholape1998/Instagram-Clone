import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meme_lord/modules/dashboard/dashboard_screen.dart';

// Rate Balancing

// Crash Analytics - Sentry
// push notification - One Signal
// Real time (web socket communication) - Pusher
// Oauth - Firebase

// Oauth google, twitter, facebook

// 


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isHidden = true;
  void onSignUpClick (context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sign up",style: TextStyle(fontSize: 18)),
                  Container(
                    child:  const TextField(
                      decoration: InputDecoration(
                          hintText: "First Name"
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 28),
                  ),
                  Container(
                    child:  const TextField(
                      decoration: InputDecoration(
                          hintText: "Last Name"
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 28),
                  ),
                  Container(
                    child:  const TextField(
                      decoration: InputDecoration(
                          prefix: Icon(Icons.email),
                          hintText: "Email"
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 28),
                  ),
                  Container(
                    child:  TextField(
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                          hintText: "Password",
                        prefix: const Icon(Icons.password),
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: _isHidden? const Icon( Icons.visibility_off):const Icon( Icons.visibility),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 28),
                  ),
                  Container(
                    child:  const TextField(
                      decoration: InputDecoration(
                          hintText: "Contact No."
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 28),
                  ),
                  Container(
                    child:  ElevatedButton(onPressed: ()=>onSignUpClick(context), child: const Text("SIGNUP")),
                    margin: const EdgeInsets.only(top: 28),
                    width: double.maxFinite,
                  ),
                ]
            )
      ),
      ),
    );
  }
}
