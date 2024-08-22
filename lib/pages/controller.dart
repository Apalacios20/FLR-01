import 'dart:convert';
import 'dart:math';

import 'package:flare/models/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';

class Controller extends GetxController {
  late final LocalStorage _localStorage;
  late final Logger logger;
  String? getList;
  RxList<CryptoData> cryptoList = <CryptoData>[].obs;
  RxList<CryptoData> watchList = <CryptoData>[].obs;
  RxList<CryptoData> leftViewTopWidgetList = <CryptoData>[].obs;

  // DROPDOWN
  RxList<String> dropDownList = <String>[].obs;
  List<String> dropDownSymbols = [];
  String dropDownValue = "Bitcoin";
  String dropDownCurrency = "US";
  String dropDownValueTwo = "Ethereum";
  RxList<String> dropDownCurrencies = ["US"].obs;
  TextEditingController cryptoConvertController = TextEditingController();
  double priorCryptoConvertValue = 0;
  TextEditingController cryptoTwoConvertController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  // TOGGLE TABS
  RxInt convertIndex = 0.obs;
  RxInt portfolioIndex = 0.obs;
  List<String> portfolioToggleList = ['Crypto', 'Portfolio (Coming soon)'];
  List<String> convertToggleList = ['Transact', 'Repeat (Coming soon)'];

  Controller() {}

  @override
  void onInit() async {
    super.onInit();
    await _init();
  }

  Future<void> _init() async {
    logger = Logger();

    await _initLocalStorage();
    await checkForCryptoList();
    await loadCryptoList();
    await buildLeftTopWidgetList();
  }

  // STORAGE
  Future<void> _initLocalStorage() async {
    _localStorage = LocalStorage('my_data');
    await _localStorage.ready;
    logger.i('Local Storage Initialized');
  }

  Future<void> checkForCryptoList() async {
    getList = await _localStorage.getItem("Crypto_List");
    if (getList == null || getList!.isEmpty) {
      debugPrint("No current list ... Data fetched!");
      await fetchData();
    }
  }

  Future<void> buildLeftTopWidgetList() async {
    RxList<CryptoData> leftList = getRandomCryptoList(cryptoList, 3);
    leftViewTopWidgetList.addAll(leftList);
  }

  Future<void> loadCryptoList() async {
    getList = await _localStorage.getItem("Crypto_List");

    var decodedString = jsonDecode(getList!);
    final Map map = Map.from(decodedString);
    List<dynamic> dataList = map['data'];

    for (var data in dataList) {
      CryptoData cryptoData = CryptoData.fromMap(data);
      cryptoList.add(cryptoData);
    }

    logger.i(cryptoList.length);

    cryptoList.forEach((crypto) {
      dropDownList.add(crypto.name);
      dropDownSymbols.add(crypto.symbol);

      logger.i(crypto.toString());
    });
    dropDownValue = dropDownList.first;

    debugPrint("dropDown list: $dropDownList");
    debugPrint("dropDown symbols: $dropDownSymbols");
  }

  Future<void> saveData(String localStorageKey, dynamic data) async {
    _localStorage.setItem(localStorageKey, data);
  }

  // API CALLS
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/'));
      if (response.statusCode == 200) {
        await saveData("Crypto_List", response.body);
      } else {
        throw Exception('Failed to load data from Go server');
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  // MOVE AROUND STORED DATA FUNCTIONS
  RxList<CryptoData> getRandomCryptoList(
      RxList<CryptoData> cryptoList, int count) {
    Random random = Random();
    RxList<CryptoData> selectedList = <CryptoData>[].obs;

    if (count >= cryptoList.length) {
      return cryptoList;
    }

    while (selectedList.length < count) {
      int index = random.nextInt(cryptoList.length);
      CryptoData crypto = cryptoList[index];

      if (!selectedList.contains(crypto)) {
        selectedList.add(crypto);
      }
    }

    return selectedList;
  }

  // NUMBER CLEAN UP FUNCTIONS
  bool isPositive(double number) {
    return number >= 0;
  }

  String formatPercentage(double number) {
    return "${number.toStringAsFixed(2)}%";
  }

  String formatDollarAmount(double number) {
    if (number < 0) {
      return '\$ ${number.toStringAsFixed(2)}';
    } else if (number >= 1000000000000) {
      return '\$ ${(number / 1000000000000).toStringAsFixed(1).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]},',
          )}T';
    } else if (number >= 1000000000) {
      return '\$ ${(number / 1000000000).toStringAsFixed(1).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]},',
          )}B';
    } else if (number >= 1000000) {
      return '\$ ${(number / 1000000).toStringAsFixed(2).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]},',
          )}M';
    } else {
      return "\$ ${number.toStringAsFixed(2)}";
    }
  }

  String formatRegularNumber(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]},',
          )}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]},',
          )}M';
    } else {
      return number.toStringAsFixed(2);
    }
  }

  String formatListingPrice(double number) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    final formattedNumber = formatter.format(number);

    if (number <= 1) {
      return "\$ ${number.toStringAsFixed(5)}";
    } else if (number < 10) {
      return "\$ ${number.toStringAsFixed(3)}";
    } else {
      return "\$ $formattedNumber";
    }
  }

  String formatCryptoHolding(double number) {
    final formatter = NumberFormat("#,##0.00000", "en_US");
    final formattedNumber = formatter.format(number);

    return formattedNumber;
  }
}
