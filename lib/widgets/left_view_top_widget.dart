import 'package:flare/models/crypto.dart';
import 'package:flare/pages/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeftViewTopWidgetItem extends StatelessWidget {
  final CryptoData crypto;
  final Controller controller;
  const LeftViewTopWidgetItem({
    required this.crypto,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/${crypto.symbol}.svg",
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  crypto.symbol,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  controller.formatPrice(crypto.price),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  controller.formatPercentage(crypto.twentyFourHrPercentChange),
                  style: TextStyle(
                    color:
                        controller.isPositive(crypto.twentyFourHrPercentChange)
                            ? Colors.green
                            : Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
