import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black12,
        child: Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(strokeWidth: 5),
          ),
        ),
      ),
    );
  }
}
