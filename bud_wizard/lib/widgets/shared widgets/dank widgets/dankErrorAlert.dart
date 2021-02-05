import 'package:flutter/material.dart';

class DankErrorAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {},
        ),
      ],
    );
  }
}
