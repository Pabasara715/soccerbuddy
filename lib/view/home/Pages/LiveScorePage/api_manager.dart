//before let's add the http package
import 'dart:convert';

import 'package:http/http.dart';
import 'package:soccerbuddy/view/home/Pages/LiveScorePage/soccermodel.dart';

class SoccerApi {
  //now let's set our variables
  //first : let's add the endpoint URL
  // we will get all the data from api-sport.io
  // we will just change our endpoint
  //the null means that the match didn't started yet
  //let's fix that
  final String apiUrl = "https://v3.football.api-sports.io/fixtures?live=all";
  //  "https://v3.football.api-sports.io/fixtures?season=2023&league=2";
  //In our tutorial we will only see how to get the live matches
  //make sure to read the api documentation to be ables too understand it

  // you will find your api key in your dashboard
  //so create your account it's free
  //Now let's add the headers
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    //Always make sure to check the api key and the limit of a request in a free api
    'x-rapidapi-key': "430b664738bb21b4eba94dd565ca9680"
  };

  //Now we will create our method
  //but before this we need to create our model

  //Now we finished with our Model
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
