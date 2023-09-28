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
  final String? id; // Make this nullable
  final String uid;
  final String content;
  final Mood mood;

  PostModel({
    this.id, // This is now optional
    required this.uid,
    required this.content,
    required this.mood,
  });

  PostModel.empty()
      : id = null, // Default to null
        uid = "",
        content = "",
        mood = Mood.happy;

  PostModel.fromJson(
      String id, Map<String, dynamic> json) // Modify the parameters here
      : id = id, // Add this line
        uid = json["uid"],
        content = json["content"],
        mood = MoodExtension.fromString(
          json["mood"],
        );

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "content": content,
      "mood": mood.name,
    };
  }
}
