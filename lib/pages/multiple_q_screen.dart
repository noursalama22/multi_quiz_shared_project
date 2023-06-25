import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:multi_quiz_s_t_tt9/modules/multipe_choice/quizBrainMultiple.dart';
import 'package:multi_quiz_s_t_tt9/pages/home.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';
import 'package:quickalert/quickalert.dart';

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

  final player = AudioPlayer();

  bool counterFinished = false;

  bool showCorrectAnswer = false; // Create a player

  void checkAnswer() {
    if (counter <= 5) {
      player.stop();
    }
    int correctAnswer = quizBrain.getQuestionAnswer();
    cancelTimer();
    setState(() {
      if (correctAnswer == userChoice) {
        score++;
        print('Score $score');
        isCorrect = true;
        setState(() {
          favColor = Colors.redAccent;
          favScal = 2;
          Timer(Duration(milliseconds: 300), () {
            setState(() {
              favScal = 1;
            });
          });
          Timer(Duration(milliseconds: 1000), () {
            setState(() {
              favColor = Colors.white;
            });
          });

          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.lightGreen,
              size: 24,
            ),
          );
        });
      } else {
        isCorrect = false;
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.redAccent,
            size: 24,
          ),
        );
      }
    });

    // if (quizBrain.isFinished()) {
    //   cancelTimer();
    //
    //   Timer(Duration(seconds: 2), () {
    //     alertFinished();
    //     setState(() {
    //       quizBrain.reset();
    //       scoreKeeper.clear();
    //       isCorrect = null;
    //       userChoice = null;
    //       counter = 10;
    //     });
    //   });
    // }
  }

  void next() {
    if (quizBrain.isFinished()) {
      alertFinished();
      setState(() {
        counterFinished = false;
        quizBrain.reset();
        scoreKeeper.clear();
        isCorrect = null;
        userChoice = null;
        counter = 10;
      });
    } else {
      setState(() {
        counterFinished = false;
        showCorrectAnswer = false;
      });
      counter = 10;
      startTimer();
      setState(() {
        isCorrect = null;
        userChoice = null;
        quizBrain.nextQuestion();
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        counter--;
      });
      if (counter == 5) {
        final duration = await player.setAsset(// Load a URL
            'assets/sounds/clock_tic.mp3'); // Schemes: (https: | file: | asset: )
        player.play();
      }
      if (counter == 0 && userChoice == null) {
        counterFinished = true;
        player.stop();
        timer.cancel();
        setState(() {
          scoreKeeper.add(Icon(
            Icons.question_mark,
            color: Colors.white,
          ));
        });
        // next();
      }
    });
  }

  void cancelTimer() {
    timer.cancel();
  }

  void alertFinished() {
    QuickAlert.show(
      context: context,
      type: score < (quizBrain.getQuestiosNumber() / 2)
          ? QuickAlertType.error
          : QuickAlertType.success,
      text: 'Your Score is $score/${quizBrain.getQuestiosNumber()}',
      title: score < (quizBrain.getQuestiosNumber() / 2)
          ? 'Good Luck!😞'
          : 'Congratulations! 🎉',
      confirmBtnText: 'Play Agin',
      onConfirmBtnTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      onCancelBtnTap: () {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home_screen', (route) => false);
      },
      showCancelBtn: true,
      cancelBtnText: 'Finish',
      confirmBtnColor: Colors.green,
    );
    // Alert(
    //   context: context,
    //   title: 'Your Score',
    //   desc: "$score/${quizBrain.getQuestiosNumber()}",
    //   closeFunction: () {
    //     Navigator.pushNamedAndRemoveUntil(
    //         context, '/home_screen', (route) => false);
    //   },
    //   buttons: [
    //     DialogButton(
    //         child: const Text('Finish'),
    //         onPressed: () {
    //           Navigator.pushNamedAndRemoveUntil(
    //               context, '/home_screen', (route) => false);
    //         }),
    //     DialogButton(
    //       child: const Text('Play Again'),
    //       onPressed: () {
    //         Navigator.pop(context);
    //         Navigator.pop(context);
    //       },
    //     ),
    //   ],
    // ).show();
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.stop();
    super.dispose();
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
          padding:
              const EdgeInsets.only(top: 56, left: 20, right: 20, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MYOutlineBtn(
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: CircularProgressIndicator(
                          value: counter / 10,
                          color: counter > 5 ? Colors.white : Colors.redAccent,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                      Text(
                        counter.toString(),
                        style: TextStyle(
                          fontFamily: 'Sf-Pro-Text',
                          fontSize: 24,
                          color: counter > 5 ? Colors.white : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: AnimatedScale(
                      scale: favScal,
                      duration: Duration(milliseconds: 500),
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
                height: 20,
              ),
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/ballon-b.png'),
                ),
              ),
              const SizedBox(
                height: 16,
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
              AutoSizeText(
                maxLines: 3,
                quizBrain.getQuestionText(),
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 28,
              ),
              // Text(
              //   '${quizBrain.getQuestionText()}',
              //   style: const TextStyle(
              //     fontSize: 30,
              //     fontFamily: 'Sf-Pro-Text',
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),

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
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: quizBrain.getOptions().length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: counterFinished
                            ? null
                            : userChoice == null
                                ? () {
                                    print("Index:$index");
                                    userChoice = index;
                                    checkAnswer();
                                  }
                                : null,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                  colors: userChoice != null
                                      ? (isCorrect! && userChoice == index)
                                          ? [ky1, ky2]
                                          : userChoice == index
                                              ? [kr1, kr2]
                                              : showCorrectAnswer &&
                                                      quizBrain
                                                              .getQuestionAnswer() ==
                                                          index
                                                  ? [ky1, ky2]
                                                  : [
                                                      Colors.white54,
                                                      Colors.white54
                                                    ]
                                      : showCorrectAnswer &&
                                              quizBrain.getQuestionAnswer() ==
                                                  index
                                          ? [ky1, ky2]
                                          : [Colors.white, Colors.white],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                      // child: ElevatedButton(
                      //   onPressed: userChoice == null
                      //       ? () {
                      //           print("Index:$index");
                      //           userChoice = index;
                      //           checkAnswer();
                      //         }
                      //       : null,
                      //   style: ElevatedButton.styleFrom(
                      //     minimumSize: Size(0, 60),
                      //     disabledBackgroundColor: userChoice != null
                      //         ? (isCorrect! && userChoice == index)
                      //             ? Colors.lightGreen
                      //             : userChoice == index
                      //                 ? Colors.red
                      //                 : Colors.white54
                      //         : Colors.white,
                      //     backgroundColor: userChoice != null
                      //         ? (isCorrect! && userChoice == index)
                      //             ? Colors.lightGreen
                      //             : userChoice == index
                      //                 ? Colors.red
                      //                 : Colors.white
                      //         : Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 12, horizontal: 16),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       const SizedBox(
                      //         width: 24,
                      //       ),
                      //       Expanded(
                      //         child: Center(
                      //           child: Text(
                      //             quizBrain.getOptions()[index],
                      //             style: TextStyle(
                      //                 color: userChoice != null
                      //                     ? userChoice == index
                      //                         ? Colors.white
                      //                         : kL2
                      //                     : kL2,
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 20),
                      //           ),
                      //         ),
                      //       ),
                      //       Icon(
                      //         userChoice == null
                      //             ? null
                      //             : isCorrect! && userChoice == index
                      //                 ? Icons.check
                      //                 : userChoice == index
                      //                     ? Icons.close
                      //                     : null,
                      //         color: userChoice != null
                      //             ? userChoice == index
                      //                 ? Colors.white
                      //                 : null
                      //             : null,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    );
                  },
                ),
              ),
              Wrap(
                children: scoreKeeper,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        showCorrectAnswer = true;
                      });

                      print(showCorrectAnswer);
                    },
                    child: Text(
                      ((userChoice == null && counter == 0) ||
                              (userChoice != null && !isCorrect!))
                          ? 'Show Answer'
                          : '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      next();
                    },
                    child: Text(
                      (userChoice != null || userChoice == null && counter == 0)
                          ? (userChoice == null &&
                                      counter == 0 &&
                                      quizBrain.isFinished() ||
                                  (userChoice != null &&
                                      quizBrain.isFinished()))
                              ? 'Show Result'
                              : 'Next'
                          : '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
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
              // const SizedBox(
              //   height: 16,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
