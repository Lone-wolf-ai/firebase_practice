import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/repository.dart';
import 'package:firebase_practice/utils/exceptions/firebase_exceptions.dart';
import 'package:firebase_practice/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FirebasePracticeController extends GetxController {
  static FirebasePracticeController get instance => Get.find();
  final firebaserepo = Get.put(FirebaseRepo());

  ///textediting controller
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RxString documentID = ''.obs;
  RxString doc = ''.obs;
  RxList datalist = [].obs;

  ///signup
  registerWithemailandPass() async {
    await firebaserepo.registerWithEmailandPassword(
        email.text.trim(), password.text.trim());
  }

  //signin
  signIn() async {
    await firebaserepo.signin(email.text.trim(), password.text.trim());
  }

  //signin anynomusly
  signinanynomusly() async {
    await firebaserepo.signinanynomusly();
  }

  //signout
  signOut() {
    firebaserepo.signOut();
  }

  ///Create a collection and add documents with basic data.
  addCollectionanddata(String name, Map<String, dynamic> data) async {
    try {
      final documentID = await firebaserepo.createCollection(name, data);
      if (kDebugMode) {
        print('Saved at $documentID');
      }
      this.documentID.value = documentID;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///create a subcollection
  addSubcollection(String collectionName, String subCollectionName,
      dynamic docId, Map<String, dynamic> data) async {
    try {
      final docref = firebaserepo.createSubCollection(
          collectionName, subCollectionName, docId, data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///read data from data using collection name and doc id
  readData(String collectionname, dynamic id) async {
    try {
      final data = await firebaserepo.readDataUsingIdandColletionname(
          collectionname, id);
      final snapshot = data.data().toString();
      doc.value = snapshot;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //read all the data
  readAlldataFromcollcetion(String collectionName) async {
    try {
      final data = await firebaserepo.readAllDocuments(collectionName);
      final datalist = data.map((e) => e.data()).toList();
      this.datalist.assignAll(datalist);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'something went wrong';
    }
  }

  //update data
  updateData(
      String collectionName, dynamic id, Map<String, dynamic> data) async {
    try {
      await firebaserepo.updateData(collectionName, id, data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'something went wrong';
    }
  }

  //delete data
  deleteDoc(String collectionName, dynamic id) async {
    try {
      await firebaserepo.deleteDate(collectionName, id);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'something went wrong';
    }
  }
}
