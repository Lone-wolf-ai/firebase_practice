import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/controller.dart';
import 'package:firebase_practice/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true, host: '10.0.2.2:8080');
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
    const collectionName = 'diary';
    String url = '';
    upload() async {
      final String u = await controller.uploadImage();
      print(u);
    }

    return Scaffold(
      appBar: AppBar(
        title: 'Firebase Practice'.text.make(),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ElevatedButton(
            child: Text('upload $url'),
            onPressed: () => controller.deleteData(),
          )),
    );
  }
}
