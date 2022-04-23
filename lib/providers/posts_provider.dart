import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/awsConfig.dart';
import 'package:foodistan/model/postModel.dart';

import 'package:http/http.dart' as http;

class PostsProvider with ChangeNotifier {
  final _firestoreInstance = FirebaseFirestore.instance;

  List<Post>? postItem = [];

  PostsProvider({this.postItem});

  List<Post> get postItems {
    return [...postItem!];
  }

  List vendorData = [];
  List get vendors {
    return [...vendorData];
  }

  Future<void> fetchAndSetPosts() async {
    try {
      final List<Post> loadedPostItems = [];

      await _firestoreInstance
          .collection("post-data")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          log(result.data().toString());
          // if (result.data().isEmpty) {
          //   return;
          // }
          loadedPostItems.add(Post.fromMap(result.data())
              // Post(
              //   postId: result.data()['postId'],
              //   postTitle: result.data()['postTitle'],
              //   postHashtags: result.data()['postHashtags'],
              //   postTagFoods: result.data()['postTagFoods'],
              //   postedDateTime: result.data()['postedDateTime'].toString(),
              //   userId: result.data()['userId'],
              //   isNewVendor: result.data()['isNewVendor'],
              //   vendorId: result.data()['vendorId'],
              //   vendorName: result.data()['vendorName'],
              //   vendorLocation: result.data()['vendorLocation'].toString(),
              //   vendorPhoneNumber: result.data()['vendorPhoneNumber'])
              );
        });
      });

      postItem = loadedPostItems;
      // log(postItems.length.toString());
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

  uploadPosts(File file) async {
    var headers = {'Content-Type': 'image/jpeg'};
    var request = http.Request(
        'PUT', Uri.parse('${AwsConfig.path}${file.path.split('/').last}'));
    // request.body = file.readAsBytes().toString();
    // request.body = ;
    // final bytes = await file.readAsBytes();
    // // or
    final bytes = file.readAsBytesSync();
    request.bodyBytes = bytes;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      // print(await response.stream.bytesToString());
      return response.statusCode;
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      return response.statusCode;
    }
  }

  //Function to add a new Post in firebase
  Future<void> addPosts(Post post) async {
    // final timestamp = DateTime.now();
    // timestamp.toIso8601String();
    // log(post.postedDateTime.toString());
    // log(post.postTagFoods.toString());
    // log(post.isNewVendor.toString());
    // log(post.postHashtags.toString());
    // log(post.postId.toString());
    // log(post.postTitle.toString());
    // log(post.userId.toString());
    // log(post.vendorId.toString());
    // log(post.vendorName.toString());
    // log(post.vendorLocation.toString());
    // log(post.vendorPhoneNumber.toString());

    try {
      _firestoreInstance
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

    // try {
    //   _firestoreInstance.collection('post-data').add({
    //     'vendorPhoneNumber': post.vendorPhoneNumber,
    //     'postHashtags': post.postHashtags,
    //     'postTagFoods': post.postTagFoods,
    //     'vendorId': post.vendorId,
    //     'postedDateTime': post.postedDateTime,
    //     'isNewVendor': post.isNewVendor,
    //     'postTitle': post.postTitle,
    //     'postId': post.postId,
    //     'vendorName': post.vendorName,
    //     'userId': post.userId,
    //     'vendorLocation': post.vendorLocation,
    //   }).then((value) {
    //     print("Post data Added$value");
    //   });
    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    //   throw (error);
    // }

    // try {
    // //   return _firestoreInstance.collection('post-data').add({
    // //     'vendorPhoneNumber': '6565656556',
    // //     'postHashtags': ['tasty', 'fastfood'],
    // //     'postTagFoods': [
    // //       {'foodId': 'zza'},
    // //       {'foodId': 'izza'}
    // //     ],
    // //     'vendorId': 'Food1',
    // //     'postedDateTime': Timestamp.now(),
    // //     'isNewVendor': false,
    // //     'postTitle': 'The Best',
    // //     'postId': 'image_picker5511817622945604141.jpg',
    // //     'vendorName': 'Hub',
    // //     'userId': '1ty',
    // //     'vendorLocation': GeoPoint(21, 32),
    // //   }).then((value) {
    // //     print("Post data Added$value");
    // //   }).catchError((error) {
    // //     print("Post couldn't be added.:- $error");
    // //   });

    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    //   throw (error);
    // }
  }

  Future<void> fetchVendorData() async {
    _firestoreInstance.collection('DummyData').get().then((querySnapshot) {});
  }
}
