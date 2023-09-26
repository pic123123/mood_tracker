import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/custom_snackbar.dart';
import '../repos/authentication_repo.dart';
import 'users_view_model.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      );
      await users.createProfile(userCredential);
    });
    if (state.hasError) {
      final error = state.error
          as FirebaseException; // Cast the error to a FirebaseException
      final message = error.code.toUpperCase(); // Get the error message
      switch (message) {
        case 'INVALID_LOGIN_CREDENTIALS':
          CustomSnackBar.show(
              context, SnackBarType.error, '회원가입 실패. 존재하지 않는 유저정보 입니다.');
          break;
        case 'OPERATION-NOT-ALLOWED':
          print('firebase error, firebase console Auth 확인필요');
          CustomSnackBar.show(
              context, SnackBarType.error, '로그인에 실패했습니다. 에러코드 : 9998.');
          break;
        default:
          CustomSnackBar.show(
              context, SnackBarType.error, '회원가입 실패. 에러코드: 9999');
          break;
      }
    } else {
      context.go("/tutorial");
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
