import 'dart:convert';

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static List<WebtoonModel> webtoonInstances = [];
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  //비동기 함수로 지정하면, 그 함수의 반환 값 타입은 Future이므로 Future로 감싸줘야 한다.
  // future : 당장 완료될 수 없는 작업
  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    // 요청을 기다려야 하기 때문에 await 사용. (async : 비동기 설정을 해줘야 한다.)
    final response = await http.get(url);
    // response가 성공한 경우
    if (response.statusCode == 200) {
      // body는 그냥 string이다.
      // 원래 응답의 포맷은 JSON이므로 JSON으로 변환해준다.
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  // ID로 webtoon 정보를 가져오는 함수
  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  // ID로 최근 episode를 가져오는 함수
  static Future<List<WebtoonEpisodeModel>> getLatesEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
