class MessageModel {
  String? messsage;
  String? id;
  MessageModel({this.messsage, this.id});
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messsage: json["message"],
      id: json["id"],
    );
  }
  toJson() {
    return {
      "message": messsage,
      "id": id,
    };
  }
}
