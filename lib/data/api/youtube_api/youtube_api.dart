import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';

class YoutubeApi {

  String apiKey = youtubeApiKey;
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
