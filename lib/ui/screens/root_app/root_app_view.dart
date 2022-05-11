import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/common/my_color.dart';
import 'package:my_movie_app/common/my_icons.dart';
import 'package:my_movie_app/ui/screens/home_screen.dart';
import 'package:my_movie_app/ui/screens/root_app/root_app_cubit.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  late final RootAppCubit _cubit;

  ///PageView page
  late List<Widget> pageList;
  late PageController pageController;

  @override
  void initState() {
    _cubit = BlocProvider.of<RootAppCubit>(context);
    //PageView page
    pageList = [
      const HomeScreen(),
      Container(color: Colors.green),
      Container(color: Colors.red),
      Container(color: Colors.black),
      Container(color: Colors.yellow),
    ];
    //Page controller
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return PageView(
      controller: pageController,
      children: pageList,
      onPageChanged: (index) {
        _cubit.switchTap(index);
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: MyColors.colorBackgroundBNB,
        ),
      ),
      child: BlocConsumer<RootAppCubit, RootAppState>(
        listenWhen: (prev, cur) => prev.selectedIndex != cur.selectedIndex,
        listener: (context, state) =>
            pageController.jumpToPage(state.selectedIndex),
        buildWhen: (prev, cur) => prev.selectedIndex != cur.selectedIndex,
        builder: (context, state) => BottomNavigationBar(
          iconSize: 31,
          showUnselectedLabels: false,
          currentIndex: state.selectedIndex,
          onTap: (index) {
            _cubit.switchTap(index);
          },
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
              label: "•",
            ),
            const BottomNavigationBarItem(
              icon: Icon(MyIcons.icFavourite),
              label: "•",
            ),
            const BottomNavigationBarItem(
              icon: Icon(MyIcons.icTicket),
              label: "•",
            ),
            const BottomNavigationBarItem(
              icon: Icon(MyIcons.icAccount),
              label: "•",
            ),
            const BottomNavigationBarItem(
              icon: Icon(MyIcons.icShuffle),
              label: "•",
            ),
          ],
        ),
      ),
    );
  }
}
