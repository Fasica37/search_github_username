import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  Future<void> fetchUser() async {
    final url = Uri.parse('https://api.github.com/users/Fasica37');
    try {
      var response = await http.get(url);
      var extractedData = json.decode(response.body);
      print(extractedData.toString());
    } catch (error) {}
  }
}
