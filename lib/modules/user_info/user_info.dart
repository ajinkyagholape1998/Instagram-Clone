import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meme_lord/constants/constants.dart';
import 'package:flutter_meme_lord/modules/bottomnavigation/bottom_navigation.dart';
import 'package:flutter_meme_lord/modules/dashboard/post_list/post_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInfoScreen extends StatefulWidget {
  final String name;

  const UserInfoScreen({Key? key, required this.name}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  Future<List<Post>>? userInfo;

  Future<List<Post>> _fetchUserInfo() async {
    final response = await http.get(Uri.parse(USER_INFO_API_URL + widget.name));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)["results"];
      List<Post> postList = [];
      for (var element in jsonResponse) {
        postList.add(Post.fromJson(element));
      }
      return postList;
    } else {
      throw Exception('Failed to load post from API ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      userInfo = _fetchUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: FutureBuilder<List<Post>>(
          future: userInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data![0].username);
            }
            else if (snapshot.hasError){
              return Text('Error => ${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          }
          ),
      // bottomNavigationBar: const BottomNavigation(),
    );
  }
}
