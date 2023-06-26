import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:onboard_animation/Dasboard_screens/chart_screen.dart';
import 'package:onboard_animation/SettingModule/Views/setting_view.dart';
import 'package:onboard_animation/components/details_screen.dart';
import 'package:onboard_animation/components/search_screen.dart';
import 'package:onboard_animation/onboarding_screen.dart';
import '../AuthenticationModule/Views/UserFrom.dart';
import '../Dasboard_screens/Rating_screen.dart';
import '../Dasboard_screens/cart.dart';
import '../Dasboard_screens/contact_screen.dart';
import '../Dasboard_screens/favourite.dart';
import '../Dasboard_screens/inspection_screen.dart';
import '../Dasboard_screens/update_screen.dart';
import '../ImageGenerationForm.dart';
import '../Utils/app_colors.dart';
import '../Utils/loading_indicator.dart';
import '../firebase_services/firebase_services.dart';
import 'package:http/http.dart' as http;

import 'Asanservices.dart';

class Dashboard extends StatefulWidget {
  String? email;
  Dashboard({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List _houses = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  double value = 3.6;
  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("approved").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _houses.add({
          "name": qn.docs[i]["name"],
          "address": qn.docs[i]["address"],
          "id": qn.docs[i]["id"],
          "gmap": qn.docs[i]["gmap"],
          "price": qn.docs[i]["price"],
          "imageLg": qn.docs[i]["imageLg"],
          "agentImage": qn.docs[i]["agentImage"],
          "agentName": qn.docs[i]["agentName"],
          "agentPhone": qn.docs[i]["agentPhone"],
          "bathrooms": qn.docs[i]["bathrooms"],
          "bedrooms": qn.docs[i]["bedrooms"],
          "country": qn.docs[i]["country"],
          "description": qn.docs[i]["description"],
          "surface": qn.docs[i]["surface"],
          "type": qn.docs[i]["type"],
          "year": qn.docs[i]["year"],
          "pdfUrl": qn.docs[i]["pdfUrl"],
          "docId": qn.docs[i].id,
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
            )
          ],
          title: Text('Assan Ghar'.toUpperCase(),style: TextStyle(color: AppColors.white),),
          backgroundColor: AppColors.appbar,
          elevation: 5.5,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.appbar,),
                accountEmail: Text(widget.email.toString()),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: AppColors.appgreen,
                  foregroundImage: AssetImage('assets/image.png',),
                ),
                accountName:null,
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard,
                ),
                title: Text('Dashboard'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Dashboard(email: widget.email)));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.chat,
                ),
                title: Text('My Chats'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ChartScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.contact_phone,
                ),
                title: Text('Assan Contacts'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Cart()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                ),
                title: Text('Favourite'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Favourite()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.update,
                ),
                title: Text('Update Data'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UpdateData()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                ),
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingView()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.contact_mail,
                ),
                title: Text('Contact Us'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ContactScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.rate_review,
                ),
                title: Text('Rate Us'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RatingScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                ),
                title: Text('Logout'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OnboardingScreen()));
                },
              ),
              Padding(
                padding: const EdgeInsets.all(45.0),
                child: Text(
                  'Apka apna Assan Ghar',
                  style: TextStyle(
                      color: AppColors.appgreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:  AppColors.appgreen,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Userform()),
            );
          },
          child: Icon(
            Icons.add,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color:  AppColors.appbar,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Inspection(
                                email: widget.email,
                              )),
                        );
                      },
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Inspection',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // BudgetCalculatorPage
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServicesPage()),
                        );
                      },

                      child: Icon(
                        Icons.design_services,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      ' AServices',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0,right: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageGenerationForm(
                                email: widget.email,
                              )),
                        );
                      },
                      child: Icon(
                        Icons.message_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'AsanAI',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _houses.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20.0,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 210,
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                ),
                itemBuilder: (_, index) {
                  return Container(
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailedScreen(_houses[index]))),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 175,
                                width: width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          _houses[index]["imageLg"][0],
                                        ),
                                        fit: BoxFit.cover),
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(17)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Positioned(
                                  top: 100,
                                  left: 13,
                                  right: 13,
                                  child: Container(
                                    height: 94,
                                    width: width * 0.8,
                                    decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black54,
                                              blurRadius: 5.0,
                                              offset: Offset(0.0, 0.75))
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(17)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _houses[index]["id"],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 10,
                                                child: Image.network(
                                                  _houses[index]["agentImage"].toString(),
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                _houses[index]["name"],
                                              ),
                                              Spacer(),
                                              Text(
                                                _houses[index]["price"],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              RatingStars(
                                                starColor: Colors.lightGreen,
                                                value: value,
                                                onValueChanged: (val) {
                                                  setState(() {
                                                    value = val;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              Container(
                                height: 220,
                                width: width,
                              )
                            ],
                          )),
                    ),
                  );
                })));
  }
}

/* listview
          itemExtent: 100.0, for the space between listview tiles

 ListTile(
              leading: CircleAvatar(child: Icon(Icons.import_contacts_sharp),backgroundColor: Colors.cyan,),
              title: Text('Mahad is developer'),
              subtitle: Text('Mobile app developer'),
              trailing: Text('30/hours is charges'),
            ),
* */

/*
practice of ROWS and COLUMS
child: Column(
          children: [
            Row(children: [
              Expanded(child: Image(image: AssetImage('images/logo-806.png'),width: 120,)),
              Expanded(flex:2,child: Image(image: AssetImage('images/logo-806.png'),width: 120,)),
              Expanded(flex:2,child: Image(image: AssetImage('images/logo-806.png'),width: 120,)),

            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(

                      children: [
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border)
                      ],
                    )

                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.account_circle,size: 35,),
                    Text('mahad'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.accessibility,size: 35,),
                    Text('is'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.add_business_outlined,size: 35,),
                    Text('good'),

                  ],
                )
              ],
            ),
          ],
        ),
 */

/* App bar containing Image icons
    appBar: AppBar(
    leading: IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {},
    ),
    actions: [
    IconButton(
    icon: Icon(Icons.notifications_active),
    onPressed: () {},
    ),
    IconButton(
    icon: Icon(Icons.settings),
    onPressed: () {},
    ),
    ],
    title: Text('Home'.toUpperCase()),
    backgroundColor: Colors.green.withOpacity(0.7),
    shape:  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
    ),
    elevation: 5.5,
    titleSpacing: 20.0,
    flexibleSpace: Image(image: NetworkImage('https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"'),),
    ),
    body: Container(
    height: 150,
    width: 150,
    margin: EdgeInsets.all(50.0),
    padding: EdgeInsets.all(50.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Colors.greenAccent, width: 5.0),
    //borderRadius: BorderRadius.circular(10.0),
    color: Colors.tealAccent,
    image: DecorationImage(image: AssetImage('images/logo-806.png')),
    boxShadow: [
    BoxShadow(
    color: Colors.amber,
    blurRadius: 7,
    spreadRadius: 8,
    offset: Offset(4, 4))
    ],
    ),

 */

/*Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'.toUpperCase()),
        backgroundColor: Colors.amberAccent,
        elevation: 5.5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
                TextSpan(
                    text: 'My',
                    children:[
                      TextSpan(
                          text: 'Flutter',
                          style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                          text: 'App',
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)
                      )

                    ]
                )
            )
          ],
        ) ,
      ),
    ); */
