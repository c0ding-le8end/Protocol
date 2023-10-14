import 'option.dart';

class Question {
   int? index;
  String? text;
  // late int duration;
  bool? shuffleOptions;
   List<Option>? options;

  Question(
    this.text,
      this.index,
    //this.duration,
    this.shuffleOptions,
    this.options,
  );

  Question.fromJson(dynamic json) {
    text = json["text"];
    index=json['index'];
    //duration = json["duration"];
    shuffleOptions = json["shuffleOptions"];
    options = List<Option>.from(json["options"].map((x) => Option.fromJson(x)));
  }

  static jsonToObject(dynamic json) {
    List<Option> options = [];
    if (json["options"] != null) {
      options =
          List<Option>.from(json["options"].map((x) => Option.fromJson(x)));
    }
    return Question(
        json["text"], json["duration"], json["shuffleOptions"], options);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["text"] = text;
    //map["duration"] = duration;
    map['index']=index;
    map["shuffleOptions"] = shuffleOptions;
    map["options"] = List<dynamic>.from(options!.map((x) => x.toJson()));
    return map;
  }
}
