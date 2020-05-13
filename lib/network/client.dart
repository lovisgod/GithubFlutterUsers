import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutterusers/network/user.dart';
import 'package:http/http.dart' as http;

class Client {

  Future<List<User>> fetchUsers() async {
  List<User>users = List<User>();  
  final response =
      await http.get('https://api.github.com/users?language=flutter');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List data = convert.jsonDecode(response.body);
    for (var item in data) {
      users.add(User.fromJson(item));
    }
    return users;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load users');
  }
}
}