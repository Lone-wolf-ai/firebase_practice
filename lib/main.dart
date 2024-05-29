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

    Map<String, dynamic> data = {
      'name': 'tanjim',
      'age': 22,
      'mood': 'experincing absolute zero',
      'money': [100, 300, 200, 500],
      'need': {'data': "wolf", 'device': 'new phone', 'qty': 22.5}
    };

    const collectionname = 'diary';
    print(controller.doc.value);
    print(controller.documentID.value);
    controller.readData(collectionname, 'GwHBVc8RRnpLxmSEUTxe');
    controller.readAlldataFromcollcetion(collectionname);
    return Scaffold(
      appBar: AppBar(
        title: 'Firebase Practice'.text.make(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => controller.addSubcollection(collectionname,
                  'Subcollection', 'GwHBVc8RRnpLxmSEUTxe', data),
              child: 'Add'.text.make(),
            )
          ],
        ),
      ),
    );
  }
}
