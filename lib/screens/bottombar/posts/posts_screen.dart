import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/data/models/post.dart';
import 'package:flutter_starter_project/widgets/infinite_scroll.dart';
import 'package:flutter_starter_project/screens/bottombar/posts/posts_provider.dart';

class PostsScreen extends ConsumerWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostsState posts = ref.watch(postsProvider);

    return InfiniteScroll(
      numberOfElements: posts.totPosts,
      currentItems: posts.posts.length,
      buildItem: (context, index) {
        return GestureDetector(
          onTap: () {
            Beamer.of(context).beamToNamed("/posts/detail", data: posts.posts[index]);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(posts.posts[index].title!),
            ),
          ),
        );
      },
      onLoadMore: () async {
        await ref.read(postsProvider.notifier).loadPosts();
      },
    );
  }
}
