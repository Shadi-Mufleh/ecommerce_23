import 'dart:async';
import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 late String collection = "users";

   Future<void> createUser(Map<String, dynamic> data) async{
     try{
       await _firestore.collection(collection).doc(data["uid"]).set(data);
       print("USER WAS CREATED");
     }catch(e){
       print('ERROR: ${e.toString()}');
     }


  }

  Future<UserModel> getUserById(String id)=> _firestore.collection(collection).doc(id).get().then((doc){
   print("==========id is $id=============");
   debugPrint("==========NAME is ${doc['name']}=============");
   debugPrint("==========NAME is ${doc['name']}=============");
   debugPrint("==========NAME is ${doc['name']}=============");
   debugPrint("==========NAME is ${doc['name']}=============");

   print("==========NAME is ${doc['name']}=============");
   print("==========NAME is ${doc['name']}=============");
   print("==========NAME is ${doc['name']}=============");


   return UserModel.fromSnapshot(doc);
  });

  void addToCart({required String userId, required CartItemModel cartItem}){
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({required String userId, required CartItemModel cartItem}){
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
}