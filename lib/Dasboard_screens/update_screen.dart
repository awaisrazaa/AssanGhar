import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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

class UpdateData extends StatefulWidget {
  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {




  bool isChecked = false;
  bool firstnamevalidate = false;
  bool idvalidate = false;
  bool countryvalidate = false;
  bool imgvalidate = false;

  bool bathvalidate = false;
  bool surfacevalidate = false;
  bool bedvalidate = false;


  bool addressvalidate = false;
  bool phonevalidate = false;
  bool yearvalidate = false;
  bool pricevalidate = false;
  bool descriptionValid = false;

  bool typevalidate = false;
  bool passvalidate = false;
  bool passValid = false;
  bool emailValid = false;

  bool ownernameValid = false;
  bool ownerphonevalid = false;
  bool confirmvalidate = false;



  final country = TextEditingController();
  final address = TextEditingController();
  final id = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();



  final TextEditingController confirmpassword =  TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final year = TextEditingController();

  final bedroom = TextEditingController();
  final bathroom = TextEditingController();
  final surface = TextEditingController();
  final price = TextEditingController();

  final type = TextEditingController();
  final description = TextEditingController();
  final ownername = TextEditingController();
  final ownerphone = TextEditingController();

  bool isLoading = false;
  String imageURL = "";
  var encodedImage;
  bool updateAble = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> openCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      encodedImage = File(photo!.path);
    });
    if (photo != null) {
      storeUserImage();
    } else {
      print('No Image Path Received');
    }
  }

  Future<void> openGallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      encodedImage = File(photo!.path);
    });

    if (photo != null) {
      storeUserImage();
    } else {
      print('No Image Path Received');
    }
  }

  storeUserImage() async {
    imageURL = "";
    final firebaseStorage = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = firebaseStorage.putFile(encodedImage);
    TaskSnapshot taskSnapshot = await uploadTask;

    await taskSnapshot.ref.getDownloadURL().then((value) async {
      if (value != null) {
        setState(() {
          imageURL = value;
          updateAble = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection("pending")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      setState(() {
        id.text = (value.data() as dynamic)["id"] ?? "";
        name.text = (value.data() as dynamic)["name"] ?? "";
        email.text = (value.data() as dynamic)["email"] ?? "";
        country.text = (value.data() as dynamic)["country"] ?? "";
        address.text = (value.data() as dynamic)["address"] ?? "";
        phone.text = (value.data() as dynamic)["phone"] ?? "";
        year.text = (value.data() as dynamic)["year"] ?? "";
        bedroom.text = (value.data() as dynamic)["bedrooms"] ?? "";
        bathroom.text = (value.data() as dynamic)["bathrooms"] ?? "";
        surface.text = (value.data() as dynamic)["surface"] ?? "";
        price.text = (value.data() as dynamic)["price"] ?? "";
        type.text = (value.data() as dynamic)["type"] ?? "";
        description.text = (value.data() as dynamic)["description"] ?? "";
        ownername.text = (value.data() as dynamic)["OwnerName"] ?? "";
        ownerphone.text = (value.data() as dynamic)["OwnerPhone"] ?? "";
        imageURL = (value.data() as dynamic)["imageLg"] ?? "";
      });
    });
  }
  updatedata() async {
    var data = {
      "id": id.text,
      "name": name.text,
      "email": email.text,
      "country": country.text,
      "address": address.text,
      "phone":phone.text,
      "year":year.text,
      "bedrooms":bedroom.text,
      "bathrooms":bathroom.text,
      "surface":surface.text,
      "price":price.text,
      "type":type.text,
      "description":description.text,
      "OwnerName":ownername.text,
      "OwnerPhone":ownerphone.text,
      "imageLg": imageURL,
    };
    await FirebaseFirestore.instance
        .collection("pending")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update(data);
  }
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
        title: TextView(text: "Update Data"),
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
            color: AppColors.appgreen,
            size: MediaQuery.of(context).size.width / 8,
          ),
        )
            : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AddVerticalSpace(50),
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: AppColors.appgreen,
                        shape: BoxShape.circle),
                    padding: EdgeInsets.all(5),
                    child: ClipOval(
                      // borderRadius: BorderRadius.circular(100),
                      child: OptimizedCacheImage(
                        imageUrl: imageURL,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(
                          height: 30,
                          width: 30,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: AppColors.white,
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          return Icon(
                            Icons.error,
                            color: AppColors.white,
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: AppColors.transparent,
                            builder: (BuildContext context) {
                              return Container(
                                height: 130,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    BTN(
                                      width:
                                      Dimensions.screenWidth(context),
                                      title: "Camera",
                                      color: AppColors.white,
                                      onPressed: () async {
                                        var status = await Permission
                                            .camera.status;

                                        if (status.isGranted) {
                                          openCamera();
                                          Navigator.pop(context);
                                        } else {
                                          await Permission.camera
                                              .request();
                                        }
                                      },
                                    ),
                                    BTN(
                                      width:
                                      Dimensions.screenWidth(context),
                                      title: "Gallery",
                                      color: AppColors.white,
                                      onPressed: () async {
                                        var status = await Permission
                                            .storage.status;

                                        if (status.isGranted) {
                                          openGallery();
                                          Navigator.pop(context);
                                        } else {
                                          await Permission.storage
                                              .request();
                                        }
                                      },
                                    ),
                                    AddVerticalSpace(5),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.camera_alt,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AddVerticalSpace(20),
              TextEditField(
                readOnly: true,
                hintText: "Id",
                inputType: TextInputType.number,
                cursorColor:  AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(Icons.numbers_sharp,
                    color: AppColors.appgreen,),
                textEditingController: id,
                errorText:
                idvalidate ? "ID Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                hintText: "UserName",
                cursorColor:  AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(Icons.person_outline_outlined,
                    color: AppColors.appgreen),
                textEditingController: name,
                errorText:
                firstnamevalidate ? "Firstname Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                hintText: "Email",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(Icons.email,
                    color:AppColors.appgreen),
                textEditingController: email,
                errorText:
                emailValid ? "Email Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                hintText: "Country",
                cursorColor:  AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon: Icon(
                  Icons.location_city_sharp,
                  color: AppColors.appgreen,
                ),
                textEditingController: country,
                errorText: countryvalidate ? "Country Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.text,
                hintText: "Address",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.location_on, color: AppColors.appgreen,),
                textEditingController: address,
                errorText: addressvalidate ? "Address Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.phone,
                hintText: "PhoneNo",
                maxLength: 11,
                cursorColor:AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.phone, color:AppColors.appgreen),
                textEditingController: phone,
                errorText: phonevalidate ? "Phone Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.number,
                hintText: "year",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.date_range_outlined,color: AppColors.appgreen,),
                textEditingController: year,
                errorText: yearvalidate ? "Year Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.number,
                hintText: "BedRooms",
                cursorColor:AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.bedroom_parent,color: AppColors.appgreen),
                textEditingController: bedroom,
                errorText: bedvalidate ? "Bedroom Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.number,
                hintText: "BathRooms",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.bathroom, color: AppColors.appgreen,),
                textEditingController: bathroom,
                errorText: bathvalidate ? "Bathroom Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.text,
                hintText: "Surface",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.landscape_outlined, color: AppColors.appgreen,),
                textEditingController: surface,
                errorText: surfacevalidate ? "Surface Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.number,
                hintText: "Price",
                cursorColor:AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.monetization_on_rounded, color: AppColors.appgreen),
                textEditingController: price,
                errorText: pricevalidate ? "Price Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.text,
                hintText: "Type",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.type_specimen, color:AppColors.appgreen,),
                textEditingController: type,
                errorText: typevalidate ? "Type Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.text,
                hintText: "Description",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.description, color: AppColors.appgreen,),
                textEditingController: description,
                errorText: descriptionValid ? "Description Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(25),
              TextView(
                text: "Owner Contact Information :",color: AppColors.appgreen,fontSize: 20,fontWeight: FontWeight.bold,
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.text,
                hintText: "OwnerName",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.perm_contact_cal, color: AppColors.appgreen,),
                textEditingController: ownername,
                errorText: ownernameValid ? "Agentname Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(20),
              TextEditField(
                inputType: TextInputType.number,
                maxLength: 11,
                hintText: "OwnerPhoneNo",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.phone_android, color: AppColors.appgreen,),
                textEditingController: ownerphone,
                errorText: ownerphonevalid ? "Agentphone Requried" : null,
                width: Dimensions.screenWidth(context),
              ),
              AddVerticalSpace(10),
              BTN(
                  width: Dimensions.screenWidth(context) - 100,
                  title: "Update Data",
                  textColor: AppColors.white,
                  color:  AppColors.appgreen,
                  fontSize: 15,
                  onPressed: () async {
                    if (id.text.isEmpty) {
                      setState(() {
                        idvalidate = true;
                      });
                    }
                    else if (name.text.isEmpty) {
                      setState(() {
                        firstnamevalidate = true;
                      });
                    }
                    else if (email.text.isEmpty) {
                      setState(() {
                        emailValid = true;
                      });
                    }
                    else if (country.text.isEmpty) {
                      setState(() {
                        countryvalidate = true;
                      });
                    }
                    else if (address.text.isEmpty) {
                      setState(() {
                        addressvalidate = true;
                      });
                    }
                    else if (phone.text.length != 11) {
                      Fluttertoast.showToast(
                          msg: 'Mobile Number must be of 11 digit',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor:AppColors.appgreen,
                          textColor: Colors.white,
                          fontSize: 10.0);
                      setState(() {
                        phonevalidate = true;
                      });
                    }
                    else if (year.text.isEmpty) {
                      setState(() {
                        yearvalidate = true;
                      });
                    }
                    else if (bedroom.text.isEmpty) {
                      setState(() {
                        bedvalidate = true;
                      });
                    }
                    else if (bathroom.text.isEmpty) {
                      setState(() {
                        bathvalidate = true;
                      });
                    }
                    else if (surface.text.isEmpty) {
                      setState(() {
                        surfacevalidate = true;
                      });
                    }
                    else if (price.text.isEmpty) {
                      setState(() {
                        pricevalidate = true;
                      });
                    }
                    else if (type.text.isEmpty) {
                      setState(() {
                        typevalidate = true;
                      });
                    }
                    else if (description.text.isEmpty) {
                      setState(() {
                        descriptionValid = true;
                      });
                    }
                    else if (ownername.text.isEmpty) {
                      setState(() {
                        ownernameValid = true;
                      });
                    }
                    else if (ownerphone.text.isEmpty) {
                      setState(() {
                        ownerphonevalid = true;
                      });
                    }
                    else if (imageURL.isEmpty) {
                      setState(() {
                        imgvalidate = true;
                      });
                    }
                    updatedata();
                    Fluttertoast.showToast(
                        msg: ' Your Data is Updated Successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.appgreen,
                        textColor: Colors.white,
                        fontSize: 10.0);
                  }
              ),
              AddVerticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
