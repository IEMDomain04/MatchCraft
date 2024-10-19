import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<List<DocumentSnapshot>> getRankings(String IMBCollection) async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection(IMBCollection).get();
  return querySnapshot.docs;
}

class LeaderboardScreen3 extends StatelessWidget {
  final String IMBCollection;

  LeaderboardScreen3({required this.IMBCollection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/MatchCraftBG3.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              children: [
                Text(
                  "Item|Mob|Block: Leaderboard",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<List<DocumentSnapshot>>(
                    future: getRankings(IMBCollection),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      final rankings = snapshot.data!;
                      rankings.sort((a, b) {
                        var aTimeLeft = a['timeLeft'] as int;
                        var bTimeLeft = b['timeLeft'] as int;

                        // Sort by timeLeft, closest to 60 seconds for 4x4 and 120 seconds for 6x6
                        var timeComparison = (IMBCollection == "IMB Rankings")
                            ? (aTimeLeft - 60)
                                .abs()
                                .compareTo((bTimeLeft - 60).abs())
                            : (aTimeLeft - 120)
                                .abs()
                                .compareTo((bTimeLeft - 120).abs());

                        if (timeComparison != 0) {
                          return timeComparison;
                        } else {
                          return a['moves'].compareTo(b['moves']);
                        }
                      });

                      return ListView.builder(
                        itemCount: rankings.length,
                        itemBuilder: (context, index) {
                          var data =
                              rankings[index].data() as Map<String, dynamic>;
                          return ListTile(
                            leading: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontFamily: 'PassionOne',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            title: Text(
                              data['name'],
                              style: TextStyle(
                                fontFamily: 'PassionOne',
                                color: Color.fromARGB(255, 55, 188, 255),
                              ),
                            ),
                            subtitle: Text(
                              'Time Left: ${data['timeLeft']} seconds, Moves: ${data['moves']}',
                              style: TextStyle(
                                fontFamily: 'PassionOne',
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
