import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/Posts/posts_screen.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/model/postModel.dart';
import 'package:foodistan/providers/posts_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PostUploadWidget extends StatefulWidget {
  File? postImageFile;
  var postHashtagList;
  PostUploadWidget({Key? key, this.postImageFile, this.postHashtagList})
      : super(key: key);

  @override
  State<PostUploadWidget> createState() => _PostUploadWidgetState();
}

class _PostUploadWidgetState extends State<PostUploadWidget> {
  final _formKey = GlobalKey<FormState>();

  bool isNewVendor = false;
  String postId = '';
  String postTitle = '';
  List<String>? postHashtags = [];
  late final List<PostTagFood>? postTagFoods;
  // late final Timestamp postedDateTime;
  late final String? userId;
  late final String vendorId;
  String vendorName = '';
  GeoPoint? vendorLocation;
  String vendorPhoneNumber = '';

  final _hashtagsTextEditingController = TextEditingController();
  final postNameTextController = TextEditingController();
  final vendorNameTextController = TextEditingController();
  final vendorPhoneNumberTextController = TextEditingController();
  List<String> _hashtagValues = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userId = FirebaseAuth.instance.currentUser!.phoneNumber;
      postId = widget.postImageFile!.path.split('/').last;
      print(postId);
    });

    @override
    void dispose() {
      _hashtagsTextEditingController.dispose();
      postNameTextController.dispose();
      vendorNameTextController.dispose();
      vendorPhoneNumberTextController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
            "Upload Post",
            style: TextStyle(
              color: kBlackLight,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              margin: EdgeInsets.only(
                bottom: 2.5.h,
              ),
              padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.only(bottom: 10.h),
                  children: <Widget>[
                    SizedBox(height: 1.5.h),
                    Container(
                      margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Post Title',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: kGreyDark),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            height: 7.5.h,
                            child: TextFormField(
                              controller: postNameTextController,
                              cursorColor: kYellow,
                              textAlignVertical: TextAlignVertical.center,
                              // onChanged: (value) {
                              //   postTitle = postNameTextController.text;
                              //   print(postTitle);
                              //   setState(() {});
                              // },
                              onEditingComplete: () {
                                postTitle = postNameTextController.text;
                                // print(postHashtags);
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter Post Title',
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kGrey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 0.5.w,
                                    color: kYellow,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Hashtags',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: kGreyDark),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  child: buildHashtagsChips(),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  height: 7.5.h,
                                  child: TextFormField(
                                    controller: _hashtagsTextEditingController,
                                    cursorColor: kYellow,
                                    textAlignVertical: TextAlignVertical.center,
                                    onChanged: (v) {
                                      setState(() {});
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter Hashtags',
                                      hintStyle: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: kGrey,
                                      ),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.all(3.sp),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: _hashtagsTextEditingController
                                                  .text.isNotEmpty
                                              ? InkWell(
                                                  child: Icon(
                                                    Icons.add_box,
                                                    size: 18.sp,
                                                    // color: Colors.white,
                                                    color: kYellow,
                                                  ),
                                                  onTap: () {
                                                    _hashtagValues.add(
                                                        _hashtagsTextEditingController
                                                            .text);

                                                    _hashtagsTextEditingController
                                                        .clear();

                                                    setState(() {
                                                      _hashtagValues =
                                                          _hashtagValues;
                                                      postHashtags =
                                                          _hashtagValues;
                                                      // print(postHashtags);
                                                    });
                                                  },
                                                )
                                              : Text(''),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          width: 0.5.w,
                                          color: kYellow,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   child: InputHashtagChip(),
                    // ),
                    Container(
                      // height: 7.h,
                      margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
                      decoration: BoxDecoration(
                        // color: kYellow.withOpacity(0.8),
                        // color: kCreamy.withOpacity(0.8),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Streato Vendor',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isNewVendor ? kGreyDark2 : kGreenDark,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                                child: CupertinoSwitch(
                                  activeColor: kGreen,
                                  trackColor: kGreen,
                                  value: isNewVendor,
                                  onChanged: (bool newswitchValue) {
                                    setState(() {
                                      isNewVendor = newswitchValue;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                'New Vendor',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isNewVendor ? kGreenDark : kGreyDark2,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            isNewVendor
                                ? "Please choose \"Streato Vendor\" in case you are unable to tag or locate a New Vendor."
                                : "Please choose \"New Vendor\" in case you are unable to find the Streato Vendor in our list below.",
                            style: TextStyle(
                              fontSize: 10.sp,
                              // fontWeight: FontWeight.w700,
                              color: kGreyDark2,
                            ),
                          )
                        ],
                      ),
                    ),
                    isNewVendor ? newVendor() : registeredVendor(),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      // margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kRed,
                      ),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: MaterialButton(
                        elevation: 5,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                        currentIndex: 4,
                                      )),
                              (route) => false);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kYellow,
                      ),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: MaterialButton(
                        elevation: 5,
                        onPressed: () {
                          // Provider.of<PostsProvider>(context, listen: false)
                          //     .addPosts(Post(
                          //         postId: 'postId',
                          //         postTitle: 'postTitle',
                          //         postHashtags: [],
                          //         postTagFoods: [],
                          //         postedDateTime: Timestamp.now(),
                          //         userId: 'userId',
                          //         isNewVendor: true,
                          //         vendorId: 'vendorId',
                          //         vendorName: 'vendorName',
                          //         vendorLocation: GeoPoint(21, 43),
                          //         vendorPhoneNumber: 'vendorPhoneNumber'));
                          Provider.of<PostsProvider>(context, listen: false)
                              .uploadPosts(widget.postImageFile!);
                          Provider.of<PostsProvider>(context, listen: false)
                              .addPosts(Post(
                                  postId: postId,
                                  postTitle: postTitle,
                                  postHashtags: postHashtags,
                                  postTagFoods: [],
                                  postedDateTime: Timestamp.now(),
                                  userId: userId!,
                                  isNewVendor: isNewVendor,
                                  vendorId: 'vendorId',
                                  vendorName: vendorName,
                                  vendorLocation: GeoPoint(21, 43),
                                  vendorPhoneNumber: vendorPhoneNumber))
                              .whenComplete(() {
                            print(postId);
                          });
                        },
                        child: Text(
                          "Upload",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ));
  }

  Widget buildHashtagsChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _hashtagValues.length; i++) {
      InputChip actionChip = InputChip(
        // padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        backgroundColor: kGreyLight,
        // backgroundColor: Colors.white,

        label: Text(
          _hashtagValues[i],
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            // fontStyle: FontStyle.italic,
            color: kBlack,
          ),
        ),
        avatar: Container(
            child: Lottie.network(
          'https://assets10.lottiefiles.com/packages/lf20_vfz7ny0n.json',
          fit: BoxFit.fill,
        )),
        elevation: 0.5.h,
        pressElevation: 0.2.h,
        onDeleted: () {
          _hashtagValues.removeAt(i);

          setState(() {
            _hashtagValues = _hashtagValues;
          });
        },
      );

      chips.add(actionChip);
    }

    return Container(
      padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
      child: Wrap(
        spacing: 4.sp,
        children: chips,
      ),
    );
  }

  Widget registeredVendor() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Vendor Name',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: kGreyDark),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 7.5.h,
                  child: TextFormField(
                    controller: vendorNameTextController,
                    cursorColor: kYellow,
                    textAlignVertical: TextAlignVertical.center,
                    onEditingComplete: () {
                      vendorName = vendorNameTextController.text;
                      print(vendorName);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Vendor Name',
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: kGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0.5.w,
                          color: kYellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Vendor Location',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: kGreyDark),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 7.5.h,
                  child: TextFormField(
                    cursorColor: kYellow,
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Vendor Location',
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: kGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0.5.w,
                          color: kYellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.5.h),
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 60.h,
                        width: 100.w,
                        child: Column(
                          children: [
                            SizedBox(height: 1.h),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "Tag Food",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kGreyDark,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: GridView.builder(
                                itemCount: 15,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 1.5.h,
                                        crossAxisSpacing: 1.5.h),
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                child: Image.network(
                                                  // "https://uae.microless.com/cdn/no_image.jpg",
                                                  "https://cdn.pixabay.com/photo/2020/09/02/08/19/dinner-5537679_960_720.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '$index',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: kGreyDark,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                child: Row(
                  children: [
                    Text(
                      "Tag Food Items",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: kRed,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: kRed,
                      size: 12.sp,
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget newVendor() {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Vendor Name',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: kGreyDark),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 7.5.h,
                  child: TextFormField(
                    controller: vendorNameTextController,
                    cursorColor: kYellow,
                    textAlignVertical: TextAlignVertical.center,
                    onEditingComplete: () {
                      vendorName = vendorNameTextController.text;
                      print(vendorName);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Vendor Name',
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: kGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0.5.w,
                          color: kYellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Vendor Location',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: kGreyDark),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 7.5.h,
                  child: TextFormField(
                    cursorColor: kYellow,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.my_location_rounded,
                        color: kRed,
                      ),
                      hintText: 'Vendor Location',
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: kGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0.5.w,
                          color: kYellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Vendor Phone Number',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: kGreyDark),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 7.5.h,
                  child: TextFormField(
                    controller: vendorPhoneNumberTextController,
                    cursorColor: kYellow,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.phone,
                    // onEditingComplete: () {
                    //   vendorPhoneNumber = vendorPhoneNumberTextController.text;
                    //   print(vendorPhoneNumber);
                    //   setState(() {});
                    // },
                    onChanged: (value) {
                      vendorPhoneNumber = vendorPhoneNumberTextController.text;
                      print(vendorPhoneNumber);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Vendor Phone Number',
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: kGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0.5.w,
                          color: kYellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





// class InputHashtagChip extends StatefulWidget {
//   @override
//   InputHashtagChipState createState() => new InputHashtagChipState();
// }

// class InputHashtagChipState extends State<InputHashtagChip> {
//   TextEditingController _hashtagsTextEditingController =
//       new TextEditingController();
//   List<String> _hashtagValues = [];

//   @override
//   void dispose() {
//     _hashtagsTextEditingController.dispose();
//     super.dispose();
//   }

//   Widget buildChips() {
//     List<Widget> chips = [];

//     for (int i = 0; i < _hashtagValues.length; i++) {
//       InputChip actionChip = InputChip(
//         // padding: EdgeInsets.zero,
//         labelPadding: EdgeInsets.zero,
//         backgroundColor: kGreyLight,
//         // backgroundColor: Colors.white,

//         label: Text(
//           _hashtagValues[i],
//           style: TextStyle(
//             fontSize: 10.sp,
//             fontWeight: FontWeight.w600,
//             // fontStyle: FontStyle.italic,
//             color: kBlack,
//           ),
//         ),
//         avatar: Container(
//             child: Lottie.network(
//           'https://assets10.lottiefiles.com/packages/lf20_vfz7ny0n.json',
//           fit: BoxFit.fill,
//         )),
//         elevation: 0.5.h,
//         pressElevation: 0.2.h,
//         onDeleted: () {
//           _hashtagValues.removeAt(i);

//           setState(() {
//             _hashtagValues = _hashtagValues;
//           });
//         },
//       );

//       chips.add(actionChip);
//     }

//     return Container(
//       padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
//       child: Wrap(
//         spacing: 4.sp,
//         children: chips,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   'Hashtags',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w700,
//                       color: kGreyDark),
//                 ),
//                 SizedBox(
//                   height: 1.h,
//                 ),
//                 Container(
//                   child: buildChips(),
//                 ),
//                 SizedBox(
//                   height: 1.h,
//                 ),
//                 Container(
//                   height: 7.5.h,
//                   child: TextFormField(
//                     controller: _hashtagsTextEditingController,
//                     cursorColor: kYellow,
//                     textAlignVertical: TextAlignVertical.center,
//                     onChanged: (v) {
//                       setState(() {});
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Enter Hashtags',
//                       hintStyle: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w600,
//                         color: kGrey,
//                       ),
//                       suffixIcon: Padding(
//                         padding: EdgeInsets.all(3.sp),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             shape: BoxShape.circle,
//                           ),
//                           child: _hashtagsTextEditingController.text.isNotEmpty
//                               ? InkWell(
//                                   child: Icon(
//                                     Icons.add_box,
//                                     size: 18.sp,
//                                     // color: Colors.white,
//                                     color: kYellow,
//                                   ),
//                                   onTap: () {
//                                     _hashtagValues.add(
//                                         _hashtagsTextEditingController.text);

//                                     _hashtagsTextEditingController.clear();

//                                     setState(() {
//                                       _hashtagValues = _hashtagValues;
//                                     });
//                                   },
//                                 )
//                               : Text(''),
//                         ),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           width: 0.5.w,
//                           color: kYellow,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
