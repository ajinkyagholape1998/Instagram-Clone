// ignore: file_names
// ignore_for_file: file_names
// icons: https://api.flutter.dev/flutter/material/Icons-class.html
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_meme_lord/constants/constants.dart';
import 'package:flutter_meme_lord/modules/comments/comments.dart';
import 'package:flutter_meme_lord/modules/user_info/user_info.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';

class PostItem extends StatefulWidget {
  final String name;
  final String username;
  final String profilePictureUrl;
  final String postPictureUrl;
  final String postCaption;
  final int comments;
  final int likes;

  const PostItem({
    Key? key,
    required this.name,
    required this.username,
    required this.profilePictureUrl,
    required this.postPictureUrl,
    required this.postCaption,
    required this.comments,
    required this.likes,
  }) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  void onMoreClick() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0x00ffffff),
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                child: Column(
                  children: const [
                    Text("Menu Modal"),
                    Text("Report Abuse"),
                    Text("Unfollow"),
                    Text("Block"),
                  ],
                )),
          );
        });
  }

  void onSendClick(BuildContext context, String postPictureUrl) async {
    await Share.share(postPictureUrl, subject: "this is demo subject");
  }

  TextSpan _buildText(String text, double fontSize) {
    final children = <TextSpan>[];
    final runes = text.runes;

    for (int i = 0; i < runes.length; /* empty */) {
      int current = runes.elementAt(i);

      // we assume that everything that is not
      // in Extended-ASCII set is an emoji...
      final isEmoji = current > 255;
      final shouldBreak = isEmoji ? (x) => x <= 255 : (x) => x > 255;

      final chunk = <int>[];
      while (!shouldBreak(current)) {
        chunk.add(current);
        if (++i >= runes.length) break;
        current = runes.elementAt(i);
      }

      children.add(
        TextSpan(
          text: String.fromCharCodes(chunk),
          style: TextStyle(
              fontFamily: isEmoji ? 'EmojiOne' : null,
              fontSize: fontSize,
              color: Colors.black),
        ),
      );
    }

    return TextSpan(children: children);
  }

  void onProfilePictureClick(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserInfoScreen(name: name)),
    );
  }

  void _onComment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CommentsScreen()),
    );
  }

  void _onLike() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              //header
              Container(
                padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                child: Row(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(widget.profilePictureUrl),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          onTap: () =>
                              onProfilePictureClick(context, widget.name),
                        ),
                        Container(
                          child: Column(children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.username,
                              style: const TextStyle(fontSize: 12),
                            )
                          ], crossAxisAlignment: CrossAxisAlignment.start),
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        ),
                      ],
                    ),
                    //  menu icon
                    IconButton(
                      onPressed: onMoreClick,
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                      tooltip: "more",
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              //body
              InkWell(
                onDoubleTap: _onLike,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 6, 0, 4),
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                    // borderRadius: const BorderRadius.all(Radius.circular(BORDER_RADIUS)),
                    image: DecorationImage(
                        image: NetworkImage(widget.postPictureUrl),
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ),
              //footer
              Container(
                margin: const EdgeInsets.all(6),
                // child: Text(
                //     widget.postCaption,
                //     style: const TextStyle(fontSize: 13)),
                // child: RichText(text: TextSpan(text: widget.postCaption, style: const TextStyle(fontSize: 13))),
                // child: RichText(text: _buildText(widget.postCaption,13)),
                child: const ReadMoreText(
                  'Flutter is Google’s mobile UI open source 😄😁 framework to build high-quality native dasdasdsadasdasdasdasdasd dasfsfdsfs sfsdfdfsfdfsf 😄😁 sfdsdfsfd (super fast) interfaces for iOS and Android apps with the unified codebase.',
                  trimLines: 3,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Show more',
                  trimExpandedText: ' show less',
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          size: 22,
                        ),
                        Text(
                          widget.likes.toString(),
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap:() => _onComment(context),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.messenger_rounded,
                            color: Colors.grey,
                            size: 22,
                          ),
                          Text(
                            widget.comments.toString(),
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.grey,
                          size: 22,
                        ),
                        onPressed: () =>
                            onSendClick(context, widget.postPictureUrl),
                        focusColor: Colors.deepOrangeAccent,
                      ))
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
