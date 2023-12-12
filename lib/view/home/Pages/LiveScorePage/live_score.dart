import 'package:flutter/material.dart';
import 'package:soccerbuddy/view/home/Pages/LiveScorePage/api_manager.dart';
import 'package:soccerbuddy/view/home/Pages/LiveScorePage/pagebody_.dart';

class LiveScorePage extends StatefulWidget {
  const LiveScorePage({super.key});

  @override
  State<LiveScorePage> createState() => _LiveScorePageState();
}

class _LiveScorePageState extends State<LiveScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 43, 66),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 230, 43, 66),
        elevation: 0.0,
        title: const Text(
          "LIVE SCORE",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SoccerApi().getAllMatches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print((snapshot.data)?.length);
            return Pagebody(snapshot.data);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
