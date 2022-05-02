import 'package:flutter/material.dart';
import 'package:foodistan/awsConfig.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/providers/posts_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PostListScreen extends StatefulWidget {
  static const routeName = '/post-listScreen';
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)!.settings.arguments as String;

    final loadedPost = Provider.of<PostsProvider>(
      context,
      listen: false,
    ).findById(postId);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 7.h,
        backgroundColor: Colors.white,
        elevation: 0,
        //  leadingWidth: 5.w,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: kBlackLight),
        ),
        title: Text(
          "Explore",
          style: TextStyle(
            color: kBlackLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 2.w,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 6.h,
                      width: 6.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          // color: kGrey,
                          color: kYellow,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            AwsConfig.path + loadedPost.postId,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loadedPost.postTitle,
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${loadedPost.vendorLocation.latitude.toStringAsFixed(4)}, ${loadedPost.vendorLocation.longitude.toStringAsFixed(4)}',
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Container(
                // height: 5.h,
                width: 100.w,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.network(
                  AwsConfig.path + loadedPost.postId,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 2.w,
                  right: 3.w,
                ),
                padding: EdgeInsets.only(
                  top: 1.h,
                  bottom: 0.5.h,
                ),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.favorite_border_rounded,
                          size: 22.sp,
                        )),
                    SizedBox(
                      width: 3.5.w,
                    ),
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.send_rounded,
                          size: 22.sp,
                        )),
                    Spacer(),
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.bookmark_border_rounded,
                          size: 22.sp,
                        )),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: 2.w,
                    right: 3.w,
                  ),
                  padding: EdgeInsets.only(
                    top: 0.1.h,
                    bottom: 0.5.h,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '2,456',
                        style: TextStyle(
                          color: kBlack,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        'likes',
                        style: TextStyle(
                          color: kBlack,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(
                  left: 2.w,
                  right: 3.w,
                ),
                padding: EdgeInsets.only(
                  top: 0.1.h,
                  bottom: 0.1.h,
                ),
                child: Row(
                  children: [
                    Text(
                      '${timeAgo(loadedPost.postedDateTime)}',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
