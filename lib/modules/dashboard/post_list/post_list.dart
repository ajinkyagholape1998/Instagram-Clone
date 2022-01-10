import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_meme_lord/constants/constants.dart';
import 'package:flutter_meme_lord/modules/dashboard/post_item/post_item.dart';
import 'package:http/http.dart' as http;

class Post {
  final String id;
  final String name;
  final String username;

  // final String caption;
  // final int comments;
  // final int likes;
  final String profilePictureUrl;
  final String postPictureUrl;

  Post({
    required this.id,
    required this.name,
    required this.username,
    required this.profilePictureUrl,
    required this.postPictureUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['login']['uuid'],
        name: json['name']['first'] + " " + json['name']['last'],
        username: json['email'],
        profilePictureUrl:json["picture"]["medium"],
        postPictureUrl:json["picture"]["large"]
    );
  }
}

