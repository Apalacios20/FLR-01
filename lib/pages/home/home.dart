import 'package:flare/pages/controller.dart';
import 'package:flare/widgets/left_view.dart';
import 'package:flare/widgets/middle_view.dart';
import 'package:flare/widgets/right_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      padding: EdgeInsets.fromLTRB(
          20,
          MediaQuery.of(context).size.height * 0.03,
          20,
          MediaQuery.of(context).size.height * 0.03),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LeftView(controller: controller),
          MiddleView(controller: controller),
          RightView(controller: controller),
        ],
      ),
    );
  }
}
