import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class LaundryView extends StatefulWidget {
  const LaundryView({Key? key}) : super(key: key);

  static bool isWashAndIronDropdownVisible = false;
  static bool isIroningDropdownVisible = false;
  static bool isDrycleaningDropdownVisible = false;

  @override
  State<LaundryView> createState() => _LaundryViewState();
}

class _LaundryViewState extends State<LaundryView> {
  @override
  Widget build(BuildContext context) {
    var laundryDetailsVM = context.read<LaundryVM>();
    return ResponsiveWidget(
        appBar: CustomAppBar(
          automaticallyLead: false,
          text: 'Laundry',
        ),
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LaundryDropDown(
                    label: 'Wash & Iron',
                    isDropdownVisible: LaundryView.isWashAndIronDropdownVisible,
                    onPressed: () {
                      setState(() {
                        LaundryView.isWashAndIronDropdownVisible =
                            !LaundryView.isWashAndIronDropdownVisible;
                        LaundryView.isIroningDropdownVisible = false;
                        LaundryView.isDrycleaningDropdownVisible = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: LaundryView.isWashAndIronDropdownVisible,
                    child: Column(
                      children: [
                        LaundryOptionsContainer(
                          label: 'T-Shirts',
                          imagePath: 'shirt',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.tShirt, ServiceType.washAndIron);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Shorts',
                          imagePath: 'trousers',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.shorts, ServiceType.washAndIron);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Cardigans',
                          imagePath: 'cardigan',
                          onTap: () {
                            laundryDetailsVM.navigateToLaundryDetailsView(
                                ClothType.cardigans, ServiceType.washAndIron);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Dresses',
                          imagePath: 'dress',
                          onTap: () {
                            laundryDetailsVM.navigateToLaundryDetailsView(
                                ClothType.dresses, ServiceType.washAndIron);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Home',
                          imagePath: 'home',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.home, ServiceType.washAndIron);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Others',
                          imagePath: 'tie',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.others, ServiceType.washAndIron);
                          },
                        ),
                      ],
                    ),
                  ),
                  LaundryDropDown(
                    label: "Ironing",
                    isDropdownVisible: LaundryView.isIroningDropdownVisible,
                    onPressed: () {
                      setState(() {
                        LaundryView.isIroningDropdownVisible =
                            !LaundryView.isIroningDropdownVisible;
                        LaundryView.isWashAndIronDropdownVisible = false;
                        LaundryView.isDrycleaningDropdownVisible = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: LaundryView.isIroningDropdownVisible,
                    child: Column(
                      children: [
                        LaundryOptionsContainer(
                          label: 'T-Shirts',
                          imagePath: 'shirt',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.tShirt, ServiceType.ironing);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Shorts',
                          imagePath: 'trousers',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.shorts, ServiceType.ironing);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Cardigans',
                          imagePath: 'cardigan',
                          onTap: () {
                            laundryDetailsVM.navigateToLaundryDetailsView(
                                ClothType.cardigans, ServiceType.ironing);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Dresses',
                          imagePath: 'dress',
                          onTap: () {
                            laundryDetailsVM.navigateToLaundryDetailsView(
                                ClothType.dresses, ServiceType.ironing);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Home',
                          imagePath: 'home',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.home, ServiceType.ironing);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Others',
                          imagePath: 'tie',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.others, ServiceType.ironing);
                          },
                        ),
                      ],
                    ),
                  ),
                  LaundryDropDown(
                    label: 'Dry Cleaning',
                    isDropdownVisible: LaundryView.isDrycleaningDropdownVisible,
                    onPressed: () {
                      setState(() {
                        LaundryView.isDrycleaningDropdownVisible =
                            !LaundryView.isDrycleaningDropdownVisible;
                        LaundryView.isIroningDropdownVisible = false;
                        LaundryView.isWashAndIronDropdownVisible = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: LaundryView.isDrycleaningDropdownVisible,
                    child: Column(
                      children: [
                        LaundryOptionsContainer(
                          label: 'T-Shirts',
                          imagePath: 'shirt',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.tShirt, ServiceType.dryCleaning);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Shorts',
                          imagePath: 'trousers',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.shorts, ServiceType.dryCleaning);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Cardigans',
                          imagePath: 'cardigan',
                          onTap: () {
                            laundryDetailsVM.navigateToLaundryDetailsView(
                                ClothType.cardigans, ServiceType.dryCleaning);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Dresses',
                          imagePath: 'dress',
                          onTap: () {
                            laundryDetailsVM.navigateToLaundryDetailsView(
                                ClothType.dresses, ServiceType.dryCleaning);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Home',
                          imagePath: 'home',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.home, ServiceType.dryCleaning);
                          },
                        ),
                        LaundryOptionsContainer(
                          label: 'Others',
                          imagePath: 'tie',
                          onTap: () {
                            laundryDetailsVM
                                .navigateToLaundryDetailsView(ClothType.others, ServiceType.dryCleaning);
                          },
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
