import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/UserLogin/LoginScreen.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 40,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        title: Text('Settings'),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.01,
            right: MediaQuery.of(context).size.width * 0.01,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 11,
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddPlaceScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 22,
                      ),
                      Text('Add a Place'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 11),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  final snackBar = SnackBar(
                    content: const Text('Feature coming up soon....'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 22,
                      ),
                      Text('Notification Settings'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 11),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  final snackBar = SnackBar(
                    content: const Text('Feature coming up soon....'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 22,
                      ),
                      Text('Account Settings'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 11),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  final snackBar = SnackBar(
                    content: const Text('Feature coming up soon....'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 22,
                      ),
                      Text('App Permissions'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 11),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut().whenComplete(() => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false)
                      });
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 22,
                      ),
                      Text('LogOut'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 11),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String place = '';
  String location = '';
  String describe = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 40,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        title: Text('Add a Place'),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Container(
                // height: 45,
                width: double.infinity,
                margin: EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Name 0f the place',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name of the place';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    place = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                // height: 45,
                width: double.infinity,
                margin: EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Add a location',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add a location';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    location = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                // height: 45,
                width: double.infinity,
                margin: EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Describe the place/food',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe the place/food';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    describe = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: InkWell(
                  onTap: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save(); // Save our form now.

                      print('Printing Form data.');
                      print('Name of the place: ${place}');
                      print('Add a location: ${location}');
                      print('Describe Place/Location: ${describe}');
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 55, right: 55, top: 40),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 184, 76, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Submit for review',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
