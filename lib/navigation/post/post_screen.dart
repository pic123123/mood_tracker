import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common/constants/gaps.dart';
import '../../common/constants/sizes.dart';
import '../../common/widgets/form_button.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _contentsController =
      TextEditingController(text: "");

  String _content = "";

  void _onSave() {
    print("123");
  }

  File? _image; //이미지를 담을 변수 선언

  @override
  Future<void> dispose() async {
    _contentsController.dispose();
    super.dispose();
  }

  bool isInputComplete() {
    // Check if all text controllers have non-empty text
    return _contentsController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _contentsController.addListener(() {
      setState(() {
        _content = _contentsController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(
            Sizes.size20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gaps.v10,
                Row(
                  //가로 축 가운데 정렬
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.fire,
                      color: Colors.red,
                    ),
                    Text(
                      "MOOD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FaIcon(
                      FontAwesomeIcons.fire,
                      color: Colors.red,
                    ),
                  ],
                ),
                Gaps.v20,
                const Text(
                  "How do you fell?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Sizes.size20,
                  ),
                ),
                Gaps.v20,
                TextField(
                  controller: _contentsController,
                  maxLength: 300,
                  maxLines: 15,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: '내용을 입력해 주세요.',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                      horizontal: Sizes.size10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                ),
                _image == null
                    ? const Text('')
                    : Image.file(
                        _image!,
                        width: 200, // 이미지의 원하는 너비를 설정하세요.
                        height: 150, // 이미지의 원하는 높이를 설정하세요.
                        fit: BoxFit.cover,
                      ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _onSave(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.7, // 화면 너비의 약 70%만큼 설정
                    child: FormButton(
                      text: "Post",
                      disabled: _content.isEmpty ? true : false,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
