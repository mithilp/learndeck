import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class YouTubeAPI {
  static Future<String> getVideo(String query) async {
    final headers = {
      'Accept': 'application/json',
      'Accept-Encoding': 'gzip',
    };

    final url = Uri.parse(
        'https://youtube.googleapis.com/youtube/v3/search?part=snippet&q=${query}&type=video&videoEmbeddable=true&key=${dotenv.env['YOUTUBE_API']}');

    try {
      final res = await http.get(url, headers: headers);
      final status = res.statusCode;
      if (status != 200) throw Exception('http.get error: statusCode= $status');

      return await json.decode(res.body)['items'][0]['id']['videoId'];
    } catch (e) {
      print('Retrying...');
      sleep(Duration(seconds: 3));
      print('3s done');
      final res = await http.get(url, headers: headers);
      final status = res.statusCode;
      if (status != 200) throw Exception('http.get error: statusCode= $status');

      return await json.decode(res.body)['items'][0]['id']['videoId'];
    }
  }
}
