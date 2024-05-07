import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/Menu/about.dart';
import '../screens/Menu/contact.dart';
import '../screens/Menu/donate.dart';
import '../screens/Menu/profile.dart';

class CircularMenu extends StatefulWidget {
  final SharedPreferences prefs;

  const CircularMenu({Key? key, required this.prefs}) : super(key: key);

  @override
  _CircularMenuState createState() => _CircularMenuState();
}

class _CircularMenuState extends State<CircularMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: FloatingActionButton(
                  onPressed: () {
                    if (_controller.isDismissed) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  },
                  child: Icon(Icons.apps_rounded),
                  backgroundColor: Colors.deepPurple,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: size.width * 0.2,
          right: size.width * 0.2,
          child: _CircularButton(
            color: Colors.red,
            icon: Icon(
              CupertinoIcons.profile_circled,
              size: 35,
              color: Colors.white,
            ),
            onClick: () {},
          ),
        ),
        Positioned(
          bottom: size.width * 0.2,
          right: size.width * 0.5,
          child: _CircularButton(
            color: Colors.blue,
            icon: Icon(
              CupertinoIcons.profile_circled,
              size: 35,
              color: Colors.white,
            ),
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(prefs: widget.prefs)),
              );
            },
          ),
        ),
        Positioned(
          bottom: size.width * 0.5,
          right: size.width * 0.2,
          child: _CircularButton(
            color: Colors.green,
            icon: Icon(
              CupertinoIcons.money_dollar_circle,
              size: 35,
              color: Colors.white,
            ),
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonatePage()),
              );
            },
          ),
        ),
        Positioned(
          bottom: size.width * 0.5,
          right: size.width * 0.5,
          child: _CircularButton(
            color: Colors.pink,
            icon: Icon(
              CupertinoIcons.chat_bubble_text_fill,
              size: 35,
              color: Colors.white,
            ),
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactPage(prefs: widget.prefs)),
              );
            },
          ),
        ),
        Positioned(
          bottom: size.width * 0.35,
          right: size.width * 0.35,
          child: _CircularButton(
            color: Colors.deepOrange,
            icon: Icon(
              CupertinoIcons.info,
              size: 35,
              color: Colors.white,
            ),
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CircularButton extends StatelessWidget {
  final Color color;
  final Icon icon;
  final VoidCallback onClick;

  const _CircularButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: icon,
        color: Colors.white,
        onPressed: onClick,
      ),
    );
  }
}
