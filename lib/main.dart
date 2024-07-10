import 'package:firebase_core/firebase_core.dart';
import 'package:flare/firebase_options.dart';
import 'package:flare/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  usePathUrlStrategy();

  LocalStorage localStorage = LocalStorage('my_data');
  await localStorage.ready;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Coin X",
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
