import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PostsProvider with ChangeNotifier {
  fetchAndSetPosts() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://gsmf1yi8o2.execute-api.us-east-1.amazonaws.com/postlist/s3?key=postlistbucket/christmas-2059698_960_720.jpg'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      // print(await response.stream.bytesToString());
      // response.stream.transform(utf8.decoder).listen((value) {
      //   // print(value);
      //    value;
      // });
      final respStr = await response.stream.bytesToString();
      // // print(await response.stream.bytesToString());

      return respStr;
    } else {
      print(response.reasonPhrase);
    }
  }

  uploadPosts(File file, String path) async {
    var headers = {'Content-Type': 'image/jpeg'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://gsmf1yi8o2.execute-api.us-east-1.amazonaws.com/postlist/s3?key=postlistbucket/${path.split('/').last}'));
    request.body = r'<file contents here>';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
