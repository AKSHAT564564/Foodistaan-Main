import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:foodistan/awsConfig.dart';
import 'package:foodistan/model/postModel.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'package:http/http.dart' as http;

class PostsProvider with ChangeNotifier {
  final _firestoreInstance = FirebaseFirestore.instance;

  List<PostModel>? postItem = [];

  PostsProvider({this.postItem});

  List<PostModel> get postItems {
    return [...postItem!];
  }

  List tagFoodItems = [];
  List get getTagFoodItems {
    return [...tagFoodItems];
  }

//Future Function is use to Fetch All The Post from Firebase and return a list of Posts
  Future<void> fetchAndSetPosts() async {
    try {
      final List<PostModel> loadedPostItems = [];

      await _firestoreInstance
          .collection("post-data")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          log(result.data().toString());

          loadedPostItems.add(PostModel.fromMap(result.data()));
        });
      });

      postItem = loadedPostItems;

      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  // Future<File> writeToFile(ByteData data) async {
  //   final buffer = data.buffer;
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   var filePath =
  //       tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
  //   return new File(filePath).writeAsBytes(
  //       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  // }

// Do not delete the fetchAnDSetPosts function code
  // fetchAndSetPosts() async {
  //   var headers = {'Content-Type': 'text/plain'};
  //   var request = http.Request(
  //       'GET',
  //       Uri.parse(
  //           'https://gsmf1yi8o2.execute-api.us-east-1.amazonaws.com/postlist/s3?key=postlistbucket/Empty Cart.jpeg'));

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     Directory tempDir = await getTemporaryDirectory();
  //     String tempPath = tempDir.path;
  //     var filePath = tempPath +
  //         '/${request.url.query.split('/').last}'; // file_01.tmp is dump file, can be anything
  //     // print('${filePath}');
  //     var streamString = await http.Response.fromStream(response);

  //     // final decodedBytes = base64Encode(streamString.bodyBytes);
  //     // log(decodedBytes);
  //     // log(streamString.bodyBytes.toString());
  //     final file = File(filePath);
  //     file.writeAsBytesSync(streamString.bodyBytes);

  //     return file;
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

// Function is use to Upload the Post Image to the AWS S3 Bucket. it takes the Image File and Upload it to AWS.
  uploadPosts(File file) async {
    var headers = {'Content-Type': 'image/jpeg'};
    var request = http.Request(
        'PUT', Uri.parse('${AwsConfig.path}${file.path.split('/').last}'));

    final bytes = file.readAsBytesSync();
    request.bodyBytes = bytes;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  //Futer Function to add a new Post in firebase
  Future<void> addPosts(PostModel post) async {
    try {
      await _firestoreInstance
          .collection('post-data')
          .add(post.toMap())
          .then((value) {
        print("Post data Added:- $value");
      });

      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

//  Future Take Vendor ID and return the Food Items list
  Future<List> fetchTagFoods(vendor_id) async {
    // List tagFoodItems = [];
    final CollectionReference tagFoodList = FirebaseFirestore.instance
        .collection('DummyData')
        .doc(vendor_id)
        .collection('menu-items');
    try {
      await tagFoodList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              tagFoodItems.add(element.data());
              print(tagFoodItems);
            })
          });
    } catch (e) {
      print(e.toString());
    }

    return tagFoodItems;
  }

// This Function is use to find the Post from List of Post it takes PostId and return a Single Post
  PostModel findById(String postId) {
    return postItems.firstWhere(
      (single) => single.postId == postId,
    );
  }

// This Function is use to add Liked By feature to the Post. It Takes the PostId and Current UserId and Update the Post Likes
  // addLikedBy(postId, userId) async {
  //   await FirebaseFirestore.instance.collection('post-data').doc().update({
  //     'likes': FieldValue.arrayUnion([userId])
  //   }).then((value) => debugPrint(postId));

  //   notifyListeners();
  // }

  //This Future is use to Share Post on different platforms. it take the Post
  Future<void> shareApp(PostModel post) async {
    var url = 'http://maps.google.com/maps?q=loc:';
    await FlutterShare.share(
      chooserTitle: "Share To",
      title: post.postTitle,
      text:
          '${post.vendorName}\n\nFor more details on street foods near you, download Streato App from Playstore/Appstore. ',
      linkUrl:
          '$url${post.vendorLocation.latitude},${post.vendorLocation.longitude}',
    );
  }
}

// This Function is use to set time ago for the post. It takes TimeStamp/Posted Datetime of post and return the time ago the post was posted.
String timeAgo(Timestamp postedDateTime) {
  final now = DateTime.now();
  final dateTime = DateTime.fromMicrosecondsSinceEpoch(
      postedDateTime.microsecondsSinceEpoch,
      isUtc: true);
  return timeago.format(now.subtract(now.difference(dateTime)));
}
