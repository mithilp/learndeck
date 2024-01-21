import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiAPI {
  static Map<String, String> getHeader() {
    return {
      'Content-Type': 'application/json',
    };
  }

  static Future<String> getGeminiData(message) async{
    print('entered method');
    var header = {
      'Content-Type': 'application/json',
    };
    print('got header');
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
    print('sending request');
    var response = await http.post(
      Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${dotenv.env['GEMINI_API']}'),
      headers: header,
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['candidates'][0]['content']['parts'][0]['text'].toString();
    } else {
      return 'Error 400: Request Failed';
    }
  }
}