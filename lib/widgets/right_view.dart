import 'package:country_flags/country_flags.dart';
import 'package:flare/pages/controller.dart';
import 'package:flare/widgets/toggle_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RightView extends StatefulWidget {
  final Controller controller;
  const RightView({
    required this.controller,
    super.key,
  });

  @override
  State<RightView> createState() => _RightViewState();
}

class _RightViewState extends State<RightView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * .35,
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
          const SizedBox(
            height: 20,
          ),
          // TODO: BUiLD THE ANYTHING TO ANYTHING TOGGLE
          ToggleTab(
            selectedIndex: widget.controller.convertIndex,
            labels: widget.controller.convertToggleList,
          ),
          const SizedBox(
            height: 35,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Convert Crypto to Crypto",
              style: GoogleFonts.chakraPetch(
                textStyle: const TextStyle(
                  fontSize: 12,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // TODO: make below a reusable widget
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.controller.cryptoConvertController,
                    onChanged: (value) {
                      if (value == "") {
                        widget.controller.currencyController.text = "";
                        widget.controller.cryptoTwoConvertController.text = "";
                        return;
                      }
                      double doubleValue = double.parse(value);

                      int index = widget.controller.dropDownList
                          .indexOf(widget.controller.dropDownValue);
                      int index2 = widget.controller.dropDownList
                          .indexOf(widget.controller.dropDownValueTwo);

                      double price = widget.controller.cryptoList[index].price;
                      double price2 =
                          widget.controller.cryptoList[index2].price;

                      widget.controller.currencyController.text = widget
                          .controller
                          .formatListingPrice(doubleValue * price);
                      widget.controller.cryptoTwoConvertController.text = widget
                          .controller
                          .formatCryptoHolding((doubleValue * price) / price2);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                      border: const OutlineInputBorder(),
                      labelText: 'From ${widget.controller.dropDownValue}',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: const TextStyle(fontSize: 17),
                      suffixIcon: widget.controller.dropDownList == [].obs
                          ? Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/BTC.svg",
                                width: 25,
                                height: 25,
                              ),
                            )
                          : DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: widget.controller.dropDownValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    widget.controller.dropDownValue = newValue!;

                                    // clear controllers
                                    widget.controller.cryptoConvertController
                                        .text = "";
                                    widget.controller.cryptoTwoConvertController
                                        .text = "";
                                    widget.controller.currencyController.text =
                                        "";
                                  });
                                },
                                items: widget.controller.dropDownList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  int index = widget.controller.dropDownList
                                      .indexOf(value);
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        "assets/${widget.controller.dropDownSymbols[index]}.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Obx(
          // () =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: widget.controller.currencyController,
                  onChanged: (value) {
                    // TODO: NEED TO FORMAT SELF CONTROLLERS TEXT
                    if (value == "") {
                      widget.controller.cryptoConvertController.text = "";
                      widget.controller.cryptoTwoConvertController.text = "";
                      return;
                    }
                    double doubleValue = double.parse(value);

                    int index = widget.controller.dropDownList
                        .indexOf(widget.controller.dropDownValue);
                    int index2 = widget.controller.dropDownList
                        .indexOf(widget.controller.dropDownValueTwo);

                    double price = widget.controller.cryptoList[index].price;
                    double price2 = widget.controller.cryptoList[index2].price;

                    widget.controller.cryptoConvertController.text = widget
                        .controller
                        .formatCryptoHolding(doubleValue / price);
                    widget.controller.cryptoTwoConvertController.text = widget
                        .controller
                        .formatCryptoHolding((doubleValue / price2));
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                    border: const OutlineInputBorder(),
                    labelText: '~',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: const TextStyle(fontSize: 25),
                    suffixIcon: widget.controller.dropDownCurrencies == [].obs
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CountryFlag.fromCountryCode(
                              'US',
                              height: 20,
                              width: 20,
                              borderRadius: 8,
                            ),
                          )
                        : DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: widget.controller.dropDownCurrency,
                              onChanged: (String? newValue) {
                                setState(() {
                                  widget.controller.dropDownCurrency =
                                      newValue!;
                                });
                              },
                              items: widget.controller.dropDownCurrencies
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CountryFlag.fromCountryCode(
                                    value,
                                    height: 26,
                                    width: 26,
                                    borderRadius: 8,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: widget.controller.cryptoTwoConvertController,
                    onChanged: (value) {
                      // TODO: DEEM THIS IN CONTROLLER
                      if (value == "") {
                        widget.controller.cryptoConvertController.text = "";
                        widget.controller.currencyController.text = "";
                        return;
                      }
                      double doubleValue = double.parse(value);

                      int index = widget.controller.dropDownList
                          .indexOf(widget.controller.dropDownValue);
                      int index2 = widget.controller.dropDownList
                          .indexOf(widget.controller.dropDownValueTwo);

                      double price = widget.controller.cryptoList[index].price;
                      double price2 =
                          widget.controller.cryptoList[index2].price;

                      widget.controller.currencyController.text = widget
                          .controller
                          .formatListingPrice(doubleValue * price2);
                      widget.controller.cryptoConvertController.text = widget
                          .controller
                          .formatCryptoHolding((doubleValue * price2) / price);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                      border: const OutlineInputBorder(),
                      labelText: 'From ${widget.controller.dropDownValueTwo}',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: const TextStyle(fontSize: 17),
                      suffixIcon: widget.controller.dropDownList == [].obs
                          ? Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/ETH.svg",
                                width: 25,
                                height: 25,
                              ),
                            )
                          : DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: widget.controller.dropDownValueTwo,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    widget.controller.dropDownValueTwo =
                                        newValue!;
                                  });
                                },
                                items: widget.controller.dropDownList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  int index = widget.controller.dropDownList
                                      .indexOf(value);
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        "assets/${widget.controller.dropDownSymbols[index]}.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
