import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future addFoodItem(Map<String, dynamic> foodItemMap) async {
    return await FirebaseFirestore.instance
        .collection('foodItems')
        .add(foodItemMap);
  }

  Stream<QuerySnapshot> getFoodItems() {
    return FirebaseFirestore.instance.collection('foodItems').snapshots();
  }
}