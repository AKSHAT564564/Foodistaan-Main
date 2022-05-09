import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/Posts/heart_overlay_animator.dart';
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
  final StreamController<void> _doubleTapImageLikeEvents =
      StreamController.broadcast();
  bool isLiked = false;
  bool isSaved = false;
  var user = FirebaseAuth.instance.currentUser;
  var likedCount = '2,456';

  @override
  void dispose() {
    _doubleTapImageLikeEvents.close();
    super.dispose();
  }

  void _onDoubleTapLikePost(postId, userId) {
    // setState(() {
    //   Provider.of<PostsProvider>(context, listen: false)
    //       .addLikedBy(postId, userId);
    // });
    setState(() {
      isLiked = !isLiked;
    });
    _doubleTapImageLikeEvents.sink.add(null);
  }

  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)!.settings.arguments as String;

    final loadedPost = Provider.of<PostsProvider>(
      context,
      listen: false,
    ).findById(postId);

    var postList = Provider.of<PostsProvider>(
      context,
      listen: false,
    ).postItems;

    var loadedPostList = [];

    loadedPostList.add(loadedPost);
    postList.removeWhere((element) => element.postId == postId);
    postList.shuffle();
    loadedPostList.addAll(postList);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 7.h,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 7.w,
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
          child: ListView.builder(
              itemCount: loadedPostList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h),
                  margin: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h),
                  color: Colors.white,
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
                                    AwsConfig.path +
                                        loadedPostList[index].postId,
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
                                  loadedPostList[index].postTitle,
                                  style: TextStyle(
                                    color: kBlack,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${loadedPostList[index].vendorLocation.latitude.toStringAsFixed(4)}, ${loadedPostList[index].vendorLocation.longitude.toStringAsFixed(4)}',
                                  style: TextStyle(
                                    color: kBlack,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            loadedPostList[index].isNewVendor
                                ? Container()
                                : PopupMenuButton(
                                    onSelected: (result) {
                                      if (result == 0) {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         RestaurantDelivery(
                                        //       // items: loadedPostList[index],
                                        //       items: Provider.of<
                                        //                   RestaurantListProvider>(
                                        //               context)
                                        //           .items
                                        //           .where((element) =>
                                        //               element ==
                                        //               loadedPostList[index]
                                        //                   .vendorId),
                                        //       vendor_id:
                                        //           loadedPostList[index].vendorId,
                                        //       vendorName:
                                        //           loadedPostList[index].vendorName,
                                        //     ),
                                        //   ),
                                        // );
                                        print(loadedPostList[index].vendorId);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Feature Coming Soon.... ${loadedPostList[index].vendorName}'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            // padding: EdgeInsets.only(
                                            //     left: 2.5.sp, right: 2.5.sp),
                                            height: 4.h,
                                            value: 0,
                                            child: Text(
                                              'Visit to store',
                                              style: TextStyle(
                                                color: kBlack,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ])
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              // height: 5.h,
                              width: 100.w,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.network(
                                AwsConfig.path + loadedPostList[index].postId,
                              ),
                            ),
                            HeartOverlayAnimator(
                                triggerAnimationStream:
                                    _doubleTapImageLikeEvents.stream),
                          ],
                        ),
                        onDoubleTap: () {
                          // setState(() {
                          //   isLiked = !isLiked;
                          // });
                          // print(isLiked);
                          _onDoubleTapLikePost(
                              loadedPostList[index].postId, user!.phoneNumber);
                        },
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
                                onTap: () {
                                  print(isLiked);
                                  return setState(() {
                                    isLiked = !isLiked;
                                  });
                                },
                                child: isLiked
                                    ? Icon(
                                        Icons.favorite_rounded,
                                        color: kRed,
                                        size: 22.sp,
                                      )
                                    : Icon(
                                        Icons.favorite_border_rounded,
                                        size: 22.sp,
                                      )),
                            SizedBox(
                              width: 3.5.w,
                            ),
                            InkWell(
                                onTap: () {
                                  Provider.of<PostsProvider>(context,
                                          listen: false)
                                      .shareApp(loadedPostList[index]);
                                },
                                child: Icon(
                                  Icons.send_rounded,
                                  size: 22.sp,
                                )),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  print(isSaved);
                                  return setState(() {
                                    isSaved = !isSaved;
                                  });
                                },
                                child: isSaved
                                    ? Icon(
                                        Icons.bookmark_rounded,
                                        color: kYellow,
                                        size: 22.sp,
                                      )
                                    : Icon(
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
                                likedCount,
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
                              '${timeAgo(loadedPostList[index].postedDateTime)}',
                              style: TextStyle(
                                color: kGrey,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
        // child: postWidgetList(loadedPost),
      ),
    );
  }
}
