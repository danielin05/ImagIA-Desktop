class LogModel {
  String message;
  String tag;
  DateTime time;
  LogModel(this.message, this.tag, this.time);

  LogModel.fromJson(Map<String, dynamic> json)
  : message = json['message'],
    tag = json['tag'],
    time = DateTime.parse(json['createdAt']); 
}