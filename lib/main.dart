import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/firebase_options.dart';
import 'package:firebase_practice/utils/exceptions/firebase_exceptions.dart';
import 'package:firebase_practice/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FirebasePractice(),
    );
  }
}

class FirebasePractice extends StatelessWidget {
  const FirebasePractice({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FirebasePracticeController());
    return Scaffold(
      appBar: AppBar(
        title: 'Firebase Practice'.text.make(),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.email,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  TextFormField(
                    controller: controller.password,
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () => controller.signinanynomusly(),
                child: 'signup'.text.make()),
          ],
        ),
      ),
    );
  }
}

class FirebasePracticeController extends GetxController {
  static FirebasePracticeController get instance => Get.find();
  final firebaserepo = Get.put(FirebaseRepo());

  ///textediting controller
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
  signOut(){
    firebaserepo.signOut();
  }
  //add data and  collection name in firebase
  addCollectionanddata(String name,Map<String,dynamic>data)async{
    try{
    final document=await firebaserepo.createCollection(name, data);
    return document.toString();
    }  on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

class FirebaseRepo extends GetxController {
  static FirebaseRepo get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  ////HEre wrote auth codes
  ///signinwithemailandpassword
  signin(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
    }
  }

  ///register with email and password
  registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
    }
  }

  ///signinaninomusly
  signinanynomusly() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user!.uid;
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
    } catch (e) {
      print(e.toString());
    }
  }
  ///data storage code
  createCollection(String collectionName,Map<String,dynamic>data)async{
    final docref=await _firestore.collection(collectionName).add(data);
    if(kDebugMode){
      print(docref);
    }
  }
}
