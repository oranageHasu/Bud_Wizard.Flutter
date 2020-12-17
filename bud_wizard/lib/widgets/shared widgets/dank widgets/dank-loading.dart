import 'package:flutter/material.dart';

class DankLoading extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 30.0,
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
