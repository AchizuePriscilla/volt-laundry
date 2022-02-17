import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class NoLaundryView extends StatelessWidget {
  const NoLaundryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const CustomSpacer(
            flex: 7,
          ),
          Center(
            child: SizedBox(
              child: Image.asset('assets/images/volt_laundry.png'),
            ),
          ),
          const CustomSpacer(
            flex: 2,
          ),
          Text(
            'No Laundries yet',
            style:
                GoogleFonts.lato(fontSize: 24.sp, fontWeight: FontWeight.w900),
          ),
          const CustomSpacer(
            flex: 2,
          ),
          Text(
            'Hit the button down below to start your laundry order',
            style:
                GoogleFonts.lato(fontSize: 17.sp, fontWeight: FontWeight.w500),
          ),
          const CustomSpacer(
            flex: 7,
          ),
          Button(
              text: 'Start Laundry',
              onPressed: () {
                context.read<HomeVM>().jumpToPage(2);
              })
        ],
      ),
    );
  }
}
