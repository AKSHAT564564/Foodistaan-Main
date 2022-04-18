import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/Posts/postUploadWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PostsProvider with ChangeNotifier {
  // Future<File> writeToFile(ByteData data) async {
  //   final buffer = data.buffer;
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   var filePath =
  //       tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
  //   return new File(filePath).writeAsBytes(
  //       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  // }

  fetchAndSetPosts() async {
    var headers = {'Content-Type': 'text/plain'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://gsmf1yi8o2.execute-api.us-east-1.amazonaws.com/postlist/s3?key=postlistbucket/image_picker4254202086462698876.jpg'));
    // request.body = r'<file contents here>';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      var filePath = tempPath +
          '/file_01.tmp'; // file_01.tmp is dump file, can be anything

      final decodedBytes = base64Decode(response.stream.toString());
      File(filePath).writeAsBytesSync(decodedBytes);
      // final file = File(filePath);
      // var decode = base64Decode(response.stream.toString());
      // // file.open();
      // file.writeAsBytesSync(decode);
      // final file = File(filePath);
      // // var decode = base64Decode(response.stream.toString());
      // // file.open();
      // var len = await response.stream.length;
      // print(len);
      // file.writeAsBytesSync(utf8.encode(response.stream.toString()));

      // print(response.reasonPhrase);
      // print(response.headers);
      // print(file.path.toString());

      // return imageFile;

      // var length = await file.length();
      // print(length);
      print(filePath);
      return filePath;
    } else {
      print(response.reasonPhrase);
    }
  }

  uploadPosts(File file) async {
    var headers = {'Content-Type': 'image/jpeg'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://gsmf1yi8o2.execute-api.us-east-1.amazonaws.com/postlist/s3?key=postlistbucket/${file.path.split('/').last}'));
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
}
