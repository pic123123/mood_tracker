import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/navigation/post/post.model.dart';
import 'package:mood_tracker/navigation/post/post_repository.dart';
import '../../authentication/repos/authentication_repo.dart';

class PostViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  late final PostRepository _postRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
    _postRepo = ref.read(postRepo);
  }

  /// 게시글을 등록합니다.
  Future<void> uploadPost(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(postForm);
    final userUid = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        await _postRepo.uploadPost(
            Postmodel(
              content: form["content"],
              mood: form["mood"],
            ),
            userUid);
      },
    );
  }
}

final postForm = StateProvider((ref) => {});

final postProvider = AsyncNotifierProvider<PostViewModel, void>(
  () => PostViewModel(),
);
