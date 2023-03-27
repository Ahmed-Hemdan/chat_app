class MessageModel {
  String? messsage;
  String? id;
  String? time;
  MessageModel({this.messsage, this.id , this.time});
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messsage: json["message"],
      id: json["id"],
      time: json["time"]
    );
  }
  toJson() {
    return {
      "message": messsage,
      "id": id,
      "time" : time,
    };
  }
}
