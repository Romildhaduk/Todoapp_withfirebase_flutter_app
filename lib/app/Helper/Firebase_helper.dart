import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  CollectionReference firebasecollaction =
      FirebaseFirestore.instance.collection("Todo");
  Future newFirebaseTodo(String title, String Discription, bool isCompleted) async {
     final a = firebasecollaction.doc();
     a.set({
      "title": title,
      "Discription": Discription,
      "uid": a.id,
      "isCompleted": isCompleted,
       //"Status": status,
     });
  }

  Future deletelist(uid) async {
    await firebasecollaction.doc(uid).delete();
  }

  updatelist(uid,value)async{
    await firebasecollaction.doc(uid).update({"isCompleted":value});

  }
}
