import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/navigation/post/post_model.dart';
import 'package:mood_tracker/navigation/post/post_repository.dart';
import '../../authentication/repos/authentication_repo.dart';
import '../../common/widgets/custom_snackbar.dart';
import '../main_navigation.dart';

/// AsyncValue는 데이터의 비동기 로딩 상태를 나타내는 클래스입니다.
/// AsyncValue.loading(), AsyncValue.data(), AsyncValue.error() 등의 메소드를 사용하여 로딩 중,
/// 데이터가 준비된 상태, 오류 발생 상태 등을 표현할 수 있습니다.

/// AsyncValue.guard는 비동기 작업을 수행하고, 그 결과를 AsyncValue로 감싸주는 메소드입니다.
/// 이 메소드를 사용하면 try/catch 문 없이도 오류를 처리할 수 있습니
class PostViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  late final PostRepository _postRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
    _postRepo = ref.read(postRepo);
  }

  /// 게시글을 삭제합니다.
  Future<void> deletePost(context, postId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _postRepo.deletePost(postId),
    );
    if (state.hasError) {
      CustomSnackBar.show(context, SnackBarType.error, '글 작성 실패. 에러코드: 9999');
    } else {
      CustomSnackBar.show(context, SnackBarType.success, '글 삭제 성공');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(tab: 'home'),
        ),
      );
    }
  }

  /// 게시글을 등록합니다.
  Future<void> uploadPost(BuildContext context) async {
    final form = ref.read(postForm);
    final userUid = ref.read(authRepo).user!.uid;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _postRepo.uploadPost(
        PostModel(
          uid: userUid,
          content: form["content"],
          mood: form["mood"],
        ),
      ),
    );
    if (state.hasError) {
      CustomSnackBar.show(context, SnackBarType.error, '글 작성 실패. 에러코드: 9999');
    } else {
      context.go("/home");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const MainNavigationScreen(tab: 'home'),
      //   ),
      // );
    }
  }
}

final postForm = StateProvider((ref) => {});

final postProvider = AsyncNotifierProvider<PostViewModel, void>(
  () => PostViewModel(),
);

///post.id 값을 관리함
final selectedPostIdProvider = StateProvider<String?>((ref) => null);
