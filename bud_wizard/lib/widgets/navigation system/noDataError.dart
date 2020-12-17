import 'package:flutter/material.dart';

class NoDataError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
          'https://media.giphy.com/media/TqiwHbFBaZ4ti/source.gif'),
    );
  }
}
