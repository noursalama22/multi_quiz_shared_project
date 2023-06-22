import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/modules/level_Info.dart';

import '../constants.dart';
import '../widgets/my_outline_btn.dart';

class LevelDescription extends StatelessWidget {
  final Level level;
  final Function() onpress_btn;
  const LevelDescription(
      {Key? key, required this.level, required this.onpress_btn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: level.colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 74, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MYOutlineBtn(
                        icon: Icons.close,
                        function: () {
                          Navigator.pop(context);
                        },
                        bColor: Colors.white,
                        iconColor: Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(level.image!),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.subtitle!,
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
                      level.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Sf-Pro-Text',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      level.description!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Sf-Pro-Text',
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      onpress_btn();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'Game',
                        style: TextStyle(
                            color: kL2,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 120,
                )
              ],
            )),
      ),
    );
  }
}
