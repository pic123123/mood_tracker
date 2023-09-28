import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/navigation/post/post_model.dart';
import 'package:mood_tracker/navigation/post/post_repository.dart';
import '../../authentication/repos/authentication_repo.dart';

class PostsViewModel extends AsyncNotifier<List<PostModel>> {
  late final AuthenticationRepository _authRepo;
  late final PostRepository _postRepo;
  List<PostModel> _list = [];

  @override
  FutureOr<List<PostModel>> build() async {
    _postRepo = ref.read(postRepo);
    _list = await _getAllPosts();
    return _list;
  }

  // 게시글을 로드하는 메소드
  Future<List<PostModel>> _getAllPosts() async {
    final result = await _postRepo.getAllPosts();
    final posts = result.docs.map(
      (doc) => PostModel.fromJson(
        doc.id,
        doc.data(),
      ),
    );
    return posts.toList();
  }
}

final postsProvider = AsyncNotifierProvider<PostsViewModel, List<PostModel>>(
  () => PostsViewModel(),
);
