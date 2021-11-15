import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/src/provider.dart';
import 'package:volt/presentation/shared/responsive_widget.dart';
import 'package:volt/presentation/theme/palette.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/presentation/views/log_in_view.dart';
import 'package:volt/presentation/views/sign_up_view.dart';
import 'package:volt/presentation/views/views.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    var bottomBarVM = context.read<BottomNavBarVM>();
    bottomBarVM.init(_pageController);

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      bottomBarVM.jumpToPage(0);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      bottomNavigationBar: SizedBox(
        height: 70.h,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 27.w,
          selectedFontSize: 14.sp,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900),
          unselectedItemColor: Palette.buttonColor.withOpacity(.5),
          backgroundColor: const Color(0xffF8F8F8),
          elevation: 15,
          selectedItemColor: Palette.buttonColor,
          currentIndex: context.watch<BottomNavBarVM>().selectedIndex,
          onTap: (int page) {
            context.read<BottomNavBarVM>().jumpToPage(page);
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.home,
              ),
              activeIcon: Icon(
                IconlyBold.home,
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.location,
              ),
              activeIcon: Icon(
                IconlyBold.location,
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.local_laundry_service_outlined),
              activeIcon: Icon(Icons.local_laundry_service_rounded),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.wallet,
              ),
              activeIcon: Icon(
                IconlyBold.wallet,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 35.w,
                width: 35.w,
                decoration: BoxDecoration(
                    color: Palette.buttonColor.withOpacity(.2),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: EdgeInsets.all(3.2.w),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.buttonColor.withOpacity(.7),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/volt_laundry.png',
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
                  ),
                ),
              ),
              activeIcon: Container(
                height: 35.w,
                width: 35.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.buttonColor.withOpacity(.7),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.2.w),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.buttonColor.withOpacity(.7),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/volt_laundry.png',
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
                  ),
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
      builder: (_, size) {
        return PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePageView(),
            SignUpView(),
            LogInView(),
            SignUpView(),
            LogInView()
          ],
        );
      },
    );
  }
}