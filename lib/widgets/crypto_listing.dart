import 'package:flare/models/crypto.dart';
import 'package:flare/pages/controller.dart';
import 'package:flare/widgets/crypto_listing_modal_stat.dart';
import 'package:flare/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CryptoListing extends StatefulWidget {
  final CryptoData crypto;
  final Controller controller;

  const CryptoListing({
    required this.crypto,
    required this.controller,
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
    isPercentagePositive =
        widget.controller.isPositive(widget.crypto.twentyFourHrPercentChange);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _dialogBuilder(context),
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
                      style: const TextStyle(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.controller.formatListingPrice(widget.crypto.price),
                      // "${widget.crypto.price}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.controller.formatPercentage(
                          widget.crypto.twentyFourHrPercentChange),
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

  Future<void> _dialogBuilder(BuildContext context) {
    void favorite(CryptoData crytpo, RxList list) {
      if (list.contains(crytpo)) {
        list.remove(crytpo);
      } else {
        list.add(crytpo);
      }
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            // height: 600,
            // TODO: MAKE DYNAMIC
            width: 400,
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
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
                      Obx(
                        () => IconButton(
                          onPressed: () {
                            favorite(
                                widget.crypto, widget.controller.watchList);
                            debugPrint("${widget.controller.watchList.length}");
                          },
                          icon: Icon(
                            Icons.star,
                            color: widget.controller.watchList
                                    .contains(widget.crypto)
                                ? Colors.yellow[700]
                                : Colors.grey,
                          ),
                        ),
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
                              widget.crypto.symbol,
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
                                  widget.controller
                                      .formatListingPrice(widget.crypto.price),
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
                                      widget.controller.formatPercentage(
                                        widget.crypto.twentyFourHrPercentChange,
                                      ),
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ModalStatistic(
                    label: "24hr Volume",
                    stat: widget.controller
                        .formatDollarAmount(widget.crypto.twentyFourHrVolume),
                  ),
                  ModalStatistic(
                    label: "24hr Price Change",
                    stat: widget.controller.formatDollarAmount(
                        widget.crypto.twentyFourHrVolumeChange),
                  ),
                  ModalStatistic(
                    label: "Market Cap",
                    stat: widget.controller
                        .formatDollarAmount(widget.crypto.marketCap),
                  ),
                  ModalStatistic(
                    label: "Fully Diluted Market",
                    stat: widget.controller.formatDollarAmount(
                        widget.crypto.fullyDilutedMarketCap),
                  ),
                  ModalStatistic(
                    label: "Max Supply",
                    stat: widget.crypto.maxSupply == null
                        ? "Inifinite"
                        : widget.controller.formatRegularNumber(
                            widget.crypto.maxSupply as double),
                  ),
                  ModalStatistic(
                    label: "Total Supply",
                    stat: widget.controller
                        .formatRegularNumber(widget.crypto.totalSupply),
                  ),
                  ModalStatistic(
                    label: "1hr",
                    stat: widget.controller
                        .formatPercentage(widget.crypto.oneHrPercentChange),
                    isPercentage: true,
                  ),
                  ModalStatistic(
                    label: "24hr",
                    stat: widget.controller.formatPercentage(
                        widget.crypto.twentyFourHrPercentChange),
                    isPercentage: true,
                  ),
                  ModalStatistic(
                    label: "7d",
                    stat: widget.controller
                        .formatPercentage(widget.crypto.sevenDayPercentChange),
                    isPercentage: true,
                  ),
                  ModalStatistic(
                    label: "30d",
                    stat: widget.controller
                        .formatPercentage(widget.crypto.thirtyDayPercentChange),
                    isPercentage: true,
                  ),
                  ModalStatistic(
                    label: "90d",
                    stat: widget.controller
                        .formatPercentage(widget.crypto.ninetyDayPercentChange),
                    isPercentage: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
