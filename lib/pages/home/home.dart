import 'package:country_flags/country_flags.dart';
import 'package:flare/models/crypto.dart';
import 'package:flare/pages/controller.dart';
import 'package:flare/widgets/crypto_listing.dart';
import 'package:flare/widgets/left_view.dart';
import 'package:flare/widgets/left_view_top_widget.dart';
import 'package:flare/widgets/middle_view.dart';
import 'package:flare/widgets/right_view.dart';
import 'package:flare/widgets/toggle_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
