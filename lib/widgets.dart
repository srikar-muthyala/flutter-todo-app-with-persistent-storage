import 'package:flutter/material.dart';

class MinimalButton extends StatelessWidget {
  final String image_location;
  final int color_code;
  MinimalButton({this.image_location, this.color_code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(color_code),
      ),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image(
            // image: AssetImage("assets/images/add_icon.png"),
            image: AssetImage(image_location),
            height: 35,
          )),
    );
  }
}

class TextContainer extends StatelessWidget {
  final String title;
  TextContainer({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 80,
            left: 40,
            child: Text(
              title ?? "undefined",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Positioned(
            bottom: 35,
            left: 40,
            child: Container(
              width: 250,
              child: Text(
                'Sub tasks functionality yet to be added.',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewPortChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;
  TodoWidget({this.text, @required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              border: isDone
                  ? null
                  : Border.all(
                      width: 1.5,
                      color: Color(0xff868290),
                    ),
              color: isDone ? Color(0xff7349fe) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image(
              image: AssetImage("assets/images/check_icon.png"),
            ),
          ),
          Text(
            text ?? "(add todo widget)",
            style: TextStyle(
              fontSize: 16.0,
              color: isDone ? Color(0xff211551) : Color(0xff86829d),
              fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
