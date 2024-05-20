import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  
 group('Login user and get token', () {
  
  test('ggude7', () async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': 'ggude7',
        'password': 'MWwlaeWcOoF6',
        'expiresInMins': 30,
      }),
    );

    expect(response.statusCode, 200);
    expect(jsonDecode(response.body), isMap);
  });

  test('nloiterton8', () async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': 'nloiterton8',
        'password': 'HTQxxXV9Bq4',
        'expiresInMins': 30,
      }),
    );

    expect(response.statusCode, 200);
    expect(jsonDecode(response.body), isMap);
  });

  test('umcgourty9', () async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': 'umcgourty9',
        'password': 'i0xzpX',
        'expiresInMins': 30,
      }),
    );

    expect(response.statusCode, 200);
    expect(jsonDecode(response.body), isMap);
  });

  test('acharlota', () async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': 'acharlota',
        'password': 'M9lbMdydMN',
        'expiresInMins': 30,
      }),
    );

    expect(response.statusCode, 200);
    expect(jsonDecode(response.body), isMap);
  });

  test('rhallawellb', () async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': 'rhallawellb',
        'password': 'esTkitT1r',
        'expiresInMins': 30,
      }),
    );

    expect(response.statusCode, 200);
    expect(jsonDecode(response.body), isMap);
  });
});

   
}
