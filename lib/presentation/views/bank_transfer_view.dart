import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class BankTransferView extends StatefulWidget {
  const BankTransferView({Key? key}) : super(key: key);

  @override
  State<BankTransferView> createState() => _BankTransferViewState();
}

class _BankTransferViewState extends State<BankTransferView> {
  bool rememberMe = false;
  void toggleRememberMe() {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'Bank Transfer',
        ),
        builder: (_, size) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Terms of bank transfer',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
                const CustomSpacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: toggleRememberMe,
                      child: Container(
                        alignment: Alignment.topCenter,
                        height: 10.h,
                        width: 10.h,
                        decoration: BoxDecoration(
                          color: rememberMe
                              ? Palette.buttonColor
                              : Theme.of(context).scaffoldBackgroundColor,
                          border: Border.all(
                            color: Palette.buttonColor,
                            width: 2,
                          ),
                        ),
                        child: rememberMe
                            ? Center(
                                child: Icon(Icons.check,
                                    size: 6.h, color: Colors.white))
                            : null,
                      ),
                    ),
                    const CustomSpacer(
                      flex: 1,
                      horizontal: true,
                    ),
                    const Text('Click to accept bank transfer terms')
                  ],
                ),
                const CustomSpacer(
                  flex: 4,
                ),
                const BankDetailsCard(
                  title: 'Bank:',
                  content: 'First Bank',
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                const BankDetailsCard(
                  title: 'Account Name:',
                  content: 'Volt Laundry Services',
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                const BankDetailsCard(
                  title: 'Account Number:',
                  content: '3132152805',
                  copyDetails: true,
                ),
                const Spacer(),
                Button(
                  text: 'Confirm Payment',
                  onPressed: () {},
                  color: Palette.lightGreen,
                ),
                const CustomSpacer(
                  flex: 20,
                )
              ],
            ),
          );
        });
  }
}

class BankDetailsCard extends StatelessWidget {
  const BankDetailsCard({
    Key? key,
    this.copyDetails = false,
    required this.title,
    required this.content,
  }) : super(key: key);
  final bool copyDetails;
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: copyDetails ? () {} : null,
      child: Container(
        constraints: BoxConstraints.tight(Size(
          MediaQuery.of(context).size.width,
          60.h,
        )),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(30.w),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff08141B).withOpacity(.05),
                spreadRadius: 7,
                blurRadius: 7,
                offset: const Offset(0, 15),
              )
            ]),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.w600),
                    ),
                    const CustomSpacer(
                      flex: 1,
                    ),
                    Text(
                      content,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ],
                ),
                const Spacer(),
                if (copyDetails) const Icon(Icons.copy)
              ],
            )),
      ),
    );
  }
}
