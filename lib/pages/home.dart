import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/constants.dart';
import 'package:multi_quiz_s_t_tt9/pages/level_describtion.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';

import '../modules/level_Info.dart';
import '../widgets/my_level_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Level> mylevel = [
    Level(
        title: "true or false",
        subtitle: "Level 1",
        description: "true or false quiz",
        icon: Icons.check,
        image: "assets/images/bags.png",
        colors: [kL1, kL12],
        routeName: '/level1'),
    Level(
        title: "Multiple choice",
        subtitle: "Level 2",
        colors: [kL2, kL22],
        routeName: '/level2',
        icon: Icons.play_arrow,
        image: "assets/images/ballon-s.png",
        description: "multible choice"),
    // Level(
    //     title: "Multiple choice",
    //     subtitle: "Level 2",
    //     colors: [kL2, kL22],
    //     routeName: '/level2',
    //     icon: Icons.play_arrow,
    //     image: "assets/images/ballon-s.png",
    //     description: "multible choice"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          MYOutlineBtn(
            icon: Icons.favorite,
            iconColor: kBlueIcon,
            bColor: kGreyFont.withOpacity(0.5),
            function: () {
              print("11111");
            },
          ),
          MYOutlineBtn(
              icon: Icons.person,
              iconColor: kBlueIcon,
              bColor: kGreyFont.withOpacity(0.5),
              function: () {
                print("2222");
              }),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let\'s Play',
              style: TextStyle(
                fontSize: 32,
                color: kRedFont,
                fontWeight: FontWeight.bold,
                fontFamily: kFontFamily,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Be the First!',
              style: TextStyle(
                fontSize: 18,
                color: kGreyFont,
                fontFamily: kFontFamily,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: mylevel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MyLevelWidget(
                      function: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LevelDescription(
                            level: mylevel[index],
                          );
                        }));
                      },
                      level: mylevel[index],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
