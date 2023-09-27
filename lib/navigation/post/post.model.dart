import 'package:mood_tracker/navigation/post/post_screen.dart';

class Postmodel {
  final String content;
  final Mood mood;

  Postmodel({
    required this.content,
    required this.mood,
  });

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "mood": mood.name,
    };
  }
}
