import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onboard_animation/components/sign_in.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/btn.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/spaces.dart';
import '../../../Utils/text_edit_field.dart';
import '../../../Utils/text_view.dart';
import '../../Utils/toast.dart';
import '../../components/Dashboard.dart';

class Inspection extends StatefulWidget {
  String? email;
  Inspection({Key? key, required this.email}) : super(key: key);
  @override
  State<Inspection> createState() => _InspectionState();
}

class _InspectionState extends State<Inspection> {





  bool contactvalid = false;
  bool firstnamevalidate = false;
  bool cityvalid = false;
  bool createdatvalid = false;
  bool InaddressValid = false;
  bool imgvalidate = false;
  bool InlocationValid = false;
  bool Timevalid = false;
  bool paymentvalid = false;

  bool RememberValid = false;

  bool isLoading = false;




  final inaddress = TextEditingController();
  final address = TextEditingController();
  final time = TextEditingController();
  final payment = TextEditingController();
  final inlocation = TextEditingController();
  final city = TextEditingController();
  final contact = TextEditingController();
  final createdAt = TextEditingController();
  final remember = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.litegreen,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.appgreen,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        title: TextView(text: "Inspection Screen"),
        backgroundColor: AppColors.appgreen,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: Dimensions.screenHeight(context),
        width: Dimensions.screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: isLoading
            ? Center(
          child: SpinKitThreeBounce(
            color:  AppColors.appgreen,
            size: MediaQuery.of(context).size.width / 8,
          ),
        )
            : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AddVerticalSpace(50),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50), // Set the border radius to 0 for no rounded corners
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "City",
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.location_city_sharp,
                      color: AppColors.appgreen,
                    ),
                    errorText: cityvalid ? "City Required" : null,
                    focusedBorder: InputBorder.none, // Remove the focused border
                    enabledBorder: InputBorder.none, // Remove the enabled border
                  ),
                  keyboardType: TextInputType.text,
                  cursorColor: AppColors.white,
                  textCapitalization: TextCapitalization.none,
                  controller: city,
                  style: TextStyle(color: AppColors.appgreen), // Set text color to white
                ),
              ),



              // TextEditField(
              //   hintText: "City",
              //   inputType: TextInputType.text,
              //   cursorColor:  AppColors.appgreen,
              //   textCapitalization: TextCapitalization.none,
              //   preffixIcon: Icon(Icons.location_city_sharp,
              //       color:AppColors.appgreen),
              //   textEditingController: city,
              //   errorText:
              //   cityvalid ? "City Requried" : null,
              //   width: Dimensions.screenWidth(context),
              // ),
              AddVerticalSpace(20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contact",
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.contact_mail,
                      color: AppColors.appgreen,
                    ),
                    errorText: contactvalid ? "Contact Required" : null,
                    border: InputBorder.none, // Remove the underline/border
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.appgreen,
                  controller: contact,
                  maxLength: 11,
                  textCapitalization: TextCapitalization.none,
                ),
              ),



              AddVerticalSpace(20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "CreatedAt",
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.create,
                      color: AppColors.appgreen,
                    ),
                    errorText: createdatvalid ? "CreatedAt Required" : null,
                    border: InputBorder.none,
                  ),
                  cursorColor: AppColors.appgreen,
                  textCapitalization: TextCapitalization.none,
                  controller: createdAt,
                  style: TextStyle(color: AppColors.appgreen),
                ),
              ),

              AddVerticalSpace(20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Inaddress",
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: AppColors.appgreen,
                    ),
                    errorText: InaddressValid ? "InAddress Required" : null,
                    border: InputBorder.none,
                  ),
                  cursorColor: AppColors.appgreen,
                  textCapitalization: TextCapitalization.none,
                  controller: inaddress,
                  style: TextStyle(color: AppColors.appgreen),
                ),
              ),

              AddVerticalSpace(20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Inlocation",
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.appgreen,
                    ),
                    errorText: InlocationValid ? "Inlocation Required" : null,
                    border: InputBorder.none, // Remove the underline/border
                  ),
                  cursorColor: AppColors.appgreen,
                  textCapitalization: TextCapitalization.none,
                  controller: inlocation,
                  style: TextStyle(color: AppColors.appgreen),
                ),
              ),

              AddVerticalSpace(20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Remember Location",
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.remember_me_sharp,
                      color: AppColors.appgreen,
                    ),
                    errorText: RememberValid ? "Remember Required" : null,
                    border: InputBorder.none, // Remove the underline/border
                  ),
                  cursorColor: AppColors.appgreen,
                  textCapitalization: TextCapitalization.none,
                  controller: remember,
                  style: TextStyle(color: AppColors.appgreen),
                ),
              ),

              AddVerticalSpace(20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Time Slot",
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.timer,
                      color: AppColors.appgreen,
                    ),
                    errorText: Timevalid ? "Time Slot Required" : null,
                    border: InputBorder.none, // Remove the underline/border
                  ),
                  cursorColor: AppColors.appgreen,
                  textCapitalization: TextCapitalization.none,
                  controller: time,
                  style: TextStyle(color: AppColors.appgreen),
                ),
              ),

              AddVerticalSpace(20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Pay 1000Pkr",
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.payment,
                      color: AppColors.appgreen,
                    ),
                    errorText: paymentvalid ? "Payment Required" : null,
                    border: InputBorder.none, // Remove the underline/border
                  ),
                  cursorColor: AppColors.appgreen,
                  textCapitalization: TextCapitalization.none,
                  controller: payment,
                  style: TextStyle(color: AppColors.appgreen),
                ),
              ),

              AddVerticalSpace(20),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BTN(
                  width: Dimensions.screenWidth(context) - 100,
                  title: "Inspect",
                  textColor: AppColors.white,
                  color:  AppColors.appgreen,
                  fontSize: 15,
                  onPressed: () async {
                    if (city.text.isEmpty) {
                      setState(() {
                        cityvalid = true;
                      });
                    }
                    else if (contact.text.isEmpty) {
                      setState(() {
                        contactvalid = true;
                      });
                    }
                    else if (createdAt.text.isEmpty) {
                      setState(() {
                        createdatvalid = true;
                      });
                    }
                    else if (inaddress.text.isEmpty) {
                      setState(() {
                        InaddressValid = true;
                      });
                    }
                    else if (inlocation.text.isEmpty) {
                      setState(() {
                        InlocationValid = true;
                      });
                    }
                    else if (remember.text.isEmpty) {
                      setState(() {
                        RememberValid = true;
                      });
                    }
                    else if (time.text.isEmpty) {
                      setState(() {
                        Timevalid = true;
                      });
                    }
                    else if (payment.text.isEmpty) {
                      setState(() {
                        paymentvalid = true;
                      });
                    }
                 else {
                      await FirebaseFirestore.instance
                          .collection("inspections")
                          .doc()
                          .set({
                        "city":city.text,
                        "contect": contact.text,
                        "createdAt": createdAt.text,
                        "inaddress": inaddress.text,
                        "inlocation": inlocation.text,
                        "rememberLocation": remember.text,
                        "timeslot": time.text,
                        "payment":payment.text,
                      });
                      Fluttertoast.showToast(
                          msg: 'Your data Submitted Successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor:AppColors.appgreen,
                          textColor: Colors.white,
                          fontSize: 10.0);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Dashboard(email: widget.email,
                                    // email: email.text,
                                  )));
                    }
                  }
              ),
          ),
              AddVerticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
