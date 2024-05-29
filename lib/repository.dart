import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/utils/exceptions/firebase_exceptions.dart';
import 'package:firebase_practice/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FirebaseRepo extends GetxController {
  static FirebaseRepo get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ////HEre wrote auth codes
  ///signinwithemailandpassword
  signin(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
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

  ///register with email and password
  registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
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

  ///signinaninomusly
  signinanynomusly() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user!.uid;
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

  //signout
  void signOut() async {
    try {
      await _auth.signOut();
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

  ///data storage code

  ///create collection and add data
  createCollection(String collectionName, Map<String, dynamic> data) async {
    try {
      final docref = await _firestore.collection(collectionName).add(data);
      return docref.id;
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

  //create subcollection data
  createSubCollection(String collectionName, String subCollectionName,
      dynamic docId, Map<String, dynamic> data) async {
    try {
      final docref = _firestore
          .collection(collectionName)
          .doc(docId)
          .collection(subCollectionName)
          .add(data);
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

  ///read data from database using name and id
  Future<DocumentSnapshot<Map<String, dynamic>>>
      readDataUsingIdandColletionname(String collectionName, dynamic id) async {
    try {
      final docref = await _firestore.collection(collectionName).doc(id).get();
      return docref;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    throw 'Something went wrong';
  }

  ///read all data from database using collection

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readAllDocuments(
    String collectionName,
  ) async {
    try {
      final querySnapshot = await _firestore.collection(collectionName).get();
      return querySnapshot.docs;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message; // Or handle the error as needed
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message; // Or handle the error as needed
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.'; // Or provide a more user-friendly message
    }
  }

  ///update data
  updateData(
      String collectionName, dynamic id, Map<String, dynamic> data) async {
    try {
      _firestore.collection(collectionName).doc(id).update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message; // Or handle the error as needed
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message; // Or handle the error as needed
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.'; // Or provide a more user-friendly message
    }
  }

  ///delete doc
  deleteDate(String collectionName, dynamic id) async {
    try {
      await _firestore.collection(collectionName).doc(id).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message; // Or handle the error as needed
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message; // Or handle the error as needed
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.'; // Or provide a more user-friendly message
    }
  }
}
