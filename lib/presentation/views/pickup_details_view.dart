import 'package:flutter/material.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/utils/utils.dart';

class PickupDetails extends StatefulWidget {
  const PickupDetails({Key? key}) : super(key: key);

  @override
  State<PickupDetails> createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<PickupDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        scaffoldKey: scaffoldKey,
        builder: (_, size) {
          return Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              image: const DecorationImage(
                image: AssetImage('assets/images/white_background.png'),
              ),
            ),
            child: Column(
              children: [
                const CustomSpacer(flex: 7),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Row(
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
                      Container(
                        height: 38.w,
                        width: 38.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.buttonColor.withOpacity(.7),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              'assets/images/me.jpg',
                              fit: BoxFit.cover,
                            ).image,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                PickupDetailsCard(),
              ],
            ),
          );
        });
  }
}

