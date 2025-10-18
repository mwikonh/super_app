// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
  senderName: json['senderName'] as String?,
  message: json['message'] as String,
  senderId: json['senderId'] as String,
  messageType: json['messageType'] as String,
  createdAt: json['createdAt'] as String,
  messageUrl: json['messageUrl'] as String,
);

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'senderName': instance.senderName,
      'message': instance.message,
      'senderId': instance.senderId,
      'messageType': instance.messageType,
      'createdAt': instance.createdAt,
      'messageUrl': instance.messageUrl,
    };
