import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/constants.dart';
import 'package:multi_quiz_s_t_tt9/pages/level_describtion.dart';
import 'package:multi_quiz_s_t_tt9/pages/multiple_q_screen.dart';
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
        image: "assets/images/ballon-s.png",
        colors: [kL1, kL12],
        routeName: '/level1'),
    Level(
        title: "Multiple choice",
        subtitle: "Level 2",
        colors: [kL2, kL22],
        routeName: '/level2',
        icon: Icons.play_arrow,
        image: "assets/images/ballon-b.png",
        description: "multible choice")
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
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
            itemCount: mylevel.length,
            itemBuilder: (BuildContext context, int index) {
              return MyLevelWidget(
                function: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LevelDescription();
                  }));
                },
                level: mylevel[index],
              );
            }),
      )),
    );
  }
}
