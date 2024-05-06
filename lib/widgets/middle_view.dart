import 'package:flare/models/crypto.dart';
import 'package:flare/pages/controller.dart';
import 'package:flare/widgets/crypto_listing.dart';
import 'package:flare/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MiddleView extends StatelessWidget {
  const MiddleView({
    super.key,
    required this.controller,
  });

  final Controller controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Coin X",
                style: GoogleFonts.cinzel(
                  textStyle: const TextStyle(
                    fontSize: 50,
                    letterSpacing: 15,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          blurRadius: 3),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const MainPieChart(),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.cryptoList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    CryptoData crypto = controller.cryptoList[index];
                    return CryptoListing(
                      crypto: crypto,
                      controller: controller,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
