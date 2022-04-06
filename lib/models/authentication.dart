import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'http_exception.dart';

class Authentication with ChangeNotifier {
  Future<void> signUp(String email, String password) async {
    Firebase.initializeApp();
    String urll =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCeIKZzwgbXUKUdaNI86IZhjnhOrs-owOc";

    final response = await http.post(Uri.parse(urll),
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    final responseData = json.decode(response.body);
    print(responseData);
  }

  Future<void> signIn(String email, String password) async {
    Firebase.initializeApp();

    String urll =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCeIKZzwgbXUKUdaNI86IZhjnhOrs-owOc";

    try {
      final response = await http.post(Uri.parse(urll),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
//    print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    }
    catch (error)
    {
      throw error;
    }
  }
}
