import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/Posts/postUploadWidget.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/providers/posts_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PostsImageWidget extends StatefulWidget {
  final ImageSource imageSource;
  const PostsImageWidget({Key? key, required this.imageSource})
      : super(key: key);

  @override
  State<PostsImageWidget> createState() => _PostsImageWidgetState();
}

class _PostsImageWidgetState extends State<PostsImageWidget> {
  /// Variables
  File? imageFile;

  final picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickImageFrom(widget.imageSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 7.h,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: kBlackLight),
          ),
          title: Text(
            "Posts",
            style: TextStyle(
              color: kBlackLight,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                child: imageFile == null
                    // ? Placeholder()
                    ? Image.network(
                        "https://uae.microless.com/cdn/no_image.jpg",
                        fit: BoxFit.fitWidth)
                    : Image.file(imageFile!, fit: BoxFit.fill),
              ),
              Positioned(
                bottom: 10.h,
                child: GestureDetector(
                  onTap: () {
                    imageFile == null
                        ? pickImageFrom(widget.imageSource)
                        // : Navigator.push(context,
                        //     MaterialPageRoute(builder: (builder) {
                        //     return PostUploadWidget();
                        //   }));
                        // : setState(() {
                        //     // var tempFile = Provider.of<PostsProvider>(context,
                        //     //         listen: false)
                        //     //     .fetchAndSetPosts();
                        //     // imageFile = tempFile as File?;
                        //     Provider.of<PostsProvider>(context, listen: false)
                        //         .fetchAndSetPosts();
                        //   });
                        : setState(() async {
                            await Navigator.push(context,
                                MaterialPageRoute(builder: (builder) {
                              return PostUploadWidget(
                                  postImageFile: imageFile!);
                            }));
                          });
                  },
                  child: Container(
                    width: 35.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                      color: imageFile == null ? kRed : kYellow,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          imageFile == null ? "Pick Again" : "Next",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /// Pick Image From Gallery or Camera
  Future<void> pickImageFrom(ImageSource imageSource) async {
    try {
      final pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
        print(imageFile);
      }
    } catch (e) {
      print("Failed To Pick Image: $e");
    }
  }
}
