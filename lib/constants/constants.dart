import 'package:flutter/cupertino.dart';

const double BORDER_RADIUS = 10.0;

// const String API_URL ="https://randomuser.me/api/?results=20&page=";
const String API_URL ="http://192.168.43.205:5000/";

const String USER_INFO_API_URL ="https://randomuser.me/api/?name=";

bool isValid(param){
    if(param!=null){
      return true;
    }
    return false;
}

TextSpan _buildText(String text) {
  final children = <TextSpan>[];
  final runes = text.runes;

  for (int i = 0; i < runes.length; /* empty */ ) {
    int current = runes.elementAt(i);

    // we assume that everything that is not
    // in Extended-ASCII set is an emoji...
    final isEmoji = current > 255;
    final shouldBreak = isEmoji
        ? (x) => x <= 255
        : (x) => x > 255;

    final chunk = <int>[];
    while (! shouldBreak(current)) {
      chunk.add(current);
      if (++i >= runes.length) break;
      current = runes.elementAt(i);
    }

    children.add(
      TextSpan(
        text: String.fromCharCodes(chunk),
        style: TextStyle(
          fontFamily: isEmoji ? 'EmojiOne' : null,
        ),
      ),
    );
  }

  return TextSpan(children: children);
}

String getPusherToken() => "912e1b0593204f1940a6";