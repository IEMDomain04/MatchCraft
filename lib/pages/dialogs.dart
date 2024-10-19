import 'package:flutter/material.dart';
import 'package:match_card_game/game_screens/CountDown/countDownM.dart';
import 'package:match_card_game/game_screens/IMB/imb.dart';
import 'package:match_card_game/game_screens/QuickestTime/quickTimeE.dart';
import 'package:match_card_game/pages/rankingsIMB.dart';
import 'package:match_card_game/pages/rankingsQT.dart';
import 'package:match_card_game/pages/rankingsCD.dart';

//How to play information. Added Pop Up animation.
void showHowToPlayDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Center(
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/MatchCraftBG3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  // Wrap Column in SingleChildScrollView
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "How to Play MatchCraft:\nMatching Game",
                          style: TextStyle(
                            fontFamily: 'PassionOne',
                            fontSize: 25,
                            color: Colors.yellow,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "There are 3 game modes in the game\n\n"
                          "1. Quickest Time: Complete the Game as fast as you can and the time will be your score. The lower the time the better.\n\n"
                          "2. CountDown: There are limited time to each game difficulty.\n"
                          "\tYou need to finish: \n > Easy in under 1min\n > Medium in under 2mins\n\n"
                          "3. Item|Mobs|Blocks: The game of Minecraft have items, different mobs, and a many different blocks. You need to match the items, blocks, or mobs, but the images are not the same. (Coming Soon).\n\n"
                          "Each of the game modes have 2 difficulties:\n > Easy: 4x4\n > Medium: 6x6\n\n"
                          "Finished Game:\n You can enter your name in the game to save your time and moves on the leaderboards.",
                          style: TextStyle(
                            fontFamily: 'PassionOne',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontFamily: 'PassionOne',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

//For Quickest Time Dialog. Added Slide up animation.
void playQuickestTime(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Center(
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          )),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/MatchCraftBG3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Quickest Time",
                        style: TextStyle(
                          fontFamily: 'PassionOne',
                          fontSize: 25,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "4x4 Grid: Complete the Game as fast as you can!",
                        style: TextStyle(
                          fontFamily: 'PassionOne',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyFlipCardGame(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(150, 0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "4x4",
                                style: TextStyle(
                                  fontFamily: 'PassionOne',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontFamily: 'PassionOne',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

//For CountDown Dialog. Added Slide up animation.
void playCountDown(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Center(
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          )),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/MatchCraftBG3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "CountDown",
                        style: TextStyle(
                          fontFamily: 'PassionOne',
                          fontSize: 25,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "6x6 Grid: Complete the game with Time Limit",
                        style: TextStyle(
                          fontFamily: 'PassionOne',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CountDownM(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(150, 0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Start",
                                style: TextStyle(
                                  fontFamily: 'PassionOne',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontFamily: 'PassionOne',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

void playImb(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Center(
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          )),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/MatchCraftBG3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Items | Mobs | Blocks",
                        style: TextStyle(
                          fontFamily: 'PassionOne',
                          fontSize: 25,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "If you know how to play Minecraft, you can finish this mode.\n"
                        "4x4 Grid: Different images, but same category in Minecraft. Good luck!",
                        style: TextStyle(
                          fontFamily: 'PassionOne',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center, // Center align the text
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ImbGame(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(150, 0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Start",
                                style: TextStyle(
                                  fontFamily: 'PassionOne',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontFamily: 'PassionOne',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

//Leaderboard Dialog
void selectLeaderboard(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Center(
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          )),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/MatchCraftBG3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Select Leaderboard to display:",
                        style: TextStyle(
                          fontFamily: 'PassionOne',
                          fontSize: 25,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "This displays the rankings of all players submitting their name and score in the game.",
                        style: TextStyle(
                          fontFamily: 'PassionOne',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LeaderboardScreen(
                                      quickestTimeCollection:
                                          "4x4 QT Rankings"),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(150, 0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Quick Time Leaderboard",
                                style: TextStyle(
                                  fontFamily: 'PassionOne',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LeaderboardScreen2(
                                      CountdownCollection: "6x6 CD Rankings"),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(150, 0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Countdown Leaderboard",
                                style: TextStyle(
                                  fontFamily: 'PassionOne',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LeaderboardScreen3(
                                      IMBCollection: "IMB Rankings"),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(230, 0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "IMB Leaderboard",
                                style: TextStyle(
                                  fontFamily: 'PassionOne',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontFamily: 'PassionOne',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
