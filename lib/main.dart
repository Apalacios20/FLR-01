import 'package:firebase_core/firebase_core.dart';
import 'package:flare/firebase_options.dart';
import 'package:flare/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      title: "FLR-01",
      home: Scaffold(
        // appBar: AppBar(
        //   leading: const Icon(Icons.monetization_on_outlined),
        //   title: Text(
        //     "Flare-01",
        //     style: GoogleFonts.orbitron(
        //       textStyle: const TextStyle(
        //         fontSize: 30,
        //         letterSpacing: 10,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //   ),
        //   centerTitle: true,
        //   actions: [
        //     // TODO: place in list and iterate to reduce repeating code
        //     TextButton(
        //       onPressed: () {},
        //       child: Text(
        //         "Dashboard",
        //         style: GoogleFonts.orbitron(
        //           textStyle: const TextStyle(letterSpacing: 1),
        //         ),
        //       ),
        //     ),
        //     TextButton(
        //       onPressed: () {},
        //       child: Text(
        //         "Portfolio",
        //         style: GoogleFonts.orbitron(
        //           textStyle: const TextStyle(letterSpacing: 1),
        //         ),
        //       ),
        //     ),
        //     TextButton(
        //       onPressed: () {},
        //       child: Text(
        //         "Watch list",
        //         style: GoogleFonts.orbitron(
        //           textStyle: const TextStyle(letterSpacing: 1),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       width: 25,
        //     ),
        //   ],
        // ),
        body: Home(),
      ),
    );
  }
}
