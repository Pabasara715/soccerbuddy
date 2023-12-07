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
        title: Text(
          "LIVE SCORE",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24),
        ),
        centerTitle: true,
      ),
      //now we have finished the api service let's call it
      //Now befo re we create Our layout let's create our API service
      body: FutureBuilder(
        future: SoccerApi()
            .getAllMatches(), //Here we will call our getData() method,
        builder: (context, snapshot) {
          //the future builder is very intersting to use when you work with api
          if (snapshot.hasData) {
            print((snapshot.data)?.length);
            return Pagebody(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }, // here we will buil the app layout
      ),
    );
  }
}
