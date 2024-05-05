import 'dart:convert';
import 'dart:html';

import 'package:flare/models/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';

class Controller extends GetxController {
  late final LocalStorage _localStorage;
  late final Logger logger;
  String? getList;
  RxList cryptoList = [].obs;
  RxList watchList = [].obs;

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

  Future<void> loadCryptoList() async {
    getList = await _localStorage.getItem("Crypto_List");
    // ADD CHECK IF LIST IS EMPTY TO CALL LIST
    // if (getList == null || getList.isEmpty) {
    //   debugPrint("No current list ... Data fetched!");
    //   await fetchData();
    // }

    var decodedString = jsonDecode(getList!);
    final Map map = Map.from(decodedString);
    // Extract the 'data' field from the map
    List<dynamic> dataList = map['data'];

    // Iterate over the list of objects and map them to CryptoData objects
    for (var data in dataList) {
      CryptoData cryptoData = CryptoData.fromMap(data);
      cryptoList.add(cryptoData);
    }

    // Is this list full
    logger.i(cryptoList.length);

    // Print the list of CryptoData objects
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
}
