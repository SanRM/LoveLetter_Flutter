import 'dart:convert';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class YoutubeApi {

  //String apiKey = dotenv.env['API_KEY']!;
  String apiKey = 'AIzaSyBRqdS9lFF3o_nR55Yp1R38Od8qXmENVYo';
  String url = 'https://www.googleapis.com/youtube/v3/';

  getVideosIdInPlaylist({required String playListId, int limit = 80}) async {

    try {

      var url = Uri.parse('https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=${limit.toString()}&playlistId=$playListId&key=$apiKey');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        
        var data = jsonDecode(response.body);

        List<String> videosId = [];

        for (var item in data['items']) {
          videosId.add(item['snippet']['resourceId']['videoId']);
        }

        return videosId;
      }
    } catch (e) {
      //print('Error: $e');
    }

  }

}
