import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/models/navigation/delivery_details_args.dart';
import 'dart:io';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class LaundryDetails extends StatefulWidget {
  final ClothType clothType;
  final ServiceType serviceType;
  const LaundryDetails(
      {Key? key, required this.clothType, required this.serviceType})
      : super(key: key);

  @override
  _LaundryDetailsState createState() => _LaundryDetailsState();
}

class _LaundryDetailsState extends State<LaundryDetails> {
  final List<int> colors = <int>[
    0xffffffff,
    0xff000000,
    0xffff9800,
    0xffffeb3b,
    0xff4caf50,
    0xff9c27b0,
    0xfff44336,
    0xff2196f3,
    0xff8bc34a,
  ];

  final TextEditingController _descriptionController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  List<int> selectedColors = <int>[];

  String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format.currencySymbol;
  }

  String selectedValue = 'Men';
  int _numberOfClothes = 0;

  void _incrementCloth() {
    setState(() {
      _numberOfClothes++;
    });
  }

  void _decrementCloth() {
    setState(() {
      _numberOfClothes == 0 ? null : _numberOfClothes--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var laundryVM = context.read<LaundryVM>();
    var rxLaundryVM = context.watch<LaundryVM>();

    return ResponsiveWidget(
        resizeToAvoidBottomInset: true,
        scaffoldKey: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 70.h,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                laundryVM.getDesc(widget.clothType),
                style: GoogleFonts.lato(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Palette.blackColor),
              ),
              const CustomSpacer(
                flex: 2,
                horizontal: true,
              ),
              SizedBox(
                  height: 25.h,
                  child: Image.asset(
                      'assets/images/${laundryVM.getImagePath(widget.clothType)}.png')),
            ],
          ),
          leadingWidth: 30.w,
          leading: Container(
              margin: EdgeInsets.only(left: 10.w),
              child: const CustomBackButton()),
          elevation: 0,
        ),
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    const CustomSpacer(
                      flex: 8,
                    ),
                    SizedBox(
                      height: 44.h,
                      child: DropdownButtonFormField(
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          // size: 24.w,
                        ),
                        style: GoogleFonts.lato(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffC7C7C7),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                        items: [
                          'Men',
                          'Women',
                        ].map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const CustomSpacer(
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Number of clothes',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                        const CustomSpacer(
                          flex: 2,
                          horizontal: true,
                        ),
                        Container(
                          height: 22.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    _decrementCloth();
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    size: 14.w,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                Text(_numberOfClothes.toString(),
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    )),
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    _incrementCloth();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 14.w,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                    const CustomSpacer(
                      flex: 6,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Color(s)',
                        style: GoogleFonts.lato(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).disabledColor),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: colors.length,
                          itemBuilder: (context, index) {
                            return ColorSelectorCircle(
                              color: Color(colors[index]),
                              selectedIndex: index,
                              onSelect: (bool value) {
                                setState(() {
                                  if (value) {
                                    selectedColors.add(colors[index]);
                                  } else {
                                    selectedColors.remove(colors[index]);
                                  }
                                });
                              },
                            );
                          }),
                    ),
                    const CustomSpacer(flex: 4),
                    TextField(
                      maxLines: 7,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffC7C7C7),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        hintText: 'Cloth Description',
                        hintStyle: GoogleFonts.lato(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const CustomSpacer(
                      flex: 6,
                    ),
                    Button(
                      text: 'Add to cart',
                      loading: context.watch<CartVM>().loading,
                      onPressed: () async {
                        if (_numberOfClothes != 0 &&
                            selectedColors.isNotEmpty) {
                          await context.read<CartVM>().addToCart(
                              scaffoldKey: _scaffoldKey,
                              description: _descriptionController.text.isEmpty
                                  ? ''
                                  : _descriptionController.text,
                              clothType: widget.clothType,
                              wearColor: selectedColors,
                              wearTotal: _numberOfClothes,
                              amount: _numberOfClothes * 50,
                              serviceType: widget.serviceType);
                          locator<NavigationHandler>()
                              .popAndPushNamed(cartViewRoute);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: SizedBox(
                                height: 30.h,
                                child: Center(
                                  child: Text(
                                    'Select at least a color and add at least one cloth',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      color: Palette.lightGreen,
                    ),
                    const CustomSpacer(flex: 3),
                    Button(
                        text: 'Proceed',
                        loading: rxLaundryVM.loading,
                        onPressed: () async {
                          if (_numberOfClothes != 0 &&
                              selectedColors.isNotEmpty) {
                            laundryVM.updateValues(
                                clothType: widget.clothType,
                                description: _descriptionController.text.isEmpty
                                    ? ''
                                    : _descriptionController.text,
                                total: _numberOfClothes * 50,
                                colors: selectedColors,
                                serviceType: widget.serviceType);
                            laundryVM.navigateToRoute(deliveryDetailsViewRoute,
                                args: DeliveryDetailsArgs(
                                    numberOfWears: _numberOfClothes));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: SizedBox(
                                  height: 30.h,
                                  child: Center(
                                    child: Text(
                                      'Select at least a color and add at least one cloth',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                    const CustomSpacer(flex: 3),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class ColorSelectorCircle extends StatefulWidget {
  const ColorSelectorCircle(
      {Key? key,
      required this.color,
      required this.selectedIndex,
      required this.onSelect})
      : super(key: key);

  final Color color;
  final int? selectedIndex;
  final ValueChanged<bool> onSelect;

  @override
  State<ColorSelectorCircle> createState() => _ColorSelectorCircleState();
}

class _ColorSelectorCircleState extends State<ColorSelectorCircle> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          selected = !selected;
          widget.onSelect(selected);
        });
      },
      child: Container(
          margin: EdgeInsets.all(7.w),
          height: 30.h,
          width: 30.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
              border: widget.color == Colors.white
                  ? Border.all(color: Colors.black, width: 1)
                  : null),
          child: selected
              ? Icon(
                  Icons.check,
                  color: widget.color == Colors.white
                      ? Palette.blackColor
                      : Colors.white,
                  size: 20.h,
                )
              : null),
    );
  }
}
