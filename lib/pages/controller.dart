import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:flare/models/crypto.dart';
import 'package:flare/widgets/left_view_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';

class Controller extends GetxController {
  late final LocalStorage _localStorage;
  late final Logger logger;
  String? getList;
  RxList<CryptoData> cryptoList = <CryptoData>[].obs;
  RxList<CryptoData> watchList = <CryptoData>[].obs;
  RxList<CryptoData> leftViewTopWidgetList = <CryptoData>[].obs;

  List<String> get _listTextTabToggle =>
      ["Tab A (10)", "Tab B (6)", "Tab C (9)"];

  List<String> get _listTextSelectedToggle =>
      ["Select A (10)", "Select B (6)", "Select C (9)"];

  List<String> get _listGenderText => ["Male", "Female"];

  // RxList leftViewTopWidgetList = <CryptoData>[].obs;
  // List<CryptoData> leftViewTopWidgetList = [];

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
    // leftViewTopWidgetList = getRandomCryptoList(cryptoList, 3).obs;
    await buildLeftTopWidgetList();
    logger.e("${leftViewTopWidgetList[0]}");
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

    cryptoList.forEach((cryptoData) {
      logger.i(cryptoData.toString());
    });
  }

  // possibly make this save any kind of data regardless of the type
  Future<void> saveData(String localStorageKey, dynamic data) async {
    _localStorage.setItem(localStorageKey, data);
  }

  // local storage get STRING
  Future<String> getThisInfo(String infoRequest) async {
    String request = await _localStorage.getItem(infoRequest);

    return request == '' ? '' : request;
  }

  // API CALLS

  // FETCH DATA // SEE IF YOU CAN MAKE UNIVERSAL BY ADDING STRING PARAMETER FOR LOCAL STORAGE ID
  // later i want this fetch to build the new list to display upon complete request
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
  // List getRandomCryptoList(RxList cryptoList, int count) {
  //   Random random = Random();
  //   List selectedList = [];

  //   if (count >= cryptoList.length) {
  //     return cryptoList;
  //   }

  //   while (selectedList.length < count) {
  //     int index = random.nextInt(cryptoList.length);
  //     var crypto = cryptoList[index];

  //     if (!selectedList.contains(crypto)) {
  //       selectedList.add(crypto);
  //     }
  //   }

  //   return selectedList;
  // }

  // NUMBER CLEAN UP FUNCTION
  bool isPositive(double number) {
    return number >= 0;
  }

  String formatNumberWithDecimalPlaces(double number, int decimals) {
    return number.toStringAsFixed(decimals);
  }

  String formatPercentage(double number) {
    return "${number.toStringAsFixed(2)}%";
  }

  String shortenDollarAmount(double number) {
    if (number < 0) {
      return '\$ ${number.toStringAsFixed(4)}';
    } else if (number >= 1000000000000) {
      return '\$ ${(number / 1000000000000).toStringAsFixed(1)}T';
    } else if (number >= 1000000000) {
      return '\$ ${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '\$ ${(number / 1000000).toStringAsFixed(2)}M';
    } else {
      return "\$${number.toString()}";
    }
  }

  String shortenRegularNumber(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else {
      return number.toString();
    }
  }

  String formatPrice(double number) {
    if (number <= 1) {
      return "\$ ${number.toStringAsFixed(5)}";
    } else if (number < 10) {
      return "\$ ${number.toStringAsFixed(3)}";
    } else {
      return "\$ ${number.toStringAsFixed(2)}";
    }
  }
}
