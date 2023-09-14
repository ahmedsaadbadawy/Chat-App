import '../constants.dart';

class Message {
  final String message;
  final String id;
  final DateTime date;
  Message(this.message, this.id, this.date);

  factory Message.fromJson(jsonData) {
    return Message(
        jsonData[kMessage], jsonData['id'], jsonData[kCreatrdAt].toDate());
  }
}
