import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/repository.dart';
import 'package:firebase_practice/utils/exceptions/firebase_exceptions.dart';
import 'package:firebase_practice/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class FirebasePracticeController extends GetxController {
  static FirebasePracticeController get instance => Get.find();
  final firebaserepo = Get.put(FirebaseRepo());

  ///textediting controller
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RxString documentID = ''.obs;
  RxString doc = ''.obs;
  RxList datalist = [].obs;
  @override
  onInit() async {
    super.onInit();
    final permission = await Permission.locationWhenInUse.request();
  }

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
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      data['createdAt'] = FieldValue.serverTimestamp();
      data['location'] = GeoPoint(position.latitude, position.longitude);
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

  Future<List<QueryDocumentSnapshot>> filterData(
      String collectionName, String fieldName, dynamic value) async {
    try {
      final snapshot =
          await firebaserepo.filterUsingQuery(collectionName, fieldName, value);
      return snapshot
          .docs; // Return a list of documents (QueryDocumentSnapshot)
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return []; // Return an empty list on errors
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

  //storage
  Future<String> uploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      final compressedData = await FlutterImageCompress.compressWithFile(
          pickedFile!.path,
          quality: 70);
      final randomId = const Uuid().v4();
      if (compressedData != null) {
        final link =
            await firebaserepo.uploadFile(compressedData, "image/$randomId");
        return link;
      } else {
        throw 'No image selected.'; // Or handle errors as needed
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.';
    }
  }

  deleteData() async {
    try {
      await firebaserepo
          .deleteFile('image/ea2a0346-e02a-4de0-801f-535959f98e62');
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.';
    }
  }
}
