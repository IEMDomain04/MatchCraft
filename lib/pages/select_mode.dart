import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:match_card_game/pages/start_game_screen.dart';
import 'dialogs.dart';

class GameModeSelection extends StatefulWidget {
  const GameModeSelection({Key? key}) : super(key: key);

  @override
  State<GameModeSelection> createState() => _GameModeSelectionState();
}

class _GameModeSelectionState extends State<GameModeSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/MatchCraftBG2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 200),
          children: [
            LottieBuilder.asset(
              "assets/MatchCraftAnimation.json",
              height: 150,
            ),
            const SizedBox(
              height: 1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select Game Mode",
                  style: TextStyle(
                    fontFamily: 'PassionOne',
                    fontSize: 30,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: Colors.black,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30), // Add some vertical spacing here
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          playQuickestTime(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(250, 0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Quickest Time",
                            style: TextStyle(
                              fontFamily: 'PassionOne',
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Add some vertical spacing here
                      ElevatedButton(
                        onPressed: () {
                          playCountDown(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(250, 0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "CountDown",
                            style: TextStyle(
                              fontFamily: 'PassionOne',
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Add some vertical spacing here
                      ElevatedButton(
                        onPressed: () {
                          playImb(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(250, 0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Items|Mobs|Blocks",
                            style: TextStyle(
                              fontFamily: 'PassionOne',
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Add some vertical spacing here
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartGameScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 63, 82, 91),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(100, 0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Back",
                            style: TextStyle(
                              fontFamily: 'PassionOne',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Add some vertical spacing here
              ],
            )
          ],
        ),
      ),
    );
  }
}
