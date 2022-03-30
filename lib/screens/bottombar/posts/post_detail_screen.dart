import 'package:flutter/material.dart';
import 'package:flutter_starter_project/data/models/post.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;
  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("post ID: " + post.id.toString()),
        SizedBox(height: 16.0),
        Text(post.title!),
        SizedBox(height: 16.0),
        Text(post.body!)
      ],
    );
  }
}
