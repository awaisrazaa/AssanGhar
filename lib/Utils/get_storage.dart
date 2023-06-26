import 'package:get_storage/get_storage.dart';

class GetStoreData{
 static  final box = GetStorage();
  static void storeEmail({required email}){
    box.write('email', email);
  }
  static getEmail(){
    return box.read('email');
  }
 static void storeName({required name}){
   box.write('name', name);
 }
 static getName(){
   return box.read('name');
 }

}