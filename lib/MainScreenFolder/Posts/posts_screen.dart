import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodistan/MainScreenFolder/Posts/post_ListScreen.dart';
import 'package:foodistan/MainScreenFolder/Posts/postsImageWidget.dart';
import 'package:foodistan/awsConfig.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/customLoadingSpinner.dart';
import 'package:foodistan/model/postModel.dart';
import 'package:foodistan/providers/posts_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PostsScreen extends StatefulWidget {
  static const String routeName = '/postScreen';
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<PostsProvider>(context, listen: false).fetchAndSetPosts();
  }

  @override
  Widget build(BuildContext context) {
    // final List<Post> postImages =
    //     Provider.of<PostsProvider>(context, listen: false).postItems;
    // var baseURI =
    //     "https://gsmf1yi8o2.execute-api.us-east-1.amazonaws.com/postlist/s3?key=postlistbucket/";
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
                future: Provider.of<PostsProvider>(context, listen: false)
                    .fetchAndSetPosts(),
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CustomLoadingSpinner());
                  } else {
                    if (dataSnapshot.error != null) {
                      // ...
                      // error handling stuff
                      return Center(
                        child: Column(
                          children: [
                            Lottie.network(
                                'https://assets7.lottiefiles.com/packages/lf20_8eqzrp8m.json',
                                fit: BoxFit.fitWidth),
                            Text('Error Occurred!'),
                          ],
                        ),
                      );
                    } else {
                      return Consumer<PostsProvider>(builder: (_, post, child) {
                        return MasonryGridView.builder(
                          gridDelegate:
                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: post.postItems.length,
                          mainAxisSpacing: 1.h,
                          crossAxisSpacing: 1.h,
                          padding: EdgeInsets.only(bottom: 10.h),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print(post.postItems[index]);
                                print(index);
                                Navigator.of(context).pushNamed(
                                  PostListScreen.routeName,
                                  arguments: post.postItems[index].postId,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.sp),
                                child: Card(
                                  // shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(20.sp)),
                                  // elevation: 0,
                                  margin: EdgeInsets.zero,
                                  child: Image(
                                    image: NetworkImage(AwsConfig.path +
                                        post.postItems[index].postId),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      });
                    }
                  }
                }),
            // GridView.builder(
            //   gridDelegate: SliverQuiltedGridDelegate(
            //     crossAxisCount: 4,
            //     mainAxisSpacing: 4,
            //     crossAxisSpacing: 4,
            //     repeatPattern: QuiltedGridRepeatPattern.inverted,
            //     pattern: [
            //       QuiltedGridTile(2, 2),
            //       QuiltedGridTile(1, 1),
            //       QuiltedGridTile(1, 1),
            //       QuiltedGridTile(1, 2),
            //     ],
            //   ),
            //   itemCount: postImages.length,
            //   itemBuilder: (context, index) => ClipRRect(
            //     borderRadius: BorderRadius.circular(10.sp),
            //     child: Card(
            //       // elevation: 0,
            //       margin: EdgeInsets.zero,
            //       child: Image(
            //         image: NetworkImage(postImages[index]),
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              top: 10.h,
              right: 0.w,
              child: GestureDetector(
                onTap: (() {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          width: 100.w,
                          height: 30.h,
                          padding: EdgeInsets.all(2.5.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.sp),
                              topRight: Radius.circular(10.sp),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   height: 2.5.h,
                              // ),
                              Text(
                                "Create Posts",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kYellow,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (builder) {
                                        return PostsImageWidget(
                                            imageSource: ImageSource.gallery);
                                      }));
                                      // Provider.of<PostsProvider>(context,
                                      //         listen: false)
                                      //     .fetchAndSetPosts();
                                    },
                                    child: Container(
                                      width: 40.w,
                                      height: 14.h,
                                      padding: EdgeInsets.all(1.5.h),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          border: Border.all(
                                              width: 1.5.sp, color: kYellow)),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.photo_camera_back_sharp,
                                            size: 30.sp,
                                            color: kYellow,
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            "Pick from Gallery",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kYellow,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (builder) {
                                        return PostsImageWidget(
                                            imageSource: ImageSource.camera);
                                      }));
                                    },
                                    child: Container(
                                      width: 40.w,
                                      height: 14.h,
                                      padding: EdgeInsets.all(1.5.h),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          border: Border.all(
                                              width: 1.5.sp, color: kYellow)),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.camera_rounded,
                                            size: 30.sp,
                                            color: kYellow,
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            "Take a Photo",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kYellow,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                }),
                child: Container(
                  width: 26.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: kYellow,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.sp),
                      bottomLeft: Radius.circular(10.sp),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        "Create",
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
      ),
    );
  }
}
