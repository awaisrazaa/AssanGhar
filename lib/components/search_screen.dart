import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/text_edit_field.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.litegreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 15,),
              TextEditField(
                inputType: TextInputType.text,
                hintText: "Search Your Assan Ghr",
                cursorColor: AppColors.appgreen,
                textCapitalization: TextCapitalization.none,
                preffixIcon:
                Icon(Icons.search, color: AppColors.darkgreen),
                   onChanged: (val) {
                      setState(() {
                     inputText = val;
                        print(inputText);
                    });
                   },
                width: Dimensions.screenWidth(context), textEditingController:search ,
              ),
              // TextFormField(
              //   onChanged: (val) {
              //     setState(() {
              //       inputText = val;
              //       print(inputText);
              //     });
              //   },
              // ),
              SizedBox(height: 20,),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("approved")
                        .where("name",
                        isEqualTo: inputText)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Something went wrong"),
                        );
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(data['name']),
                              leading: Image.network(data['imageLg'][0]),
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
