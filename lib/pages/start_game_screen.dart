import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'dialogs.dart';
import 'package:match_card_game/pages/select_mode.dart';

class StartGameScreen extends StatelessWidget {
  const StartGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/MatchCraftBG.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 230),
                children: [
                  LottieBuilder.asset(
                    "assets/MatchCraftAnimation.json",
                    height: 200,
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 25),
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const GameModeSelection(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 69, 138, 44),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                minimumSize: Size(250, 0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "Play!",
                                  style: TextStyle(
                                    fontFamily: 'PassionOne',
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                showHowToPlayDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 219, 93, 21),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                minimumSize: Size(250, 0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "How to play",
                                  style: TextStyle(
                                    fontFamily: 'PassionOne',
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    selectLeaderboard(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 17, 40, 174),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    minimumSize: Size(250, 0),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      "Leaderboards",
                                      style: TextStyle(
                                        fontFamily: 'PassionOne',
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        8), // Add some space between the buttons
                              ],
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                minimumSize: Size(100, 0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Exit Game",
                                  style: TextStyle(
                                    fontFamily: 'PassionOne',
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              left: 5,
              bottom: 1,
              child: Text(
                "Developed by DOm",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PassionOne',
                  fontSize: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
