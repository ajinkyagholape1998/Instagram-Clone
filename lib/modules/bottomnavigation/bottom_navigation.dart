import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meme_lord/modules/chat/chatscreen.dart';
import 'package:flutter_meme_lord/modules/dashboard/dashboard_screen.dart';
import 'package:flutter_meme_lord/modules/meme_creator/meme_creator.dart';
import 'package:flutter_meme_lord/modules/notifications/notifications.dart';
import 'package:flutter_meme_lord/modules/profile/profile.dart';

class BottomNavigation extends StatefulWidget {
  final int index;
  const BottomNavigation({Key? key, required this.index}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int currentIndex = -1;
  void _onTap (int index){
    setState(() {
      currentIndex = index;
    });
    switch(index){
      case 0:{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
        break;
      }

      case 1:{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Chat()),
        );
        break;
      }

      case 2:{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MemeCreatorScreen()),
        );
        break;
      }
      case 3:{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
        );
        break;
      }
      case 4:{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
      }
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      currentIndex = widget.index;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 2,
      currentIndex: widget.index,
      onTap: _onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.home,
            color: Colors.deepPurple,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.chat_bubble,
            color: Colors.deepPurple,
          ),
          label: 'chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box_rounded,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.add_box_rounded,
            color: Colors.deepPurple,
          ),
          label: 'post',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.notifications,
            color: Colors.deepPurple,
          ),
          label: 'notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.person,
            color: Colors.deepPurple,
          ),
          label: 'profile',
        ),
      ],
    );
  }
}
