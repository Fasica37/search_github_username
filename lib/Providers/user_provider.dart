import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  Map _userInfo = {};

  Map get userInfo {
    return _userInfo;
  }

  Future<void> fetchUser(String userName) async {
    final url = Uri.parse('https://api.github.com/users/$userName');
    try {
      var response = await http.get(url);
      var extractedData = json.decode(response.body);
      print('ffffffffffffffffffffffffffffffffffffff');
      _userInfo = extractedData as Map;
      print(_userInfo.toString());
    } catch (error) {}
    notifyListeners();
  }
}
