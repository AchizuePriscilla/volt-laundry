import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/views/views.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: _promotionContainers.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      scaffoldKey: scaffoldKey,
      drawer: SizedBox(
          width: MediaQuery.of(context).size.width * .92,
          child: const CustomDrawer()),
      builder: (_, size) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 25.w),
            color: Theme.of(context).primaryColorLight,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSpacer(flex: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: ImageIcon(
                          const AssetImage('assets/images/hamburger.png'),
                          color: Colors.black,
                          size: 20.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 25.w),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 20.h,
                          color: const Color(0xff000000).withOpacity(.25),
                        ),
                      ),
                    ],
                  ),
                  const CustomSpacer(flex: 3),
                  RichText(
                    text: TextSpan(
                        text: 'Welcome  ',
                        style: GoogleFonts.lato(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor),
                        children: const [
                          TextSpan(
                              text: 'Back',
                              style: TextStyle(color: Palette.buttonColor))
                        ]),
                  ),
                  const CustomSpacer(
                    flex: 3,
                  ),
                  SizedBox(
                    height: 180.h,
                    child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: const [
                          HomeMenuContainer(
                            label: 'Ironing',
                            imagePath: 'iron',
                          ),
                          HomeMenuContainer(
                            label: 'Wash & Iron',
                            imagePath: 'wash_and_iron',
                          ),
                          HomeMenuContainer(
                            label: 'Ironing',
                            imagePath: 'iron',
                          ),
                        ]),
                  ),
                  const CustomSpacer(
                    flex: 5,
                  ),
                  Text(
                    'Promotions',
                    style: GoogleFonts.lato(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(
                    height: 160.h,
                    child: PageView.builder(
                      onPageChanged: (index) {
                        tabController!.index = index;
                      },
                      itemBuilder: (context, index) {
                        return _promotionContainers[index];
                      },
                      itemCount: _promotionContainers.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const CustomSpacer(
                    flex: 2,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TabPageSelector(
                      controller: tabController,
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(.4),
                      selectedColor: Palette.buttonColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

List<Widget> _promotionContainers = const <Widget>[
  PromotionsContainer(
    imagePath: 'volt_arena',
  ),
  PromotionsContainer(
    imagePath: 'volt_arena',
  ),
  PromotionsContainer(
    imagePath: 'volt_arena',
  )
];
