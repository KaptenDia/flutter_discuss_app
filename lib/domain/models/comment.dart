import 'dart:convert';

import 'package:discuss_app/domain/models/user.dart';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  String id;
  String idTopic;
  String fromIdUser;
  String toIdUser;
  String description;
  String image;
  String createdAt;
  String updatedAt;
  User toUser;
  User fromUser;

  Comment({
    required this.id,
    required this.idTopic,
    required this.fromIdUser,
    required this.toIdUser,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.toUser,
    required this.fromUser,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        idTopic: json["id_topic"],
        fromIdUser: json["from_id_user"],
        toIdUser: json["to_id_user"],
        description: json["description"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        toUser: User.fromJson(json["to_user"]),
        fromUser: User.fromJson(json["from_user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_topic": idTopic,
        "from_id_user": fromIdUser,
        "to_id_user": toIdUser,
        "description": description,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "to_user": toUser.toJson(),
        "from_user": fromUser.toJson(),
      };
}
