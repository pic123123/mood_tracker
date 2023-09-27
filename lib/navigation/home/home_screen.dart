import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/navigation/post/post_model.dart';
import 'package:mood_tracker/navigation/post/posts_view_model.dart';

import '../../common/constants/gaps.dart';
import '../post/post_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<PostModel>> postsAsyncValue = ref.watch(postsProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: postsAsyncValue.when(
            data: (List<PostModel> posts) => ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Mood :'),
                            Icon(
                              post.mood == Mood.happy
                                  ? Icons.sentiment_very_satisfied
                                  : post.mood == Mood.sad
                                      ? Icons.sentiment_very_dissatisfied
                                      : Icons.sentiment_neutral,
                            ),
                          ],
                        ),
                        Gaps.v10,
                        Text(post.content),
                      ],
                    ),
                  ),
                );
              },
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
