import 'package:flutter/material.dart';
import 'package:soccerbuddy/view/home/Pages/LiveScorePage/goalstat.dart';
import 'package:soccerbuddy/view/home/Pages/LiveScorePage/matchstat.dart';
import 'package:soccerbuddy/view/home/Pages/LiveScorePage/matchtile.dart';
import 'package:soccerbuddy/view/home/Pages/LiveScorePage/soccermodel.dart';

class Pagebody extends StatefulWidget {
  final List<SoccerMatch>? allmatches;

  const Pagebody(this.allmatches, {Key? key}) : super(key: key);

  @override
  State<Pagebody> createState() => _PagebodyState();
}

class _PagebodyState extends State<Pagebody> {
  int selectedMatchIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.allmatches != null &&
                      widget.allmatches!.isNotEmpty)
                    teamStat(
                      "Home Team",
                      widget.allmatches![selectedMatchIndex].home.logoUrl,
                      widget.allmatches![selectedMatchIndex].home.name,
                    )
                  else
                    (Text(
                      "NO LIVE MATCHES TO SHOW",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )), // Placeholder or alternative content

                  if (widget.allmatches != null &&
                      widget.allmatches!.isNotEmpty)
                    goalStat(
                      widget.allmatches![selectedMatchIndex].fixture.status
                          .elapsedTime,
                      widget.allmatches![selectedMatchIndex].goal.home,
                      widget.allmatches![selectedMatchIndex].goal.away,
                    )
                  else
                    Container(), // Placeholder or alternative content

                  if (widget.allmatches != null &&
                      widget.allmatches!.isNotEmpty)
                    teamStat(
                      "Away Team",
                      widget.allmatches![selectedMatchIndex].away.logoUrl,
                      widget.allmatches![selectedMatchIndex].away.name,
                    )
                  else
                    Container(), // Placeholder or alternative content
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "MATCHES",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.allmatches?.length ?? 0,
                      itemBuilder: (context, index) {
                        return matchTile(
                          widget.allmatches![index],
                          index,
                          (clickedIndex) {
                            setState(() {
                              selectedMatchIndex = clickedIndex;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
