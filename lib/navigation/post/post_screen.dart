import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common/constants/gaps.dart';
import '../../common/constants/sizes.dart';
import '../../common/widgets/form_button.dart';
import 'post_view_model.dart';

enum Mood { happy, sad, neutral }

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final TextEditingController _contentController =
      TextEditingController(text: "");

  Mood? _selectedMood;

  String _content = "";

  Widget _buildMoodIcon(Mood mood) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // border radius 추가
        boxShadow: [
          // 그림자 효과 추가
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      margin: const EdgeInsets.all(10.0), // 각 컨테이너 사이에 여백 추가
      child: IconButton(
        icon: Icon(
          mood == Mood.happy
              ? Icons.sentiment_very_satisfied
              : mood == Mood.sad
                  ? Icons.sentiment_very_dissatisfied
                  : Icons.sentiment_neutral,
        ),
        color: _selectedMood == mood ? Colors.red : Colors.grey,
        onPressed: () {
          setState(() {
            _selectedMood = mood;
          });
        },
      ),
    );
  }

  Future<void> _onSave(context) async {
    ref.read(postForm.notifier).state = {
      "content": _content,
      "mood": _selectedMood,
    };
    await ref.read(postProvider.notifier).uploadPost(context);
  }

  @override
  Future<void> dispose() async {
    _contentController.dispose();
    super.dispose();
  }

  bool isInputComplete() {
    // Check if all text controllers have non-empty text
    return _contentController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _contentController.addListener(() {
      setState(() {
        _content = _contentController.text;
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
                  controller: _contentController,
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
                Gaps.v20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildMoodIcon(Mood.happy),
                    _buildMoodIcon(Mood.neutral),
                    _buildMoodIcon(Mood.sad),
                  ],
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
                  onTap: () => _onSave(context),
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
