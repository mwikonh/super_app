import 'package:json_annotation/json_annotation.dart';

part 'users_data.g.dart';

@JsonSerializable()
class UsersData {
  final String name;
  final String email;
  final String uid;
  final String profilePicture;
  final String createdAt;
  final String updatedAt;

  UsersData({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UsersData.fromJson(Map<String, dynamic> json) =>
      _$UsersDataFromJson(json);
      
  Map<String, dynamic> toJson() => _$UsersDataToJson(this);
}
