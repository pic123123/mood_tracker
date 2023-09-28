import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'post_model.dart';

///사용자가 작성한 글을 관리하는 기능을 제공합니다.
class PostRepository {
  ///Firestore 데이터베이스에 접근하기 위한 인스턴스입니다.
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Firebase 데이터베이스 내 "posts" 경로에 게시글을 업로드 합니다.
  Future<void> uploadPost(PostModel post) async {
    await _db.collection("posts").add(
          post.toJson(),
        );
  }

  ///Firebase 데이터베이스 내 "posts" 경로에 모든 게시글을 가져옵니다.
  Future<QuerySnapshot<Map<String, dynamic>>> getAllPosts() {
    //최신순으로 표기하기 위해 내림차순
    final query = _db.collection("posts");
    return query.get();
  }
}

///postRepo라는 Provider가 PostRepository 인스턴스를 제공함으로써 앱 어디에서든 PostRepository 기능들을 사용할 수 있게 합니다.
final postRepo = Provider(
  (ref) => PostRepository(),
);
