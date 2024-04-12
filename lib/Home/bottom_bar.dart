import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/colors.dart';
import 'dashboard/me_profile.dart';
import 'dashboard/more_page.dart';
import 'dashboard/moticar_page.dart';
import 'dashboard/spend.dart';
import 'dashboard/timeline.dart';
import 'dashboard/timeline_filled.dart';
// import 'package:sizer/sizer.dart';

// @RoutePage()
class BottomHomePage extends StatefulWidget {
  const BottomHomePage({
    super.key,
  });

  @override
  State<BottomHomePage> createState() => _BottomHomePageState();
}

class _BottomHomePageState extends State<BottomHomePage> {
  int currentPageIndex = 0;

  final List<Widget> _pages = [
    const TimelinePage(),
    // const SpendPage(),
    const TimelineFilledPage(),
    const MoticarPage(),
    const MePage(),
    const MorePage(),
  ];
  List<bool> isLoading = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();
  }

  void onItemTapped(int index) {
    setState(() {
      isLoading[currentPageIndex] = false; // Hide loader for the current page
      currentPageIndex = index;
      isLoading[currentPageIndex] = true; // Show loader for the selected page
    });

    // Simulate a delay to showcase the loader
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        isLoading[currentPageIndex] =
            false; // Hide loader for the selected page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          children: <Widget>[
            if (!isLoading[currentPageIndex])
              Positioned.fill(
                  child: _pages[
                      currentPageIndex]), // Show the child widget when not loading
            if (isLoading[currentPageIndex])
              const Positioned.fill(
                child: Center(
                  child: SpinKitPouringHourGlassRefined(
                    color: AppColors.appThemeColor,
                    size: 30.0,
                  ),
                ),
              ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.small(
      //   // shape: const CircularNotchedRectangle(),
      //   backgroundColor: AppColors.blue,
      //   onPressed: () {},
      //   child: const Icon(
      //     Icons.send_outlined,
      //     size: 23,
      //     color: Colors.white,
      //   ),
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.appThemeColor,
        unselectedItemColor: const Color(0xff7BA0A3),
        selectedFontSize: 13,
        unselectedFontSize: 13,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
            fontFamily: "NeulisAlt", fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(
            fontFamily: "NeulisAlt", fontWeight: FontWeight.w300),
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
            onItemTapped(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  color: AppColors.yellow),
              child: SvgPicture.asset(
                'assets/navbar/menu_timeline.svg',
              ),
            ),
            icon: SvgPicture.asset(
              'assets/navbar/menu_timeline.svg',
            ),
            // const Icon(Icons.home),

            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  color: AppColors.yellow),
              child: SvgPicture.asset(
                'assets/navbar/menu_spends.svg',
                // height: 6,
              ),
            ),
            icon: SvgPicture.asset(
              'assets/navbar/menu_spends.svg',
            ),
            label: 'Spends',
          ),

          //
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                SvgPicture.asset(
                  'assets/navbar/menu_middle.svg',
                ),
              ],
            ),
            label: '',
          ),

          //
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  color: AppColors.yellow),
              child: SvgPicture.asset(
                'assets/navbar/menu_me.svg',
              ),
            ),
            icon: SvgPicture.asset(
              'assets/navbar/menu_me.svg',
            ),
            label: 'Me',
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: SvgPicture.asset(
                'assets/navbar/menu_more.svg',
              ),
            ),
            icon: SvgPicture.asset(
              'assets/navbar/menu_more.svg',
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
