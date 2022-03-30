import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/data/models/post.dart';
import 'package:flutter_starter_project/data/models/posts_response.dart';
import 'package:flutter_starter_project/mixins/with_http.dart';
import 'package:flutter_starter_project/page_state_provider.dart';

class PostsState {
  int page = 1;
  int limit = 10;
  int totPosts = 0;
  List<Post> posts = [];
}

class PostsNotifier extends StateNotifier<PostsState> with WithHttp {
  final Reader read;
  PostsNotifier(this.read) : super(PostsState());

  loadPosts() async {
    print("load posts page " + state.page.toString());
    // var response = await Dio().get("https://jsonplaceholder.typicode.com/posts?_page=${state.page}&_limit=${state.limit}");

    var response = await httpRequest(read, (dio) async {
      return Dio().get("https://jsonplaceholder.typicode.com/posts?_page=${state.page}&_limit=${state.limit}");
    });

    var postsResponse = PostsResponse.fromJson(response!.data);

    // var postsResponse = await httpRequest(read, () async {
    //   var response = await Dio().get("https://jsonplaceholder.typicode.com/posts?_page=${state.page}&_limit=${state.limit}");
    //   return PostsResponse.fromJson(response.data);
    // });

    state = PostsState()
      ..posts = [...state.posts, ...postsResponse.data]
      ..page = state.page + 1
      ..totPosts = int.parse(response.headers.map["x-total-count"]?[0] ?? '');
  }
}

final postsProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) => PostsNotifier(ref.read));