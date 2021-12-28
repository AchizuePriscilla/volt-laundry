import 'dart:math';

import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        resizeToAvoidBottomInset: true,
        builder: (_, size) {
          return SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                 const Expanded(child: SizedBox()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        const CustomSpacer(
                          flex: 2,
                          horizontal: true,
                        ),
                        Transform.rotate(
                          angle: -pi / 3,
                          child: Icon(
                            Icons.attachment,
                            size: 20.h,
                          ),
                        ),
                        const CustomSpacer(
                          flex: 1,
                          horizontal: true,
                        ),
                        Icon(Icons.bolt, size: 20.h),
                        const CustomSpacer(
                          flex: 2,
                          horizontal: true,
                        ),
                        SizedBox(
                          width: size.width * .6,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Send a message",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .disabledColor
                                      .withOpacity(.4),
                                ),
                                borderRadius: BorderRadius.circular(24.w),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(.4),
                                ),
                                borderRadius: BorderRadius.circular(24.w),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .disabledColor
                                      .withOpacity(.4),
                                ),
                                borderRadius: BorderRadius.circular(24.w),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Container(
                          width: 45.w,
                          height: 45.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette.buttonColor),
                          child: Icon(
                            Icons.forward,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        const CustomSpacer(
                          flex: 3,
                          horizontal: true,
                        )
                      ],
                    ),
                  ),
                  const CustomSpacer(
                    flex: 3,
                  )
                ],
              ));
        });
  }
}
