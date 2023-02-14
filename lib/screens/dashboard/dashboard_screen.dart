import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/task/task_bloc.dart';
import '../../bloc/theme/app_theme_bloc.dart';
import '../home/home_screen.dart';
import '../recycle_bin/recycle_bin_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});
  static const id = "dashboard_screen";

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late final PageController _pageController;
  var _page = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // _newsfeedBloc = NewsfeedBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  List<Widget> listPage = [
    const HomeScreen(),
    const Center(child: Text("2")),
    const Center(child: Text("3")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App", style: Theme.of(context).textTheme.titleSmall),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: listPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.art_track),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "home",
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
      drawer: Drawer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100.h,
          ),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return ListTile(
                title: Text("${state.removeTasks.length} Bin"),
                onTap: () =>
                    Navigator.of(context).pushNamed(RecycleBinScreen.id),
              );
            },
          ),
          const Divider(),
          // BlocBuilder<TaskBloc, TaskState>(
          //   builder: (context, state) {
          //     return ListTile(
          //       title: Text("${state.allTask.length} Tasks"),
          //       onTap: () => Navigator.of(context).pushNamed(HomeScreen.id),
          //     );
          //   },
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Changes theme",
                    style: Theme.of(context).textTheme.titleMedium),
                BlocBuilder<AppThemeBloc, AppThemeState>(
                    builder: (context, state) {
                  return CupertinoSwitch(
                    value: state.isDark,
                    onChanged: (value) {
                      value
                          ? context.read<AppThemeBloc>().add(ThemeOnChange())
                          : context.read<AppThemeBloc>().add(ThemeOffChange());
                    },
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("settings",
                    style: Theme.of(context).textTheme.titleMedium),
                const Icon(Icons.settings),
              ],
            ),
          ),
        ],
      )),
    );
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
