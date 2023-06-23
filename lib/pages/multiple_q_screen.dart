import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:multi_quiz_s_t_tt9/modules/multipe_choice/quizBrainMultiple.dart';
import 'package:multi_quiz_s_t_tt9/pages/home.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';

class MultiQScreen extends StatefulWidget {
  const MultiQScreen({Key? key}) : super(key: key);

  @override
  State<MultiQScreen> createState() => _MultiQScreenState();
}

class _MultiQScreenState extends State<MultiQScreen> {
  QuizBrainMulti quizBrain = QuizBrainMulti();
  List<Icon> scoreKeeper = [];
  int score = 0;
  int counter = 10;
  bool? isCorrect;
  int? userChoice;
  late Timer timer;
  Color favColor = Colors.white;
  double favScal = 1;

  final player = AudioPlayer(); // Create a player

  void checkAnswer() {
    int correctAnswer = quizBrain.getQuestionAnswer();
    cancelTimer();
    setState(() {
      if (correctAnswer == userChoice) {
        score++;
        print('Score $score');
        isCorrect = true;
        setState(() {
          favColor = Colors.red;
          favScal = 1.5;
          Timer(Duration(seconds: 1), () {
            setState(() {
              favScal = 1;
            });
          });
          Timer(Duration(seconds: 2), () {
            setState(() {
              favColor = Colors.white;
            });
          });

          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        });
      } else {
        isCorrect = false;
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    });

    // if (quizBrain.isFinished()) {
    //   cancelTimer();
    //
    //   Timer(Duration(seconds: 1), () {
    //     alertFinished();
    //     setState(() {
    //       quizBrain.reset();
    //       scoreKeeper.clear();
    //       isCorrect = null;
    //       counter = 10;
    //     });
    //   });
    // }
  }

  void next() {
    if (quizBrain.isFinished()) {
      cancelTimer();
      // alertFinished();
      Timer(const Duration(seconds: 1), () {
        alertFinished();
        setState(() {
          quizBrain.reset();
          scoreKeeper.clear();
          isCorrect = null;
          counter = 10;
        });
      });
    } else {
      counter = 10;
      startTimer();
    }
    setState(() {
      isCorrect = null;
      userChoice = null;
      quizBrain.nextQuestion();
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        counter--;
      });
      if (counter == 5) {
        final duration = await player.setUrl( // Load a URL
            'assets/sound/tick_tock.mp3'); // Schemes: (https: | file: | asset: )
        player.play();
      }
      if (counter == 0 && userChoice == null) {
        timer.cancel();
        setState(() {
          scoreKeeper.add(Icon(
            Icons.question_mark,
            color: Colors.white,
          ));
        });
        next();
      }
    });
  }

  void cancelTimer() {
    timer.cancel();
  }

  void alertFinished() {
    Alert(
      context: context,
      title: 'Your Score',
      desc: "$score/${quizBrain.getQuestiosNumber()}",
      buttons: [
        DialogButton(
            child: const Text('Finish'),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home_screen', (route) => false);
            }),
        DialogButton(
          child: const Text('Play Again'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
    ).show();
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kBlueBg,
              kL2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: MYOutlineBtn(
                      icon: Icons.close,
                      iconColor: Colors.white,
                      bColor: Colors.white,
                      function: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: CircularProgressIndicator(
                          value: counter / 10,
                          color: counter >= 5 ? Colors.white : Colors.redAccent,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                      Text(
                        counter.toString(),
                        style: TextStyle(
                          fontFamily: 'Sf-Pro-Text',
                          fontSize: 24,
                          color: counter >= 5 ? Colors.white : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: AnimatedScale(
                      scale: favScal,
                      duration: Duration(seconds: 1),
                      child: Icon(
                        Icons.favorite,
                        color: favColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: const BorderSide(color: Colors.white)),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/ballon-b.png'),
                ),
              ),
              Text(
                'question ${quizBrain.getCurrentQNumber()} of ${quizBrain.getQuestiosNumber()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white60,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${quizBrain.getQuestionText()}',
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // Padding(
              //   padding: const EdgeInsets.only(bottom: 12),
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.white,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              //     ),
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           width: 24,
              //         ),
              //         Expanded(
              //           child: Center(
              //             child: Text(
              //               'Bremen',
              //               style: TextStyle(
              //                   color: kL2,
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: 18),
              //             ),
              //           ),
              //         ),
              //         Icon(
              //           Icons.check_rounded,
              //           color: kL2,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: quizBrain.getOptions().length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        onPressed: userChoice == null
                            ? () {
                                print("Index:$index");
                                userChoice = index;
                                checkAnswer();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, 60),
                          disabledBackgroundColor: userChoice != null
                              ? (isCorrect! && userChoice == index)
                                  ? Colors.lightGreen
                                  : userChoice == index
                                      ? Colors.red
                                      : Colors.white54
                              : Colors.white,
                          backgroundColor: userChoice != null
                              ? (isCorrect! && userChoice == index)
                                  ? Colors.lightGreen
                                  : userChoice == index
                                      ? Colors.red
                                      : Colors.white
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  quizBrain.getOptions()[index],
                                  style: TextStyle(
                                      color: userChoice != null
                                          ? userChoice == index
                                              ? Colors.white
                                              : kL2
                                          : kL2,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Icon(
                              userChoice == null
                                  ? null
                                  : isCorrect! && userChoice == index
                                      ? Icons.check
                                      : userChoice == index
                                          ? Icons.close
                                          : null,
                              color: userChoice != null
                                  ? userChoice == index
                                      ? Colors.white
                                      : null
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: scoreKeeper,
              ),
              TextButton(
                onPressed: () {
                  print('Next Pressed');
                  next();
                },
                child: Text(
                  userChoice != null ? 'Next' : '',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 12),
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: kG1,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              //     ),
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           width: 24,
              //         ),
              //         Expanded(
              //           child: Center(
              //             child: Text(
              //               'Gaza',
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: 18),
              //             ),
              //           ),
              //         ),
              //         Icon(
              //           Icons.check_rounded,
              //           color: Colors.white,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
