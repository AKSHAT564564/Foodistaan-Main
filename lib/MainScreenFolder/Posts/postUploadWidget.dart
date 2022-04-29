import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/customLoadingSpinner.dart';
import 'package:foodistan/model/postModel.dart';
import 'package:foodistan/providers/posts_provider.dart';
import 'package:foodistan/providers/restaurant_list_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PostUploadWidget extends StatefulWidget {
  File? postImageFile;
  PostUploadWidget({Key? key, this.postImageFile}) : super(key: key);

  @override
  State<PostUploadWidget> createState() => _PostUploadWidgetState();
}

class _PostUploadWidgetState extends State<PostUploadWidget> {
  final _formKey = GlobalKey<FormState>();

  bool isNewVendor = false;
  String postId = '';
  String postTitle = '';
  List<String>? postHashtags = [];
  List<PostTagFood>? postTagFoods = [];
  // late final Timestamp postedDateTime;
  String? userId = '';
  String vendorId = '';
  String vendorName = '';
  GeoPoint? vendorLocation;
  String vendorPhoneNumber = '';

  final _hashtagsTextEditingController = TextEditingController();
  final postNameTextController = TextEditingController();
  final vendorNameTextController = TextEditingController();
  final newVendorNameTextController = TextEditingController();
  final vendorLocationTextController = TextEditingController();
  final newVendorLocationTextController = TextEditingController();
  final newVendorPhoneNumberTextController = TextEditingController();
  List<String> _hashtagValues = [];

  ValueNotifier<List> searchResults = ValueNotifier([]);

  searchQuery(String query, List items) {
    List searchResultsTemp = [];
    // print(query);
    // print(items);
    for (var item in items) {
      RegExp regExp = new RegExp(query, caseSensitive: false);
      bool containe = regExp.hasMatch(item['search']);
      if (containe) {
        searchResultsTemp.add(item);
      }
    }
    searchResults.value = searchResultsTemp;
    print(searchResultsTemp);
  }

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
      newVendorNameTextController.dispose();
      vendorLocationTextController.dispose();
      newVendorLocationTextController.dispose();
      newVendorPhoneNumberTextController.dispose();
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
                      margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
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
                              CupertinoSwitch(
                                activeColor: kGreen,
                                trackColor: kGreen,
                                value: isNewVendor,
                                onChanged: (bool newswitchValue) {
                                  setState(() {
                                    isNewVendor = newswitchValue;
                                  });
                                },
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
                                  postTagFoods: postTagFoods,
                                  postedDateTime: Timestamp.now(),
                                  userId: userId!,
                                  isNewVendor: isNewVendor,
                                  vendorId: vendorId,
                                  vendorName: vendorName,
                                  vendorLocation: vendorLocation!,
                                  vendorPhoneNumber: vendorPhoneNumber))
                              .then((value) {
                            // print(postId);
                            return AlertDialog(
                              title: Text(
                                'Post Uploaded',
                              ),
                            );
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
            child: lottie.Lottie.network(
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
    return Consumer<RestaurantListProvider>(builder: (_, value, __) {
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

                        searchResults.value.clear();

                        // print(vendorName);

                        setState(() {});
                      },
                      onChanged: (v) async {
                        searchQuery(vendorNameTextController.text, value.items);
                        setState(() {});
                        //for cross icon in searchbar
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
              child: ValueListenableBuilder<List>(
                  valueListenable: searchResults,
                  builder: (_, value, __) {
                    return value.isNotEmpty &&
                            vendorNameTextController.text.isNotEmpty
                        ? searchVendorNameList(
                            searchResults: value,
                          )
                        : Container();
                  }),
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
                      scrollPadding: EdgeInsets.zero,
                      // maxLines: 3,
                      controller: vendorLocationTextController,
                      cursorColor: kYellow,
                      readOnly: true,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
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
                  vendorLocationTextController.text.isNotEmpty
                      ? showBottomSheet(
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
                                    child: tagFoodItemsList(),
                                  ),
                                ],
                              ),
                            );
                          })
                      : null;
                },
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Tag Food Items",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  vendorLocationTextController.text.isNotEmpty
                                      ? kRed
                                      : kGreyOf,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: vendorLocationTextController.text.isNotEmpty
                                ? kRed
                                : kGreyOf,
                            size: 12.sp,
                          )
                        ],
                      ),
                      postTagFoods!.isNotEmpty
                          ? Container(
                              height: 10.h,
                              width: 100.w,
                              // color: Colors.red,
                              margin: EdgeInsets.only(top: 1.h),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.all(2.sp),
                                  itemCount: postTagFoods!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        removeTagFood(postTagFoods![index].id);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          height: 10.h,
                                          width: 10.h,
                                          decoration: BoxDecoration(
                                            // color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl:
                                                postTagFoods![index].image,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    'assets/images/thumbnail (2).png'),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'assets/images/thumbnail (2).png'),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Container(),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      );
    });
  }

  void addTagFood(String Id, String Image) {
    PostTagFood id = PostTagFood(
      id: Id,
      image: Image,
    );
    postTagFoods!.add(id);
    setState(() {});
  }

  void removeTagFood(String Id) {
    postTagFoods!.removeWhere((value) => value.id == Id);

    setState(() {});
  }

  Widget tagFoodItemsList() {
    Provider.of<PostsProvider>(context, listen: false).tagFoodItems.clear();
    postTagFoods = [];
    return FutureBuilder(
        future: Provider.of<PostsProvider>(context, listen: false)
            .fetchTagFoods(vendorId),
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
                    lottie.Lottie.network(
                        'https://assets6.lottiefiles.com/packages/lf20_ddxv3rxw.json',
                        fit: BoxFit.fitWidth),
                    Text(
                      'Error Occurred!',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: kGreyDark,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Consumer<PostsProvider>(builder: (_, value, __) {
                return value.getTagFoodItems.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Container(
                              height: 30.h,
                              child: lottie.Lottie.network(
                                  'https://assets3.lottiefiles.com/packages/lf20_js2len.json',
                                  fit: BoxFit.fill),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              'No Food Item Found!',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: kGreyDark,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        itemCount: value.getTagFoodItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 1.5.h,
                            crossAxisSpacing: 1.5.h),
                        itemBuilder: (context, index) {
                          ValueNotifier tagSelected = ValueNotifier(false);

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                tagSelected.value = !tagSelected.value;
                                if (tagSelected.value) {
                                  // postTagFoods!
                                  //     .add(value.getTagFoodItems[index]['id']);
                                  addTagFood(
                                    value.getTagFoodItems[index]['id'],
                                    value.getTagFoodItems[index]['image'],
                                  );
                                } else {
                                  // postTagFoods!.remove(
                                  //     value.getTagFoodItems[index]['id']);
                                  removeTagFood(
                                      value.getTagFoodItems[index]['id']);
                                }
                                print(tagSelected.value);
                                print(postTagFoods);
                                print(
                                    "FoodTag Press ${value.getTagFoodItems[index]['title']}");
                              });
                            },
                            child: ValueListenableBuilder(
                                valueListenable: tagSelected,
                                builder: (context, _, child) {
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 7,
                                                  child: Container(
                                                    // child: Image.network(
                                                    //   // "https://uae.microless.com/cdn/no_image.jpg",
                                                    //   "https://cdn.pixabay.com/photo/2020/09/02/08/19/dinner-5537679_960_720.png",
                                                    //   fit: BoxFit.fill,
                                                    // ),
                                                    child: Image.network(
                                                      // "https://uae.microless.com/cdn/no_image.jpg",
                                                      "${value.getTagFoodItems[index]['image']}",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${value.getTagFoodItems[index]['title']}',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: kGreyDark,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                      Positioned(
                                          top: 0.5.h,
                                          right: 6.5.w,
                                          child: Visibility(
                                            visible: tagSelected.value,
                                            child: Container(
                                              height: 3.h,
                                              width: 3.h,
                                              // color: tagSelected.value
                                              //     ? Colors.green
                                              //     : Colors.red,
                                              child: Image.asset(
                                                'assets/images/teenyicons_tick-circle-outline.png',
                                              ),
                                            ),
                                          ))
                                    ],
                                  );
                                }),
                          );
                        },
                      );
              });
            }
          }
        });
  }

  Widget searchVendorNameList({List? searchResults}) {
    return Container(
      height: 30.h,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: searchResults!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                vendorNameTextController.text = searchResults[index]['Name'];
                vendorLocationTextController.text =
                    searchResults[index]['Address'];
                vendorLocation = searchResults[index]['Location'];
                vendorId = searchResults[index]['id'];
                Provider.of<PostsProvider>(context, listen: false)
                    .tagFoodItems
                    .clear();
                searchResults.clear();
              });
            },
            child: Container(
              // margin: EdgeInsets.only(top: 0.5.h),

              child: ListTile(
                minVerticalPadding: 0,
                minLeadingWidth: 0,
                horizontalTitleGap: 4.sp,
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 5.h,
                    width: 5.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: searchResults[index]['FoodImage'],
                      placeholder: (context, url) =>
                          Image.asset('assets/images/thumbnail (2).png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/thumbnail (2).png'),
                    ),
                  ),
                ),
                title: Text(
                  searchResults[index]['Name'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
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
                    controller: newVendorNameTextController,
                    cursorColor: kYellow,
                    textAlignVertical: TextAlignVertical.center,
                    onEditingComplete: () {
                      vendorName = newVendorNameTextController.text;
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
                    controller: newVendorLocationTextController,
                    cursorColor: kYellow,
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      suffixIcon: InkWell(
                        onTap: (() {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => vendorLocationScreen()),
                          // );
                          // showMaterialModalBottomSheet(
                          //     context: context,
                          //     builder: (context) {
                          //       return vendorLocationScreen();
                          //     });
                          // showBarModalBottomSheet(
                          //     duration: Duration(milliseconds: 300),
                          //     bounce: true,
                          //     context: context,
                          //     builder: (context) {
                          //       return vendorLocationScreen();
                          //     });
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return VendorLocationScreen();
                          //     });
                          showDialog(
                              context: context,
                              builder: (context) {
                                return vendorLocationScreen();
                              });
                        }),
                        child: Icon(
                          Icons.my_location_rounded,
                          color: kRed,
                        ),
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
                    controller: newVendorPhoneNumberTextController,
                    cursorColor: kYellow,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.phone,
                    // onEditingComplete: () {
                    //   vendorPhoneNumber = vendorPhoneNumberTextController.text;
                    //   print(vendorPhoneNumber);
                    //   setState(() {});
                    // },
                    onChanged: (value) {
                      vendorPhoneNumber =
                          newVendorPhoneNumberTextController.text;
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

  Widget vendorLocationScreen() {
    ValueNotifier _counter = ValueNotifier<int>(3);

    double _lat = 22.973423;
    double _lng = 78.656891;
    Completer<GoogleMapController> _controller = Completer();
    Location location = new Location();
    late bool _serviceEnabled;
    late PermissionStatus _permissionGranted;
    // late CameraPosition _currentPosition;
    late CameraPosition _currentPosition = CameraPosition(
      target: LatLng(_lat, _lng),
      zoom: 12,
    );

    MapType _currentMapType = MapType.normal;

    Set<Marker> markers = new Set();

    _onMapTypeButton() {
      setState(() {
        _counter.value += 1;
        _currentMapType =
            _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
      });
      print(_currentMapType);
    }

    getmarkers(LatLng tappedPoint) {
      //markers to place on map
      print(tappedPoint);
      setState(() {
        _counter.value += 1;
        markers = {};
        markers.add(Marker(
          //add first marker
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint, //position of marker

          infoWindow: InfoWindow(
            //popup info
            title: 'Picked Location ',
            snippet: '${tappedPoint}',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));
        newVendorLocationTextController.text =
            '${tappedPoint.latitude} , ${tappedPoint.longitude}';
        vendorLocation = GeoPoint(tappedPoint.latitude, tappedPoint.longitude);
      });

      // print(markers);
      return markers;
    }

    _locateMe() async {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      await location.getLocation().then((res) async {
        final GoogleMapController controller = await _controller.future;
        final _position = CameraPosition(
          target: LatLng(res.latitude!, res.longitude!),
          zoom: 12,
          // zoom: 9,
        );
        _counter.value += 1;
        controller.animateCamera(CameraUpdate.newCameraPosition(_position));
        setState(() {
          _counter.value += 1;
          _lat = res.latitude!;
          _lng = res.longitude!;
        });
      });
    }

    _onMapCloseButton() {
      Navigator.of(context).pop();
    }

    // @override
    // initState() {
    //   super.initState();
    //   _currentPosition = CameraPosition(
    //     target: LatLng(_lat, _lng),
    //     zoom: 12,
    //   );
    //   _locateMe();
    // }

    Widget button(function, Icon icon) {
      return FloatingActionButton(
        onPressed: function,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: kYellow,
        child: icon,
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ValueListenableBuilder(
              valueListenable: _counter,
              builder: (context, value, child) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: _currentMapType,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: _currentPosition,
                    markers: markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onTap: getmarkers,
                  ),
                );
              }),
          Positioned(
            top: 1.h,
            right: 1.w,
            child: Column(
              children: <Widget>[
                Container(
                    height: 6.h,
                    width: 6.h,
                    child: button(
                        _onMapCloseButton,
                        Icon(
                          Icons.close_rounded,
                          size: 24.sp,
                        ))),
                SizedBox(height: 8.h),
                button(
                    _onMapTypeButton,
                    Icon(
                      Icons.map_rounded,
                      size: 28.sp,
                    )),
                SizedBox(height: 1.h),
                button(
                  _locateMe,
                  Icon(
                    Icons.location_searching,
                    size: 26.sp,
                  ),
                )
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

// }

// class VendorLocationScreen extends StatefulWidget {
//   const VendorLocationScreen({Key? key}) : super(key: key);

//   @override
//   State<VendorLocationScreen> createState() => _VendorLocationScreenState();
// }

// class _VendorLocationScreenState extends State<VendorLocationScreen> {
//   double _lat = 22.973423;
//   double _lng = 78.656891;
//   Completer<GoogleMapController> _controller = Completer();
//   Location location = new Location();
//   late bool _serviceEnabled;
//   late PermissionStatus _permissionGranted;
//   late CameraPosition _currentPosition;
//   MapType _currentMapType = MapType.normal;

//   Set<Marker> markers = new Set();

//   @override
//   initState() {
//     super.initState();
//     _currentPosition = CameraPosition(
//       target: LatLng(_lat, _lng),
//       zoom: 12,
//     );
//     _locateMe();
//   }

//   _onMapTypeButton() {
//     setState(() {
//       _currentMapType =
//           _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
//     });
//     print(_currentMapType);
//   }

//   getmarkers(LatLng tappedPoint) {
//     //markers to place on map
//     print(tappedPoint);
//     setState(() {
//       markers = {};
//       markers.add(Marker(
//         //add first marker
//         markerId: MarkerId(tappedPoint.toString()),
//         position: tappedPoint, //position of marker
//         infoWindow: InfoWindow(
//           //popup info
//           title: 'Picked Location ',
//           snippet: '${tappedPoint}',
//         ),
//         icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//       ));
//     });

//     // print(markers);
//     return markers;
//   }

//   _locateMe() async {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//     await location.getLocation().then((res) async {
//       final GoogleMapController controller = await _controller.future;
//       final _position = CameraPosition(
//         target: LatLng(res.latitude!, res.longitude!),
//         zoom: 12,
//         // zoom: 9,
//       );
//       controller.animateCamera(CameraUpdate.newCameraPosition(_position));
//       setState(() {
//         _lat = res.latitude!;
//         _lng = res.longitude!;
//       });
//     });
//   }

//   _onMapCloseButton() {
//     Navigator.of(context).pop();
//   }

//   Widget button(function, Icon icon) {
//     return FloatingActionButton(
//       onPressed: function,
//       materialTapTargetSize: MaterialTapTargetSize.padded,
//       backgroundColor: kYellow,
//       child: icon,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             child: GoogleMap(
//               mapType: _currentMapType,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               initialCameraPosition: _currentPosition,
//               markers: markers,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               onTap: getmarkers,
//             ),
//           ),
//           Positioned(
//             top: 1.h,
//             right: 1.w,
//             // alignment: Alignment.topRight,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                     height: 6.h,
//                     width: 6.h,
//                     child: button(
//                         _onMapCloseButton,
//                         Icon(
//                           Icons.close_rounded,
//                           size: 24.sp,
//                         ))),
//                 SizedBox(height: 8.h),
//                 button(
//                     _onMapTypeButton,
//                     Icon(
//                       Icons.map_rounded,
//                       size: 28.sp,
//                     )),
//                 SizedBox(height: 1.h),
//                 button(
//                   _locateMe,
//                   Icon(
//                     Icons.location_searching,
//                     size: 26.sp,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
