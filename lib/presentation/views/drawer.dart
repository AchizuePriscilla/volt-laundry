import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/navigation/oops_args.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var drawerVM = context.read<DrawerVM>();
    return Drawer(
        child: Container(
            height: size.height,
            color: Palette.buttonColor,
            child: Column(
              children: [
                const CustomSpacer(flex: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const CustomSpacer(
                      flex: 2,
                      horizontal: true,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      color: Theme.of(context).primaryColorLight,
                      iconSize: 22.h,
                    ),
                    const CustomSpacer(
                      flex: 3,
                      horizontal: true,
                    ),
                    SizedBox(
                      height: 30.h,
                      width: 70.h,
                      child:
                          Image.asset('assets/images/volt_logo/volt_white.png'),
                    ),
                    const CustomSpacer(
                      flex: 1,
                      horizontal: true,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'LAUNDRY',
                        style: GoogleFonts.poppins(
                            fontStyle: FontStyle.italic,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ],
                ),
                const CustomSpacer(
                  flex: 8,
                ),
                DrawerMenuRow(
                  icon: IconlyLight.profile,
                  onTap: () {},
                  label: 'Profile',
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                DrawerMenuRow(
                  icon: Icons.local_offer_outlined,
                  onTap: () {
                    drawerVM.navigateToRoute(
                      oopsViewRoute,
                      arg: OopsArgs(message: 'Offer or Promotion'),
                    );
                  },
                  label: 'Offers and Promotions',
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                DrawerMenuRow(
                  icon: Icons.report_gmailerrorred_outlined,
                  onTap: () {},
                  label: 'Privacy policy',
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                DrawerMenuRow(
                  icon: Icons.settings_outlined,
                  onTap: () {},
                  label: 'Settings',
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                DrawerMenuRow(
                  icon: Icons.sticky_note_2_outlined,
                  onTap: () {},
                  label: 'About',
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                DrawerMenuRow(
                  icon: Icons.history_outlined,
                  onTap: () {},
                  label: 'History',
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.w),
                    child: const SupportContainer()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      child: Column(
                        children: [
                          const CustomSpacer(
                            flex: 2,
                          ),
                          Row(children: [
                            Text(
                              "Sign Out",
                              style: GoogleFonts.poppins(
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColorLight),
                            ),
                            const CustomSpacer(
                              flex: 6,
                              horizontal: true,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).primaryColorLight,
                              size: 18.h,
                            ),
                          ]),
                          const CustomSpacer(
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
