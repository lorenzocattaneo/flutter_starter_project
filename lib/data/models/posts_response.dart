import 'package:flutter_starter_project/data/models/post.dart';

class PostsResponse {
  late List<Post> data;

  PostsResponse({required this.data});

  PostsResponse.fromJson(List<dynamic> json) {
      data = <Post>[];
      json.forEach((v) {
        data.add(Post.fromJson(v));
      });
  }
}



