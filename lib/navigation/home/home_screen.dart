import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/navigation/home/home_bottom_sheet.dart';
import 'package:mood_tracker/navigation/post/post_model.dart';
import 'package:mood_tracker/navigation/post/posts_view_model.dart';

import '../../common/constants/gaps.dart';
import '../post/post_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _onTap(BuildContext context, String postId) async {
    ///밑에서부터 올라오는 모달창 (모달밖은 저절로 회색으로 흐려짐)
    await showModalBottomSheet(
      context: context,

      /// bottom sheet의 사이즈를 바꿀 수 있게 해줌, (listView를 사용할거면 true)
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HomeBottomSheet(
        postId: postId, // postId를 제공
      ),
    );
  }

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
                return GestureDetector(
                  onLongPress: () => _onTap(context, post.id!),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber[200], // 카드의 배경 색상 설정
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Mood : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // 텍스트 색상 설정
                                ),
                              ),
                              Icon(
                                post.mood == Mood.happy
                                    ? Icons.sentiment_very_satisfied
                                    : post.mood == Mood.sad
                                        ? Icons.sentiment_very_dissatisfied
                                        : Icons.sentiment_neutral,
                                size: 24,
                                color: Colors.black, // 텍스트 색상 설정
                              ),
                            ],
                          ),
                          Gaps.v10,
                          Text(
                            post.content,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black, // 텍스트 색상 설정
                            ),
                          ),
                        ],
                      ),
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
