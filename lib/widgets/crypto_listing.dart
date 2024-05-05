import 'package:flare/models/crypto.dart';
import 'package:flare/pages/controller.dart';
import 'package:flare/widgets/crypto_listing_modal_stat.dart';
import 'package:flare/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CryptoListing extends StatefulWidget {
  final CryptoData crypto;
  // final Controller controller;

  const CryptoListing({
    required this.crypto,
    // required this.controller,
    super.key,
  });

  @override
  State<CryptoListing> createState() => _CryptoListingState();
}

class _CryptoListingState extends State<CryptoListing> {
  late bool isPercentagePositive;

  @override
  void initState() {
    super.initState();
    isPercentagePositive = isPositive(widget.crypto.twentyFourHrPercentChange);
  }

  String formatNumberWithDecimalPlaces(double number, int decimals) {
    return number.toStringAsFixed(decimals);
  }

  String shortenTotalNumber(double number) {
    if (number >= 1000000000) {
      return '\$${(number / 1000000000).toStringAsFixed(2)}B';
    } else if (number >= 1000000) {
      return '\$${(number / 1000000).toStringAsFixed(2)}M';
    } else {
      return "\$${number.toString()}";
    }
  }

  bool isPositive(double number) {
    return number >= 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _dialogBuilder(
        context,
        widget.crypto,
        // widget.controller,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${widget.crypto.cmcRank}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SvgPicture.asset(
                  "assets/${widget.crypto.symbol}.svg",
                  width: 35,
                  height: 35,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.crypto.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.crypto.symbol,
                      style: const TextStyle(
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$ ${formatNumberWithDecimalPlaces(widget.crypto.price, 5)}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${formatNumberWithDecimalPlaces(widget.crypto.twentyFourHrPercentChange, 2)}%",
                      style: TextStyle(
                        color: isPercentagePositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, CryptoData crypto) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 600,
            width: 400,
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                    Text(
                      widget.crypto.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: append to external list that will populate other page
                        debugPrint("Added to watchlist");
                      },
                      icon: const Icon(Icons.star_border),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset(
                        "assets/${widget.crypto.symbol}.svg",
                        width: 55,
                        height: 55,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.crypto.name,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "\$",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                formatNumberWithDecimalPlaces(
                                    widget.crypto.price, 5),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 6, 15, 6),
                                decoration: BoxDecoration(
                                  color: isPercentagePositive
                                      ? Colors.green.withOpacity(0.15)
                                      : Colors.red.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${formatNumberWithDecimalPlaces(widget.crypto.twentyFourHrPercentChange, 2)}%',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isPercentagePositive
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const MainLineChart(),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Statistics",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ModalStatistic(
                  label: "24hr Volume",
                  stat: shortenTotalNumber(widget.crypto.twentyFourHrVolume),
                ),
                ModalStatistic(
                  label: "24hr volume change",
                  stat: shortenTotalNumber(
                      widget.crypto.twentyFourHrVolumeChange),
                ),
                ModalStatistic(
                  label: "Max Supply",
                  stat: shortenTotalNumber(widget.crypto.maxSupply as double),
                ),
                ModalStatistic(
                  label: "Total Supply",
                  stat: shortenTotalNumber(widget.crypto.totalSupply),
                ),
                ModalStatistic(
                  label: "1hr %",
                  stat: shortenTotalNumber(widget.crypto.oneHrPercentChange),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
