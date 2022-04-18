import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/Posts/posts_screen.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/constants.dart';
import 'package:sizer/sizer.dart';

class PostUploadWidget extends StatefulWidget {
  const PostUploadWidget({Key? key}) : super(key: key);

  @override
  State<PostUploadWidget> createState() => _PostUploadWidgetState();
}

class _PostUploadWidgetState extends State<PostUploadWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isRegistered = false;

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
                              cursorColor: kYellow,
                              textAlignVertical: TextAlignVertical.center,
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
                            height: 7.5.h,
                            child: TextFormField(
                              cursorColor: kYellow,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: 'Enter Hashtags',
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
                                  color:
                                      _isRegistered ? kGreyDark2 : kGreenDark,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                                child: CupertinoSwitch(
                                  activeColor: kGreen,
                                  trackColor: kGreen,
                                  value: _isRegistered,
                                  onChanged: (bool newswitchValue) {
                                    setState(() {
                                      _isRegistered = newswitchValue;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                'New Vendor',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      _isRegistered ? kGreenDark : kGreyDark2,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            _isRegistered
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
                    _isRegistered ? NewVendor() : RegisteredVendor(),
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
                        onPressed: () {},
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
}

class RegisteredVendor extends StatefulWidget {
  const RegisteredVendor({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisteredVendor> createState() => _RegisteredVendorState();
}

class _RegisteredVendorState extends State<RegisteredVendor> {
  @override
  Widget build(BuildContext context) {
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
                    cursorColor: kYellow,
                    textAlignVertical: TextAlignVertical.center,
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
          GestureDetector(
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
                                  })),
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
          )
        ],
      ),
    );
  }
}

class NewVendor extends StatefulWidget {
  const NewVendor({
    Key? key,
  }) : super(key: key);

  @override
  State<NewVendor> createState() => _NewVendorState();
}

class _NewVendorState extends State<NewVendor> {
  @override
  Widget build(BuildContext context) {
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
                    cursorColor: kYellow,
                    textAlignVertical: TextAlignVertical.center,
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
                    cursorColor: kYellow,
                    textAlignVertical: TextAlignVertical.center,
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
