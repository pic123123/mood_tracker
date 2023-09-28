import 'package:mood_tracker/navigation/post/post_screen.dart';

extension MoodExtension on Mood {
  static Mood fromString(String value) {
    return Mood.values.firstWhere((e) => e.toString() == 'Mood.$value');
  }

  String toShortString() {
    return toString().split('.').last;
  }
}

class PostModel {
  final String uid;
  final String content;
  final Mood mood;

  PostModel({
    required this.uid,
    required this.content,
    required this.mood,
  });

  PostModel.empty()
      : uid = "",
        content = "",
        mood = Mood.happy;

  PostModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        content = json["content"],
        mood = MoodExtension.fromString(json["mood"]);

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "content": content,
      "mood": mood.name,
    };
  }
}
