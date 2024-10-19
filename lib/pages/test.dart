import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:match_card_game/pages/start_game_screen.dart';
import 'package:match_card_game/pages/select_mode.dart';

class GameWinScreenLL extends StatefulWidget {
  final int duration;
  final int moves;

  const GameWinScreenLL({
    Key? key,
    required this.duration,
    required this.moves,
  }) : super(key: key);

  @override
  State<GameWinScreenLL> createState() => _GameWinScreenLLState();
}

class _GameWinScreenLLState extends State<GameWinScreenLL> {
  bool isConfettiPlaying = true;
  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 12),
  );

  TextEditingController _nameController = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _confettiController.play();
    _loadPrefs();
  }

  void _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _saveScore() {
    final playerName = _nameController.text;
    final quickTimeScore = (widget.duration / 60 * widget.moves / 8) * 1;

    // Save the score locally
    _prefs.setString('playerName', playerName);
    _prefs.setInt('time', widget.duration);
    _prefs.setInt('moves', widget.moves);
    _prefs.setDouble('quickTimeScore', quickTimeScore);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double quickestTimeScore = (widget.duration / 60 * widget.moves / 8) * 1;

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
                  SizedBox(height: 5),
                  Text(
                    "QuicketTime Score: ${quickestTimeScore.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PassionOne',
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Congratulations!",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PassionOne',
                      fontSize: 28,
                      height: 3,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
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
                          builder: (context) => const StartGameScreen(),
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
                      "Back to Home Screen",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveScore();
          // Show leaderboard dialog
          _showLeaderboardDialog();
        },
        child: Icon(Icons.leaderboard),
      ),
    );
  }

  void _showLeaderboardDialog() {
    // Implement your leaderboard dialog to show the stored scores
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Leaderboard'),
          content: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final playerName = snapshot.data!.getString('playerName');
                final time = snapshot.data!.getInt('time');
                final moves = snapshot.data!.getInt('moves');
                final quickTimeScore =
                    snapshot.data!.getDouble('quickTimeScore');

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Player Name: $playerName'),
                    Text('Time: $time seconds'),
                    Text('Moves: $moves'),
                    Text(
                        'QuickTime Score: ${quickTimeScore?.toStringAsFixed(2)}'),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
