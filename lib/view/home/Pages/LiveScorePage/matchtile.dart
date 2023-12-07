import 'package:flutter/material.dart';
import 'soccermodel.dart';

typedef MatchTileCallback = void Function(int index);

Widget matchTile(SoccerMatch match, int index, MatchTileCallback onTap) {
  var homeGoal = match.goal.home;
  var awayGoal = match.goal.away;
  if (homeGoal == null) homeGoal = 0;
  if (awayGoal == null) awayGoal = 0;

  return GestureDetector(
    onTap: () => onTap(index),
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              match.home.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
          Image.network(
            match.home.logoUrl,
            width: 36.0,
          ),
          Expanded(
            child: Text(
              "${homeGoal} - ${awayGoal}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
          Image.network(
            match.away.logoUrl,
            width: 36.0,
          ),
          Expanded(
            child: Text(
              match.away.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
