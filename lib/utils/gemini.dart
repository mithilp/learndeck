import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiAPI {
  static Future<String> getGeminiData(message) async{
    var header = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> requestBody = {
      'contents': [
        {
          'parts': [
            {
              'text': message
            }
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.8,
        'topK': 1,
        'topP': 1,
        'maxOutputTokens': 2048,
        'stopSequences': []
      }
    };
    var response = await http.post(
      Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${dotenv.env['GEMINI_API']}'),
      headers: header,
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['candidates'][0]['content']['parts'][0]['text'].toString();
    } else {
      var response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${dotenv.env['GEMINI_API']}'),
        headers: header,
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200){
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['candidates'][0]['content']['parts'][0]['text'].toString();
      } else {
        print(response.body);
        throw 'Request Failed';
      }
    }
  }

  static Future<Map<String, dynamic>> getGeminiDataAndPassData(message , data) async{
    var header = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> requestBody = {
      'contents': [
        {
          'parts': [
            {
              'text': message
            }
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.8,
        'topK': 1,
        'topP': 1,
        'maxOutputTokens': 2048,
        'stopSequences': []
      }
    };
    var response = await http.post(
      Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${dotenv.env['GEMINI_API']}'),
      headers: header,
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['candidates']!= null) {

        if (jsonResponse['candidates'][0]['content'] != null) {

        }
        return {
          'response': jsonResponse['candidates'][0]['content']['parts'][0]
                  ['text']
              .toString(),
          'data': data
        };
      }else {
        throw Exception('Request Failed');
      }
    } else {
      var response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${dotenv.env['GEMINI_API']}'),
        headers: header,
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200){
        var jsonResponse = jsonDecode(response.body);
        return {
          'response': jsonResponse['candidates'][0]['content']['parts'][0]['text'].toString(),
          'data': data
        };
      } else {
        print(response.body);
        throw Exception('Request Failed');
      }
    }
  }

}