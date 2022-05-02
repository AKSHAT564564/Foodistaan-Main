import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String postTitle;
  final List<String>? postHashtags;
  final List<PostTagFood>? postTagFoods;
  final Timestamp postedDateTime;
  final String userId;
  final bool isNewVendor;
  final String vendorId;
  final String vendorName;
  final GeoPoint vendorLocation;
  final String vendorPhoneNumber;

  PostModel({
    required this.postId,
    required this.postTitle,
    required this.postHashtags,
    required this.postTagFoods,
    required this.postedDateTime,
    required this.userId,
    required this.isNewVendor,
    required this.vendorId,
    required this.vendorName,
    required this.vendorLocation,
    required this.vendorPhoneNumber,
  });

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        postId: json["postId"] == null ? null : json["postId"],
        postTitle: json["postTitle"] == null ? null : json["postTitle"],
        postHashtags: json["postHashtags"] == null
            ? null
            : List<String>.from(json["postHashtags"].map((x) => x)),
        postTagFoods: json["postTagFoods"] == null
            ? null
            : List<PostTagFood>.from(
                json["postTagFoods"].map((x) => PostTagFood.fromMap(x))),
        postedDateTime:
            json["postedDateTime"] == null ? null : json["postedDateTime"],
        userId: json["userId"] == null ? null : json["userId"],
        isNewVendor: json["isNewVendor"] == null ? null : json["isNewVendor"],
        vendorId: json["vendorId"] == null ? null : json["vendorId"],
        vendorName: json["vendorName"] == null ? null : json["vendorName"],
        vendorLocation:
            json["vendorLocation"] == null ? null : json["vendorLocation"],
        vendorPhoneNumber: json["vendorPhoneNumber"] == null
            ? null
            : json["vendorPhoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "postId": postId == null ? null : postId,
        "postTitle": postTitle == null ? null : postTitle,
        "postHashtags": postHashtags == null
            ? null
            : List<dynamic>.from(postHashtags!.map((x) => x)),
        "postTagFoods": postTagFoods == null
            ? null
            : List<dynamic>.from(postTagFoods!.map((x) => x.toMap())),
        "postedDateTime": postedDateTime == null ? null : postedDateTime,
        "userId": userId == null ? null : userId,
        "isNewVendor": isNewVendor == null ? null : isNewVendor,
        "vendorId": vendorId == null ? null : vendorId,
        "vendorName": vendorName == null ? null : vendorName,
        "vendorLocation": vendorLocation == null ? null : vendorLocation,
        "vendorPhoneNumber":
            vendorPhoneNumber == null ? null : vendorPhoneNumber,
      };
}

class PostTagFood {
  final String id;
  final String image;

  PostTagFood({
    required this.id,
    required this.image,
  });

  factory PostTagFood.fromJson(String str) =>
      PostTagFood.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostTagFood.fromMap(Map<String, dynamic> json) => PostTagFood(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "image": image == null ? null : image,
      };
}
