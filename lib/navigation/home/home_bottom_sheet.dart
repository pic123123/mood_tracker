import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/constants/sizes.dart';
import '../post/post_view_model.dart';

class HomeBottomSheet extends ConsumerStatefulWidget {
  final String postId; // postId를 저장할 필드 추가
  const HomeBottomSheet({
    required this.postId, // 생성자를 통해 postId를 받음
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends ConsumerState<HomeBottomSheet> {
  ///게시글 삭제
  void _onDelete() async {
    ref.read(postProvider.notifier).deletePost(context, widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.30,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: Padding(
          padding: const EdgeInsets.all(Sizes.size20),
          child: Wrap(
            children: [
              const ListTile(
                title: Text('Delete note',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Are you sure you want to do this ?'),
              ),
              const Divider(color: Colors.black26, thickness: 1),
              ListTile(
                leading: const Icon(Icons.delete_forever),
                title: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: _onDelete,
              ),
              const Divider(color: Colors.black26, thickness: 1),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
