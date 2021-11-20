import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class LaundryView extends StatefulWidget {
  const LaundryView({Key? key}) : super(key: key);

  @override
  State<LaundryView> createState() => _LaundryViewState();
}

class _LaundryViewState extends State<LaundryView>
    with TickerProviderStateMixin {
  bool isWashAndIronDropdownVisible = false;
  bool isIroningDropdownVisible = false;
  bool isDrycleaningDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    var laundryDetailsVM = context.read<LaundryVM>();
    return ResponsiveWidget(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Laundry',
            style: GoogleFonts.lato(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Palette.blackColor),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomSpacer(
                    flex: 5,
                  ),
                  LaundryDropDown(
                    label: 'Wash & Iron',
                    isDropdownVisible: isWashAndIronDropdownVisible,
                    onPressed: () {
                      setState(() {
                        isWashAndIronDropdownVisible =
                            !isWashAndIronDropdownVisible;
                        isIroningDropdownVisible = false;
                        isDrycleaningDropdownVisible = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: isWashAndIronDropdownVisible,
                    child: Column(
                      children: [
                        LaundryOptionsContainer(
                          label: 'T-Shirts',
                          imagePath: 'shirt',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.tShirt);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Shorts',
                          imagePath: 'trousers',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Cardigans',
                          imagePath: 'cardigan',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Dresses',
                          imagePath: 'dress',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Home',
                          imagePath: 'home',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Others',
                          imagePath: 'tie',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  LaundryDropDown(
                    label: "Ironing",
                    isDropdownVisible: isIroningDropdownVisible,
                    onPressed: () {
                      setState(() {
                        isIroningDropdownVisible = !isIroningDropdownVisible;
                        isWashAndIronDropdownVisible = false;
                        isDrycleaningDropdownVisible = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: isIroningDropdownVisible,
                    child: Column(
                      children: [
                        LaundryOptionsContainer(
                          label: 'T-Shirts',
                          imagePath: 'shirt',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Shorts',
                          imagePath: 'trousers',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Cardigans',
                          imagePath: 'cardigan',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Dresses',
                          imagePath: 'dress',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Home',
                          imagePath: 'home',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Others',
                          imagePath: 'tie',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  LaundryDropDown(
                    label: 'Dry Cleaning',
                    isDropdownVisible: isDrycleaningDropdownVisible,
                    onPressed: () {
                      setState(() {
                        isDrycleaningDropdownVisible =
                            !isDrycleaningDropdownVisible;
                        isIroningDropdownVisible = false;
                        isWashAndIronDropdownVisible = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: isIroningDropdownVisible,
                    child: Column(
                      children: [
                        LaundryOptionsContainer(
                          label: 'T-Shirts',
                          imagePath: 'shirt',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Shorts',
                          imagePath: 'trousers',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Cardigans',
                          imagePath: 'cardigan',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Dresses',
                          imagePath: 'dress',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Home',
                          imagePath: 'home',
                          onTap: () {},
                        ),
                        LaundryOptionsContainer(
                          label: 'Others',
                          imagePath: 'tie',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const CustomSpacer(flex: 5),
                  Button(text: 'Process', onPressed: () {}),
                  const CustomSpacer(flex: 5),
                ],
              ),
            ),
          );
        });
  }
}

class LaundryDropDown extends StatelessWidget {
  const LaundryDropDown(
      {Key? key,
      required this.isDropdownVisible,
      required this.onPressed,
      required this.label})
      : super(key: key);

  final bool isDropdownVisible;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
              isDropdownVisible
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 22.h),
        )
      ],
    );
  }
}
