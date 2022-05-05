import 'package:flutter/material.dart';
import 'package:my_movie_app/common/my_color.dart';
import 'package:my_movie_app/common/my_icons.dart';

class MyBottomNaviGationBar extends StatelessWidget {
  const MyBottomNaviGationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: MyColors.colorBackgroundBNB,
          ),
        ),
        child: BottomNavigationBar(
          iconSize: 31,
          currentIndex: 0,
          onTap: (index) {},
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedItemColor: MyColors.colorIcon,
          selectedIconTheme: const IconThemeData(color: MyColors.colorIcon),
          items: [
            BottomNavigationBarItem(
              icon: Container(
                  child: const Icon(MyIcons.icHome),
                  margin: const EdgeInsets.only(top: 14.0)),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(MyIcons.icFavourite),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(MyIcons.icTicket),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(MyIcons.icAccount),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(MyIcons.icShuffle),
              label: "",
            ),
          ],
        ),
      );
  }

}