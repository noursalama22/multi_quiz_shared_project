import 'package:flutter/material.dart';

import '../constants.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
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
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              const Opacity(
                opacity: 0.8,
                child: Image(
                  image: AssetImage('assets/images/cloud.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        'Game',
                        style: TextStyle(
                            shadows: [
                              Shadow(
                                  color: Colors.white38,
                                  offset: Offset(1, 5),
                                  blurRadius: 5)
                            ],
                            // decorationStyle: TextDecorationStyle.double,
                            // decoration: TextDecoration.underline,
                            // decorationColor: kL2,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const Text(
                      'Quiz',
                      style: TextStyle(
                          shadows: [
                            Shadow(
                                color: Colors.white38,
                                offset: Offset(1, 5),
                                blurRadius: 5)
                          ],
                          // decorationStyle: TextDecorationStyle.double,
                          // decoration: TextDecoration.underline,
                          // decorationColor: kL2,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          backgroundColor: ky1,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 80),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home_screen');
                          // TODO :resolve pop
                        },
                        child: const Text(
                          'Start',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sf-Pro-Text',
                              fontSize: 24),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
