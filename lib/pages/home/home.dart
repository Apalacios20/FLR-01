import 'package:flare/models/crypto.dart';
import 'package:flare/pages/controller.dart';
import 'package:flare/widgets/crypto_listing.dart';
import 'package:flare/widgets/left_view.dart';
import 'package:flare/widgets/left_view_top_widget.dart';
import 'package:flare/widgets/middle_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      child:
          //  TEST // 3 VIEWS START
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LeftView(controller: controller),
          MiddleView(controller: controller),
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * .30,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Text(
                  "Anything to Anything",
                  style: GoogleFonts.chakraPetch(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // TODO: LEFT OFF BULDING THE ANYTHING TO ANYTHING TOGGLE
                // FlutterToggleTab(
                //   width: 50,
                //   borderRadius: 15,
                //   selectedTextStyle: TextStyle(
                //       color: Colors.white,
                //       fontSize: 18,
                //       fontWeight: FontWeight.w600),
                //   unSelectedTextStyle: TextStyle(
                //       color: Colors.blue,
                //       fontSize: 14,
                //       fontWeight: FontWeight.w400),
                //   labels: _listGenderText,
                //   icons: _listIconTabToggle,
                //   selectedIndex: _tabTextIconIndexSelected,
                //   selectedLabelIndex: (index) {
                //     setState(() {
                //       _tabTextIconIndexSelected = index;
                //     });
                //   },
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
