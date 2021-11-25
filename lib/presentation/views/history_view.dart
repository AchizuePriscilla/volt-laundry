import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'History',
        ),
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            height: size.height,
            width: size.width,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    height: 30.h,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  'Wash & Iron',
                                  style: GoogleFonts.lato(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic),
                                ),
                                const CustomSpacer(
                                  flex: 2,
                                  horizontal: true,
                                ),
                                Text(
                                  'KGHJIJD',
                                  style: GoogleFonts.lato(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic),
                                )
                              ]),
                              const CustomSpacer(
                                flex: 2,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '4 Shirts, 6 Trousers',
                                    style: GoogleFonts.lato(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const CustomSpacer(
                                    flex: 2,
                                    horizontal: true,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                    width: 47.h,
                                    // color: Colors.black,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Container(
                                          width: 11.h,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Container(
                                          width: 11.h,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        Container(
                                          width: 11.h,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                        Text(
                          '8,000',
                          style: GoogleFonts.lato(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: 5),
          );
        });
  }
}
