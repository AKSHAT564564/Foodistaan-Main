import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodistan/MainScreenFolder/Posts/postsImageWidget.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/providers/posts_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PostsScreen extends StatefulWidget {
  static const String routeName = '/postScreen';
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final List<String> postImages = [
    "https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg",
    "https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg",
    "https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg",
    "https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=",
    "https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg",
    "https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg",
    "https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg",
    "https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg",
    "https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg",
    "https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg",
    "https://uae.microless.com/cdn/no_image.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
    "https://www.boostmobile.com/content/dam/boostmobile/en/products/phones/apple/iphone-7/silver/device-front.png.transform/pdpCarousel/image.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
    "https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
    "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/images/16q1/665019/2016-chevrolet-silverado-2500hd-high-country-diesel-test-review-car-and-driver-photo-665520-s-original.jpg",
  ];

  /// Variables
  // File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: postImages.length,
              mainAxisSpacing: 1.h,
              crossAxisSpacing: 1.h,
              padding: EdgeInsets.only(bottom: 10.h),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.sp),
                  child: Card(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.sp)),
                    // elevation: 0,
                    margin: EdgeInsets.zero,
                    child: Image(
                      image: NetworkImage(postImages[index]),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
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
                                      height: 15.h,
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
                                      height: 15.h,
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
                  width: 28.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: kYellow,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.sp),
                      bottomLeft: Radius.circular(20.sp),
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
