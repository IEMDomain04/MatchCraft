import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:match_card_game/data/dataEasy.dart';
import 'package:match_card_game/pages/game_win.dart';
import 'package:match_card_game/pages/start_game_screen.dart';

class MyFlipCardGame extends StatefulWidget {
  const MyFlipCardGame({Key? key}) : super(key: key);

  @override
  State<MyFlipCardGame> createState() => _MyFlipCardGameState();
}

class _MyFlipCardGameState extends State<MyFlipCardGame> {
  int _previousIndex = -1;
  int _time = 3;
  int gameDuration = -3;
  int _moves = 0; // Added variable to track moves
  bool _flip = false;
  bool _start = false;
  bool _wait = false;
  late bool _isFinished;
  late Timer _timer;
  late Timer _durationTimer;
  late int _left;
  late List _data;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _time = (_time - 1);
      });
    });
  }

  void startDuration() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        gameDuration = (gameDuration + 1);
      });
    });
  }

  void startGameAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  void initializeGameData() {
    _data = createShuffledListFromImageSource();
    _cardFlips = getInitialItemStateList();
    _cardStateKeys = createFlipCardStateKeysList();
    _time = 3;
    _left = (_data.length ~/ 2);
    _isFinished = false;
  }

  void pauseGame() {
    setState(() {
      _timer.cancel();
      _durationTimer.cancel();
    });
  }

  @override
  void initState() {
    startTimer();
    startDuration();
    startGameAfterDelay();
    initializeGameData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _durationTimer.cancel();
  }

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_data[index]),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  void gamePaused(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.80),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor:
                  Colors.transparent, // Set background color to transparent
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    10.0), // Set border radius for the dialog
                child: Container(
                  // Wrap Column with Container
                  decoration: BoxDecoration(
                    // Add decoration for background image
                    image: DecorationImage(
                      image: AssetImage("assets/MatchCraftBG3.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Pause Menu',
                            style: TextStyle(
                                fontFamily: 'PassionOne',
                                color: Colors.yellow,
                                fontSize: 15)),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              startDuration();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text('Continue',
                                style: TextStyle(
                                    fontFamily: 'PassionOne', fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
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
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text('Restart',
                                style: TextStyle(
                                    fontFamily: 'PassionOne', fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
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
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text('Back to Home',
                                style: TextStyle(
                                    fontFamily: 'PassionOne', fontSize: 18)),
                          ),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return _isFinished
        ? GameWinScreen(
            duration: gameDuration,
            moves: _moves,
            is4x4: true,
          )
        : Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/MatchCraftBG3.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Moves: $_moves', // Display moves
                                style: theme.bodyMedium!.copyWith(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'PressStart2p',
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Remaining: $_left',
                                style: theme.bodyMedium!.copyWith(
                                  color:
                                      const Color.fromARGB(255, 177, 189, 255),
                                  fontFamily: 'PressStart2p',
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Duration: ${gameDuration}s',
                                style: theme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontFamily: 'PressStart2p',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        GridView.builder(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (context, index) => _start
                              ? FlipCard(
                                  key: _cardStateKeys[index],
                                  onFlip: () {
                                    if (!_flip) {
                                      _flip = true;
                                      _previousIndex = index;
                                    } else {
                                      _flip = false;
                                      if (_previousIndex != index) {
                                        _moves++; // Increment moves
                                        if (_data[_previousIndex] !=
                                            _data[index]) {
                                          _wait = true;

                                          Future.delayed(
                                              const Duration(milliseconds: 280),
                                              () {
                                            _cardStateKeys[_previousIndex]
                                                .currentState!
                                                .toggleCard();
                                            _previousIndex = index;
                                            _cardStateKeys[_previousIndex]
                                                .currentState!
                                                .toggleCard();

                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 160), () {
                                              setState(() {
                                                _wait = false;
                                              });
                                            });
                                          });
                                        } else {
                                          _cardFlips[_previousIndex] = false;
                                          _cardFlips[index] = false;
                                          debugPrint("$_cardFlips");
                                          setState(() {
                                            _left -= 1;
                                          });
                                          if (_cardFlips
                                              .every((t) => t == false)) {
                                            debugPrint("Won");
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 160), () {
                                              setState(() {
                                                _isFinished = true;
                                                _start = false;
                                              });
                                              _durationTimer.cancel();
                                            });
                                          }
                                        }
                                      }
                                      setState(() {});
                                    }
                                  },
                                  flipOnTouch:
                                      _wait ? false : _cardFlips[index],
                                  direction: FlipDirection.HORIZONTAL,
                                  speed: 200,
                                  front: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "assets/images/image_cover.png",
                                        ),
                                      ),
                                    ),
                                    margin: const EdgeInsets.all(4.0),
                                  ),
                                  // Wrap getItem with Opacity to change opacity when matched
                                  back: Opacity(
                                    opacity: _cardFlips[index] ? 1.0 : 0.2,
                                    child: getItem(index),
                                  ),
                                )
                              : getItem(index),
                          itemCount: _data.length,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(100, 0),
                            ),
                            onPressed: () {
                              pauseGame();
                              gamePaused(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Pause',
                                style: TextStyle(
                                    fontFamily: 'PassionOne',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
