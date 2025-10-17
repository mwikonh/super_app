// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersData _$UsersDataFromJson(Map<String, dynamic> json) => UsersData(
  name: json['name'] as String,
  email: json['email'] as String,
  uid: json['uid'] as String,
  profilePicture: json['profilePicture'] as String,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$UsersDataToJson(UsersData instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'uid': instance.uid,
  'profilePicture': instance.profilePicture,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
