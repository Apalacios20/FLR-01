import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';

class Controller extends GetxController {
  late final LocalStorage _localStorage;
  late final Logger logger;

  Controller() {
    _initLocalStorage();
    logger = Logger();
  }

  // STORAGE
  Future<void> _initLocalStorage() async {
    _localStorage = LocalStorage('my_data');
    await _localStorage.ready;
  }

  Future<void> saveCryptoList(Map<String, dynamic> data) async {
    if (!await _localStorage.ready) {
      logger.d("Storage not initialized");
      await _initLocalStorage();
    }

    Future<String> mainList = getThisInfo("MainList");

    if (await mainList == '') {
      logger.i('New MainList Saved');
      saveObject('MainList', data);
    }
  }

  Future<void> saveObject(
      String localStorageKey, Map<String, dynamic> data) async {
    String jsonString = jsonEncode(data);

    _localStorage.setItem(localStorageKey, jsonString);
  }

  Future<String> getThisInfo(String infoRequest) async {
    String request = await _localStorage.getItem(infoRequest);

    return request == '' ? '' : request;
  }

  // FETCH DATA
  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/'));
      if (response.statusCode == 200) {
        // TEST
        logger.i("response: ${response.body}");
        return response.body;
      } else {
        throw Exception('Failed to load data from Go server');
      }
    } catch (e) {
      debugPrint("Error: $e");
      return '';
    }
  }
}
