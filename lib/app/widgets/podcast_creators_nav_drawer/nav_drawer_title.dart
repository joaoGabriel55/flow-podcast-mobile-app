import 'package:flutter/material.dart';

class NavDrawerTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18, bottom: 18),
      child: Text(
        "Flow podcast creators",
        style: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
      ),
    );
  }
}
