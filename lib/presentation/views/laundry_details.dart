import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class LaundryDetails extends StatefulWidget {
  final ClothType clothType;
  const LaundryDetails({Key? key, required this.clothType}) : super(key: key);

  @override
  _LaundryDetailsState createState() => _LaundryDetailsState();
}

class _LaundryDetailsState extends State<LaundryDetails> {
  final List<Color> colors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.white,
    Colors.black,
    Colors.lightGreen,
  ];

  List<Color> selectedColors = <Color>[];

  String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format.currencySymbol;
  }

  String selectedValue = 'Men';

  @override
  Widget build(BuildContext context) {
    var laundryDetailsVM = context.read<LaundryVM>();

    return ResponsiveWidget(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 70.h,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                laundryDetailsVM.getDesc(widget.clothType),
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
                      'assets/images/${laundryDetailsVM.getImagePath(widget.clothType)}.png')),
            ],
          ),
          leadingWidth: 30.w,
          leading: Container(
            margin: EdgeInsets.only(left: 10.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: Palette.blackColor,
              size: 25.w,
            ),
          ),
          elevation: 0,
        ),
        builder: (_, size) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    const CustomSpacer(
                      flex: 8,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: DropdownButtonFormField(
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                        icon: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₦300',
                              style: GoogleFonts.roboto(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).primaryColor),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                              // size: 24.w,
                            ),
                          ],
                        ),
                        style: GoogleFonts.lato(
                            fontSize: 18.sp,
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
                      flex: 6,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Color',
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
                              color: colors[index],
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
                      text: 'Add Cloth',
                      onPressed: () {},
                      color: Palette.lightGreen,
                    ),
                    const CustomSpacer(flex: 3),
                    Button(text: 'Process', onPressed: () {}),
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
