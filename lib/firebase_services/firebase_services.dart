
import 'package:flutter/cupertino.dart';

import 'firebase_const.dart';

class FireStoreServices{
  static allhouses(){
    return firestore.collection(housesCollections).snapshots();
  }

  static getdetails(){
    return firestore.collection(detailCollections).snapshots();
  }
}

