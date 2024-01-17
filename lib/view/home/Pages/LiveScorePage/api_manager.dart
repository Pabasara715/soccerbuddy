import 'dart:convert';

import 'package:http/http.dart';
import 'package:soccerbuddy/view/home/Pages/LiveScorePage/soccermodel.dart';

class SoccerApi {
  final String apiUrl = "https://v3.football.api-sports.io/fixtures?live=all";
  // "https://v3.football.api-sports.io/fixtures?season=2023&league=2";

  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    'x-rapidapi-key': "430b664738bb21b4eba94dd565ca9680"
  };

  Future<List<SoccerMatch>> getAllMatches() async {
    try {
      Response res = await get(Uri.parse(apiUrl), headers: headers);

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        List<dynamic> matchesList = body['response'];
        List<SoccerMatch> matches = matchesList
            .map((dynamic item) => SoccerMatch.fromJson(item))
            .toList();

        return matches;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch data');
    }
  }
}
