import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final String message;
  final String senderId;
  final String messageType;
  final String createdAt;
  final String messageUrl;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.messageType,
    required this.createdAt,
    required this.messageUrl,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
