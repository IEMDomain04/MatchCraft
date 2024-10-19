import 'package:confetti/confetti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:match_card_game/game_screens/QuickestTime/quickTimeE.dart';
import 'package:match_card_game/pages/select_mode.dart';

class GameWinScreen extends StatefulWidget {
  final int duration;
  final int moves;
  final bool is4x4;

  const GameWinScreen({
    Key? key,
    required this.duration,
    required this.moves,
    required this.is4x4,
  }) : super(key: key);

  @override
  State<GameWinScreen> createState() => _GameWinScreenState();
}

class _GameWinScreenState extends State<GameWinScreen> {
  bool isConfettiPlaying = true;
  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 12),
  );

  TextEditingController _nameController = TextEditingController();
  bool get is4x4 => widget.is4x4;

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void saveDataToFirebase(String name, int time, int moves, bool is4x4) async {
    var database = FirebaseFirestore.instance;
    String collectionName = is4x4 ? '4x4 QT Rankings' : '6x6 QT Rankings';

    // Check if the name already exists in the collection
    var querySnapshot = await database
        .collection(collectionName)
        .where('name', isEqualTo: name)
        .get();

    // If the name exists, update the existing document; otherwise, add a new document
    if (querySnapshot.docs.isNotEmpty) {
      var docId = querySnapshot.docs.first.id;
      await database.collection(collectionName).doc(docId).update({
        "time": time,
        "moves": moves,
      });
    } else {
      database.collection(collectionName).add({
        "name": name,
        "time": time,
        "moves": moves,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/MatchCraftBG4.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 120),
                  Text(
                    "Quickest Time Result 4x4",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontFamily: 'PassionOne',
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Time: ${widget.duration} seconds",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PassionOne',
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Moves: ${widget.moves}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PassionOne',
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Be Crafty and fast next time! :)",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PassionOne',
                      fontSize: 20,
                      height: 3,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Enter your name",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PassionOne',
                              fontSize: 20,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PassionOne',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          String name = _nameController.text;
                          if (name.isNotEmpty) {
                            saveDataToFirebase(name, widget.duration,
                                widget.moves, widget.is4x4);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Name, Time, Number of moves submitted.'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontFamily: 'PassionOne',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(350, 50),
                    ),
                    child: Text(
                      "Play again",
                      style: TextStyle(
                        fontFamily: 'PassionOne',
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameModeSelection(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(350, 50),
                    ),
                    child: Text(
                      "Select Game mode",
                      style: TextStyle(
                        fontFamily: 'PassionOne',
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ConfettiWidget(
            numberOfParticles: 30,
            minBlastForce: 10,
            maxBlastForce: 20,
            blastDirectionality: BlastDirectionality.explosive,
            confettiController: _confettiController,
            gravity: 0.1,
          ),
        ],
      ),
    );
  }
}
