import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_meme_lord/constants/constants.dart';
import 'package:flutter_meme_lord/modules/bottomnavigation/bottom_navigation.dart';
import 'package:flutter_meme_lord/modules/dashboard/post_item/post_item.dart';
import 'package:flutter_meme_lord/modules/dashboard/post_list/post_list.dart';
import 'package:flutter_meme_lord/modules/search/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Future<List<Post>>? futurePosts;
  late ScrollController _controller;
  late bool _isLoadMoreRunning = false;
  late int pageNumber = 1;

  Future<List<Post>> _fetchPosts() async {
    final response = await http.get(Uri.parse(API_URL+pageNumber.toString()));
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

  void _fetchMorePosts() async {
    if (_isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      pageNumber += 1;
      final response = await http.get(
          Uri.parse(API_URL + pageNumber.toString()));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)["results"];
        List<Post> postList = [];
        for (var element in jsonResponse) {
          postList.add(Post.fromJson(element));
        }
        setState(() {
          _isLoadMoreRunning = false;
        });
      } else {
        throw Exception('Failed to load post from API ${response.statusCode}');
      }
    }
  }

  void onSearchClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>const SearchScreen()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      futurePosts = _fetchPosts();
      _isLoadMoreRunning = false;
      _controller = ScrollController()..addListener(_fetchMorePosts);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posts",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: onSearchClick,
            tooltip: "search",
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            iconSize: 24,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              futurePosts = _fetchPosts();
            });
          },
          child: Column(
            children: [
              FutureBuilder<List<Post>>(
                future: futurePosts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          // controller: _controller,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return PostItem(
                              name: isValid(snapshot.data)?snapshot.data![index].name:"",
                              profilePictureUrl: isValid(snapshot.data)?snapshot.data![index].profilePictureUrl:"http://sc01.alicdn.com/kf/HTB1jA_RXrj1gK0jSZFuq6ArHpXab.jpg",
                              username:  isValid(snapshot.data)?snapshot.data![index].username:"",
                              postCaption: "😄😁 text t😊est😇 🤩1🥸  Lorem Ipsum \uD83E\uDD37\u200D\u2642\uFE0F is \uD83E simply dummy 😻 text of the printing 😍 and typesetting industry. 🍎 Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                              comments: index,
                              likes: 62,
                              postPictureUrl: isValid(snapshot.data)?snapshot.data![index].postPictureUrl:'https://terrigen-cdn-dev.marvel.com/content/prod/1x/snh_online_6072x9000_posed_01.jpg',
                            );
                          }
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error => ${snapshot.error}');
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 136,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Center(child: CircularProgressIndicator())
                      ],
                    ),
                  );
                }),
              if (_isLoadMoreRunning == true)
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 40),
                  child: Column(
                    children:const [
                    Center(child: CircularProgressIndicator()),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(index: 0,)
    );
  }
}
