import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboard_animation/components/pdf_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/app_colors.dart';

class DetailedScreen extends StatefulWidget {
  var _house;
  DetailedScreen(this._house);
  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  Future<void> _dialCall() async {
    String phoneNumber = "";
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Future addToCart() async {
    print("-------------->${widget._house["docId"]}");
    print("-------------->${widget._house["docId"]}");
    print("-------------->${widget._house["docId"]}");
    print("-------------->${widget._house["docId"]}");

    final FirebaseAuth _auth = FirebaseAuth.instance;

    var currentUser = _auth.currentUser;
    print("-------------->${currentUser!.email}");
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget._house['docId'])
        .set({
      "name": widget._house["name"],
      "price": widget._house["price"],
      "imageLg": widget._house["imageLg"],
    }).then((value) => print("${widget._house["docId"]}")
    );

  }

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget._house['docId'])
        .set({
      "name": widget._house["name"],
      "price": widget._house["price"],
      "imageLg": widget._house["imageLg"],
    }).then((value) => print("Added to favourite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.litegreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users-favourite-items")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .where("name", isEqualTo: widget._house['name'])
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text("");
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: AppColors.appgreen,
                  child: IconButton(
                    onPressed: () => snapshot.data.docs.length == 0
                        ? addToFavourite()
                        : print("Already Added"),
                    icon: snapshot.data.docs.length == 0
                        ? Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: CarouselSlider(
                      items: widget._house['imageLg']
                          .map<Widget>((item) => Padding(
                                padding:
                                    const EdgeInsets.only(left: 3, right: 3),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(item),
                                          fit: BoxFit.fitWidth)),
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (val, carouselPageChangedReason) {
                            setState(() {});
                          })),
                ),
                Text(
                  widget._house['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: AppColors.appgreen),
                ),
                SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Bedrooms",
                          style: TextStyle(
                              color: AppColors.appgreen,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Icon(
                          CupertinoIcons.bed_double_fill,
                          color: AppColors.appgreen,
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Text(
                          widget._house['bedrooms'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Text(
                          "BathRooms",
                          style: TextStyle(
                              color: AppColors.appgreen,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: 10,width: 10,),
                        Icon(
                          Icons.bathroom,
                          color: AppColors.appgreen,
                        ),
                        Text(
                          widget._house['bathrooms'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        Text(
                          "Surface",
                          style: TextStyle(
                              color: AppColors.appgreen,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(width: 8,),
                        Icon(
                          Icons.next_plan_outlined,
                          color: AppColors.appgreen,
                        ),
                        // SizedBox(width: 10,),
                        Text(
                          widget._house['surface'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Desription",
                  style: TextStyle(
                      color: AppColors.appgreen,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(widget._house['description']),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "price",
                  style: TextStyle(
                      color: AppColors.appgreen,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "\$ ${widget._house['price'].toString()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: AppColors.appgreen),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: AppColors.appgreen),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(
                            pdfurl: widget._house['pdfUrl'],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Open Pdf",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: 25,
                ),

                Divider(),
                SizedBox(
                  width: 1.sw,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      addToCart();
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(
                                  'We Will Contact You Shortly',
                                  style: TextStyle(color: AppColors.appgreen),
                                ),
                                content: Text('Apka apna Assan Ghar',
                                    style:
                                        TextStyle(color: AppColors.appgreen)),
                              ));
                    },
                    child: Text(
                      "Contact to AsanGhr",
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.appgreen,
                      elevation: 3,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          Text("PhoneNo:${widget._house['agentPhone']}"),
                          // Text(widget._house['agentPhone']),
                          Spacer(),
                          Container(
                              height: 50,
                              width: 125,
                              child: Center(
                                child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          backgroundColor: AppColors.litegreen,
                                          context: context,
                                          builder: (context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListTile(
                                                  leading:
                                                      new Icon(Icons.message),
                                                  title: new Text('Message'),
                                                  onTap: () async {
                                                    Uri sms = Uri.parse(
                                                        'sms:101022?body=your+text+here');
                                                    if (await launchUrl(sms)) {
                                                      //app opened
                                                    } else {
                                                      //app is not opened
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                  leading: new Icon(
                                                      Icons.phone_android),
                                                  title: new Text('Phone'),
                                                  onTap: () {
                                                    setState(() {
                                                      _dialCall();
                                                    });

                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                  leading:
                                                      new Icon(Icons.share),
                                                  title: new Text('Share'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Contact To Owner',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.darkgreen,
                                  borderRadius: BorderRadius.circular(11)))
                        ],
                      ),
                    ),
                  ),
                ),

                // SizedBox(height: 250,),
                // SizedBox(
                //   width: 1.sw,
                //   height: 56.h,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       showModalBottomSheet(
                //           context: context,
                //           builder: (context) {
                //             return Column(
                //               mainAxisSize: MainAxisSize
                //                   .min,
                //               children: <Widget>[
                //                 ListTile(
                //                   leading:
                //                   new Icon(Icons.message),
                //                   title: new Text(
                //                       'Message'),
                //                   onTap: () async{
                //                     Uri sms = Uri.parse('sms:101022?body=your+text+here');
                //                     if (await launchUrl(sms)) {
                //                       //app opened
                //                     }else{
                //                       //app is not opened
                //                     }
                //                     Navigator.pop(
                //                         context);
                //                   },
                //                 ),
                //                 ListTile(
                //                   leading: new Icon(
                //                       Icons
                //                           .phone_android),
                //                   title: new Text(
                //                       'Phone'),
                //                   onTap: () {
                //                     setState(() {
                //                       // _dialCall();
                //                     });
                //
                //                     Navigator.pop(
                //                         context);
                //                   },
                //                 ),
                //                 ListTile(
                //                   leading:
                //                   new Icon(Icons.share),
                //                   title: new Text(
                //                       'Share'),
                //                   onTap: () {
                //                     Navigator.pop(
                //                         context);
                //                   },
                //                 ),
                //               ],
                //             );
                //           }
                //       );
                //
                //     },
                //     child: Text(
                //       "Contact Us",
                //       style: TextStyle(color: Colors.white, fontSize: 18.sp),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.greenAccent,
                //       elevation: 3,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
