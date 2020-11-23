import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text('Grows',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontFamily: "Georgia",
              color: Colors.white,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.all(
          const Radius.circular(5),
        ),
      ),
      height: 50,
      width: 500,
      margin: const EdgeInsets.only(top: 20.0)
    );
  }
}